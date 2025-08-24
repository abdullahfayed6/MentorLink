import pandas as pd
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import requests
import logging
from typing import List
from .config import config
import re

logger = logging.getLogger(__name__)

class MentorService:
    def __init__(self):
        self.df = None
        self.model = None
        self.embeddings = None
        self._load_data()
        self._load_model()
        self._generate_embeddings()

    def _load_data(self):
        try:
            self.df = pd.read_csv(config.MENTORS_CSV_PATH)
            logger.info(f"Loaded {len(self.df)} mentors from {config.MENTORS_CSV_PATH}")
        except Exception as e:
            logger.error(f"Failed to load mentor data: {e}")
            raise

    def _load_model(self):
        try:
            self.model = SentenceTransformer(config.EMBEDDING_MODEL)
            logger.info(f"Loaded embedding model: {config.EMBEDDING_MODEL}")
        except Exception as e:
            logger.error(f"Failed to load embedding model: {e}")
            raise

    def _generate_embeddings(self):
        try:
            mentor_profiles = self.df["MentorProfile"].tolist()
            self.embeddings = self.model.encode(mentor_profiles, show_progress_bar=False)
            logger.info(f"Generated embeddings for {len(mentor_profiles)} mentor profiles")
        except Exception as e:
            logger.error(f"Failed to generate embeddings: {e}")
            raise

    def _generate_reasoning(self, mentor_profile: str, student_query: str) -> str:
        try:
            headers = {
                "Authorization": f"Bearer {config.DEEPSEEK_API_KEY}",
                "Content-Type": "application/json"
            }
            prompt = f"Given the mentor profile: '{mentor_profile}', explain why this mentor is a good match for the student's query: '{student_query}'. Provide a concise reasoning."
            payload = {
                "model": "deepseek-chat",
                "messages": [
                    {"role": "system", "content": "You are a helpful assistant for mentor recommendation."},
                    {"role": "user", "content": prompt}
                ],
                "temperature": 0.7
            }
            response = requests.post(config.DEEPSEEK_API_URL, headers=headers, json=payload)
            response.raise_for_status()
            result = response.json()
            return result["choices"][0]["message"]["content"]
        except Exception as e:
            logger.error(f"Error generating reasoning: {e}")
            return f"This mentor appears to be a good match based on their profile and your requirements: {student_query}"

    def search_mentors(self, query: str, limit: int = 3, filter_available: bool = True) -> List[dict]:
        try:
            logger.info(f"Starting search for query: '{query}' with limit: {limit}, filter_available: {filter_available}")
            query_embedding = self.model.encode([query])
            logger.info(f"Generated query embedding with shape: {query_embedding.shape}")
            similarities = cosine_similarity(query_embedding, self.embeddings)[0]
            logger.info(f"Calculated similarities for {len(similarities)} mentors")
            logger.info(f"Similarity scores range: min={similarities.min():.4f}, max={similarities.max():.4f}")
            mentor_scores = []
            available_count = 0
            unavailable_count = 0
            for idx, score in enumerate(similarities):
                mentor_row = self.df.iloc[idx]
                mentor_text = mentor_row["MentorProfile"]
                name = mentor_text.split(" is ")[0].strip() if " is " in mentor_text else f"Mentor {idx+1}"
                email_name = name.lower().replace(" ", ".").replace("dr.", "").replace("prof.", "").replace("eng.", "").strip()
                email = f"{email_name}@mentor.com"
                mentor_lower = mentor_text.lower()
                if "part_time" in mentor_lower:
                    availability = "Part-time"
                elif "unavailable" in mentor_lower:
                    availability = "Unavailable"
                else:
                    availability = "Available"
                rate = None
                if "$" in mentor_text:
                    rate_match = re.search(r'\$(\d+\.?\d*)\s*USD', mentor_text)
                    if rate_match:
                        rate = f"${rate_match.group(1)} USD"
                if idx < 5:
                    logger.info(f"Mentor {idx}: {name}, availability: '{availability}', score: {score:.4f}")
                available_statuses = ["available", "part-time", "full-time"]
                is_available = availability.lower() in available_statuses
                if is_available:
                    available_count += 1
                else:
                    unavailable_count += 1
                if filter_available and not is_available:
                    continue
                mentor_scores.append({
                    "index": idx,
                    "mentor_id": idx + 1,
                    "mentor_name": name,
                    "email": email,
                    "availability": availability,
                    "mentorship_rate": rate,
                    "similarity_score": float(score),
                    "profile": mentor_row["MentorProfile"]
                })
            logger.info(f"Found {available_count} available mentors, {unavailable_count} unavailable mentors")
            logger.info(f"After filtering: {len(mentor_scores)} mentors to consider")
            mentor_scores.sort(key=lambda x: x["similarity_score"], reverse=True)
            top_mentors = mentor_scores[:limit]
            logger.info(f"Selected top {len(top_mentors)} mentors")
            for i, mentor in enumerate(top_mentors):
                logger.info(f"Generating reasoning for mentor {i+1}: {mentor['mentor_name']}")
                mentor["reasoning"] = self._generate_reasoning(mentor["profile"], query)
                del mentor["profile"]
                del mentor["similarity_score"]
            logger.info(f"Returning {len(top_mentors)} mentor recommendations")
            return top_mentors
        except Exception as e:
            logger.error(f"Error searching mentors: {e}")
            raise

    def get_stats(self) -> dict:
        total_mentors = len(self.df)
        available_count = 0
        part_time_count = 0
        unavailable_count = 0
        for idx in range(total_mentors):
            mentor_row = self.df.iloc[idx]
            mentor_text = mentor_row["MentorProfile"].lower()
            if "part_time" in mentor_text:
                part_time_count += 1
            elif "unavailable" in mentor_text:
                unavailable_count += 1
            else:
                available_count += 1
        return {
            "total_mentors": total_mentors,
            "available_mentors": available_count,
            "part_time_mentors": part_time_count,
            "unavailable_mentors": unavailable_count
        }



"""
Learning Plan Service for generating personalized learning paths
"""

import logging
import time
import os
import csv
from pathlib import Path
from typing import Dict, Any, List, Optional

from app.models.schemas import UserInput, LearningPlan
from app.core.deepseek_client import get_deepseek_client

logger = logging.getLogger(__name__)

class LearningPlanService:
    """Service for generating personalized learning plans"""
    
    def __init__(self):
        """Initialize the learning plan service"""
        self.deepseek_client = get_deepseek_client()
        self.data_path = Path("data")
        self.docs_path = self.data_path / "docs_learning_path"
        self.courses_path = self.data_path / "Coureses" / "courses.csv"
    
    async def generate_learning_plan(self, user_input: UserInput) -> Dict[str, Any]:
        """
        Generate a personalized learning plan
        
        Args:
            user_input: User requirements and preferences
            
        Returns:
            Generated learning plan
        """
        try:
            # Get relevant content based on user's track and focus areas
            context = self._get_relevant_content(user_input)
            
            # Create user query from input
            user_query = self._create_user_query(user_input)
            
            # Generate plan using DeepSeek API
            plan_dict = await self.deepseek_client.generate_learning_plan_json(
                user_query=user_query,
                context=context
            )
            
            # Enrich with course links if available
            try:
                plan_dict = self._enrich_recommended_courses_with_links(plan_dict)
            except Exception as enrich_err:
                logger.warning(f"Could not enrich course links: {enrich_err}")

            return plan_dict
            
        except Exception as e:
            logger.error(f"Error generating plan with DeepSeek: {e}")
            return self._create_fallback_plan(user_input)
    
    def _get_relevant_content(self, user_input: UserInput) -> str:
        """Get relevant content by reading files directly based on user track and focus areas"""
        relevant_docs = []
        
        if not self.docs_path.exists():
            logger.warning(f"Documentation path not found: {self.docs_path}")
            return ""
        
        # Load all learning path markdown files
        for doc_file in self.docs_path.glob("*.md"):
            try:
                # Check if document is relevant to user's requirements
                if self._is_relevant_document(doc_file, user_input):
                    with open(doc_file, 'r', encoding='utf-8') as f:
                        content = f.read()
                        relevant_docs.append(f"=== {doc_file.stem} ===\n{content[:2000]}")  # Limit content
            except Exception as e:
                logger.warning(f"Error reading {doc_file}: {e}")
        
        return "\n\n".join(relevant_docs[:5])  # Limit to 5 most relevant docs
    
    def _is_relevant_document(self, doc_file: Path, user_input: UserInput) -> bool:
        """Check if content is relevant to user's requirements"""
        filename = doc_file.stem.lower()
        track_keywords = self._get_track_keywords(user_input.track)
        focus_keywords = [area.lower().replace(" ", "_") for area in user_input.focus_areas] if user_input.focus_areas else []
        
        # Check if filename contains relevant keywords
        all_keywords = track_keywords + focus_keywords
        return any(keyword in filename for keyword in all_keywords)
    
    def _get_track_keywords(self, track: str) -> List[str]:
        """Get relevant keywords for a track"""
        track_map = {
            "Software Development": ["programming", "software", "development", "coding", "python", "javascript", "java"],
            "Data Science": ["data", "science", "machine_learning", "analytics", "python", "statistics"],
            "Web Development": ["web", "frontend", "backend", "html", "css", "javascript", "react", "nodejs"],
            "Mobile Development": ["mobile", "android", "ios", "app", "development"],
            "DevOps": ["devops", "docker", "kubernetes", "cloud", "aws", "deployment"],
            "Cybersecurity": ["security", "cybersecurity", "network", "encryption"],
            "UI/UX Design": ["design", "ui", "ux", "user", "interface"],
            "Database": ["database", "sql", "mongodb", "data"]
        }
        return track_map.get(track, [track.lower().replace(" ", "_")])
    
    def _create_user_query(self, user_input: UserInput) -> str:
        """Create a comprehensive user query from input"""
        query_parts = [
            f"Track: {user_input.track}",
            f"Current Level: {user_input.current_level}",
            f"Goal: {user_input.goal}"
        ]
        
        if user_input.focus_areas:
            query_parts.append(f"Focus Areas: {', '.join(user_input.focus_areas)}")
        
        if user_input.time_commitment:
            query_parts.append(f"Time Commitment: {user_input.time_commitment}")
        
        if user_input.preferred_format:
            query_parts.append(f"Preferred Format: {user_input.preferred_format}")
        
        return " | ".join(query_parts)
    
    def _enrich_recommended_courses_with_links(self, plan_dict: Dict[str, Any]) -> Dict[str, Any]:
        """
        Load course title to URL mappings from local datasets (Coursera CSV).
        Find a URL for a given course title using simple normalization and containment search.
        Append valid links to recommended_courses entries without changing the schema (List[str]).
        
        Example transformation: "Data Science Capstone" -> "Data Science Capstone - https://..."
        """
        if not self.courses_path.exists():
            logger.warning(f"Courses CSV not found: {self.courses_path}")
            return plan_dict
        
        try:
            # Load course mappings
            course_mappings = {}
            with open(self.courses_path, 'r', encoding='utf-8') as f:
                reader = csv.DictReader(f)
                for row in reader:
                    title = row.get('Course Name', '').strip()
                    url = row.get('Course URL', '').strip()
                    if title and url:
                        course_mappings[title.lower()] = url
            
            # Enrich recommended courses
            if 'recommended_courses' in plan_dict and isinstance(plan_dict['recommended_courses'], list):
                enriched_courses = []
                for course in plan_dict['recommended_courses']:
                    if isinstance(course, str):
                        # Find matching URL
                        course_lower = course.lower()
                        found_url = None
                        
                        # Try exact match first
                        if course_lower in course_mappings:
                            found_url = course_mappings[course_lower]
                        else:
                            # Try partial match
                            for title, url in course_mappings.items():
                                if any(word in title for word in course_lower.split() if len(word) > 3):
                                    found_url = url
                                    break
                        
                        # Append URL if found
                        if found_url:
                            enriched_courses.append(f"{course} - {found_url}")
                        else:
                            enriched_courses.append(course)
                    else:
                        enriched_courses.append(course)
                
                plan_dict['recommended_courses'] = enriched_courses
        
        except Exception as e:
            logger.error(f"Error enriching courses with links: {e}")
        
        return plan_dict
    
    def _create_fallback_plan(self, user_input: UserInput) -> Dict[str, Any]:
        """Create a basic fallback plan when API fails"""
        return {
            "track": user_input.track,
            "current_level": user_input.current_level,
            "goal": user_input.goal,
            "estimated_duration": "12-16 weeks",
            "prerequisites": ["Basic computer literacy"],
            "learning_objectives": [
                f"Master fundamental concepts in {user_input.track}",
                "Build practical projects",
                "Develop industry-relevant skills"
            ],
            "recommended_courses": [
                f"Introduction to {user_input.track}",
                f"Intermediate {user_input.track} Concepts",
                f"Advanced {user_input.track} Projects"
            ],
            "projects": [
                f"Beginner {user_input.track} Project",
                f"Intermediate {user_input.track} Application",
                f"Capstone {user_input.track} Project"
            ],
            "resources": [
                "Online documentation",
                "Community forums",
                "Practice platforms"
            ],
            "milestones": [
                {
                    "week": 4,
                    "title": "Foundation Complete",
                    "description": "Complete basic concepts and first project"
                },
                {
                    "week": 8,
                    "title": "Intermediate Skills",
                    "description": "Build intermediate-level projects"
                },
                {
                    "week": 12,
                    "title": "Advanced Application",
                    "description": "Complete capstone project"
                }
            ],
            "skills_gained": [
                f"Core {user_input.track} skills",
                "Project development",
                "Problem-solving",
                "Best practices"
            ]
        }
    
    def get_available_tracks(self) -> List[str]:
        """Get list of available learning tracks"""
        return [
            "Software Development",
            "Data Science", 
            "Web Development",
            "Mobile Development",
            "DevOps",
            "Cybersecurity",
            "UI/UX Design",
            "Database Management",
            "Cloud Computing",
            "Machine Learning"
        ]

def get_learning_plan_service() -> LearningPlanService:
    """
    Factory function to get a learning plan service instance
    
    Returns:
        LearningPlanService instance
    """
    return LearningPlanService()

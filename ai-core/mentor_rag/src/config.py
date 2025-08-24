import os
from dotenv import load_dotenv
from pydantic import BaseModel, Field
from typing import List, Optional

load_dotenv()

class Config:
    DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")
    DEEPSEEK_API_URL = os.getenv("DEEPSEEK_API_URL", "https://api.deepseek.com/v1/chat/completions")
    
    EMBEDDING_MODEL = os.getenv("EMBEDDING_MODEL", "all-MiniLM-L6-v2")
    
    MENTORS_CSV_PATH = os.getenv("MENTORS_CSV_PATH", "../data/mentors.csv")
    
    API_HOST = os.getenv("API_HOST", "127.0.0.1")
    API_PORT = int(os.getenv("API_PORT", 6050))
    
    @classmethod
    def validate(cls):
        if not cls.DEEPSEEK_API_KEY:
            raise ValueError("DEEPSEEK_API_KEY is required but not set in environment")
        
        if not os.path.exists(cls.MENTORS_CSV_PATH):
            raise FileNotFoundError(f"Mentors CSV file not found: {cls.MENTORS_CSV_PATH}")

class MentorQuery(BaseModel):
    query: str = Field(..., description="Student's query describing desired mentor characteristics")
    limit: int = Field(default=3, ge=1, le=10, description="Maximum number of mentors to return")
    filter_available: bool = Field(default=True, description="Whether to filter only available mentors")

class MentorRecommendation(BaseModel):
    mentor_id: int = Field(..., description="Unique identifier for the mentor")
    mentor_name: str = Field(..., description="Name of the mentor")
    email: str = Field(..., description="Email address of the mentor")
    availability: str = Field(..., description="Mentor's availability status")
    mentorship_rate: Optional[str] = Field(None, description="Mentor's hourly rate")
    reasoning: str = Field(..., description="AI-generated reasoning for the recommendation")

class MentorSearchResponse(BaseModel):
    query: str = Field(..., description="Original search query")
    total_mentors_found: int = Field(..., description="Total number of mentors found")
    recommendations: List[MentorRecommendation] = Field(..., description="List of mentor recommendations")

class HealthCheck(BaseModel):
    status: str = Field(..., description="Service status")
    message: str = Field(..., description="Health check message")

config = Config()

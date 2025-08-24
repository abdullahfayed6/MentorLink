"""
MentorAI - Simple Direct API Implementation
Direct connection to DeepSeek API without LlamaIndex complexity
"""

import asyncio
import logging
import json
from typing import Dict, Any, Optional
from dataclasses import dataclass, field
import httpx

from .config import config
from .prompts import PromptTemplates

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@dataclass
class MentorResponse:
    """Simple response structure"""
    content: str
    topic: Optional[str] = None
    confidence: float = 1.0
    suggested_followups: list = field(default_factory=list)
    resources: list = field(default_factory=list)
    metadata: Dict[str, Any] = field(default_factory=dict)

class MentorAI:
    """Simple MentorAI using direct DeepSeek API calls"""
    
    def __init__(self):
        """Initialize with DeepSeek API settings"""
        self.api_key = config.DEEPSEEK_API_KEY
        self.api_url = f"{config.DEEPSEEK_BASE_URL}/chat/completions"
        self.model_name = config.MODEL_NAME
        self.max_tokens = config.MAX_TOKENS
        self.temperature = config.TEMPERATURE
        self.prompt_templates = PromptTemplates()
        
        if not self.api_key:
            raise ValueError("DEEPSEEK_API_KEY is required")
        
        logger.info(f"MentorAI initialized with model: {self.model_name}")
        logger.info(f"API URL: {self.api_url}")
        logger.info(f"API Key present: {'Yes' if self.api_key else 'No'}")
        logger.info(f"API Key length: {len(self.api_key) if self.api_key else 0}")
    
    async def chat(self, user_input: str, session_id: Optional[str] = None) -> MentorResponse:
        """Process user input and generate response"""
        try:
            headers = {
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            }
            
            enhanced_user_prompt = self.prompt_templates.create_enhanced_prompt(
                user_query=user_input,
                context="",
                conversation_history=None,
                category="general",
            )

            payload = {
                "model": self.model_name,
                "messages": [
                    {"role": "system", "content": self.prompt_templates.get_system_prompt()},
                    {"role": "user", "content": enhanced_user_prompt},
                ],
                "max_tokens": self.max_tokens,
                "temperature": self.temperature,
            }
            
            async with httpx.AsyncClient(timeout=60.0) as client:
                response = await client.post(
                    self.api_url,
                    headers=headers,
                    json=payload
                )
                
                if response.status_code != 200:
                    error_msg = f"API Error {response.status_code}: {response.text}"
                    logger.error(error_msg)
                    return MentorResponse(
                        content="Sorry, I encountered an error. Please try again.",
                        confidence=0.0,
                        metadata={"error": error_msg}
                    )
                
                data = response.json()
                ai_response = data["choices"][0]["message"]["content"]
                
                return MentorResponse(
                    content=ai_response,
                    topic=self._extract_topic(ai_response),
                    confidence=0.9,
                    suggested_followups=[], 
                    resources=[],  
                    metadata={
                        "tokens_used": data.get("usage", {}).get("total_tokens", 0),
                        "model": self.model_name,
                        "session_id": session_id
                    }
                )
                
        except Exception as e:
            logger.error(f"Error in chat: {e}")
            return MentorResponse(
                content="I apologize, but I encountered an error processing your request. Please try again.",
                confidence=0.0,
                metadata={"error": str(e)}
            )
    
    def _extract_topic(self, content: str) -> Optional[str]:
        """Simple topic extraction"""
        content_lower = content.lower()
        
        if any(word in content_lower for word in ["python", "django", "flask"]):
            return "Python"
        elif any(word in content_lower for word in ["javascript", "react", "vue", "html", "css"]):
            return "Web Development"
        elif any(word in content_lower for word in ["machine learning", "ai", "data science"]):
            return "AI/ML"
        elif any(word in content_lower for word in ["database", "sql", "mongodb"]):
            return "Database"
        elif any(word in content_lower for word in ["algorithm", "data structure"]):
            return "Algorithms"
        else:
            return "General"
    
    async def health_check(self) -> Dict[str, Any]:
        """Simple health check"""
        try:
            headers = {
                "Authorization": f"Bearer {self.api_key}",
                "Content-Type": "application/json"
            }
            
            payload = {
                "model": self.model_name,
                "messages": [
                    {"role": "user", "content": "Hello"}
                ],
                "max_tokens": 10
            }
            
            async with httpx.AsyncClient(timeout=30.0) as client:
                response = await client.post(
                    self.api_url,
                    headers=headers,
                    json=payload
                )
                
                if response.status_code == 200:
                    return {
                        "status": "healthy",
                        "model": self.model_name,
                        "api_accessible": True
                    }
                else:
                    error_msg = f"API returned {response.status_code}: {response.text}"
                    logger.error(f"Health check API error: {error_msg}")
                    return {
                        "status": "unhealthy",
                        "model": self.model_name,
                        "api_accessible": False,
                        "error": error_msg
                    }
                    
        except Exception as e:
            error_msg = f"Health check failed: {str(e)}"
            logger.error(error_msg)
            return {
                "status": "unhealthy",
                "model": self.model_name,
                "api_accessible": False,
                "error": error_msg
            }

_mentor_instance = None

async def get_mentor_ai() -> MentorAI:
    """Get or create MentorAI instance"""
    global _mentor_instance
    if _mentor_instance is None:
        _mentor_instance = MentorAI()
        health = await _mentor_instance.health_check()
        logger.info(f"Health check result: {health}")
        if health.get("status") != "healthy":
            error_msg = health.get('error', 'Unknown error')
            logger.error(f"Health check failed with error: {error_msg}")
            raise Exception(f"Failed to initialize MentorAI: {error_msg}")
    return _mentor_instance

async def initialize_mentor_ai() -> MentorAI:
    """Initialize and return MentorAI instance"""
    try:
        mentor = await get_mentor_ai()
        logger.info("✅ MentorAI initialized successfully")
        return mentor
    except Exception as e:
        logger.error(f"❌ Failed to initialize MentorAI: {e}")
        raise Exception(f"Failed to initialize MentorAI: {e}")

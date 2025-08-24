"""
MentorAI Configuration Module
Professional configuration management for the AI mentor system.
"""

import os
from typing import Dict, Any
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

class Config:
    """Configuration class for MentorAI"""
    
    # API Configuration
    DEEPSEEK_API_KEY = os.getenv("DEEPSEEK_API_KEY")
    DEEPSEEK_BASE_URL = os.getenv("DEEPSEEK_BASE_URL", "https://api.deepseek.com/v1")
    
    # Model Configuration
    MODEL_NAME = os.getenv("MODEL_NAME", "deepseek-chat")
    MAX_TOKENS = int(os.getenv("MAX_TOKENS", "4000"))
    TEMPERATURE = float(os.getenv("TEMPERATURE", "0.9"))
    CONTEXT_WINDOW = int(os.getenv("CONTEXT_WINDOW", "32000"))
    
    # Application Configuration
    APP_NAME = os.getenv("APP_NAME", "MentorAI")
    VERSION = os.getenv("VERSION", "1.0.0")
    DEBUG = os.getenv("DEBUG", "True").lower() == "true"
    
    @classmethod
    def validate(cls) -> bool:
        """Validate configuration"""
        if not cls.DEEPSEEK_API_KEY:
            raise ValueError("DEEPSEEK_API_KEY is required")
        return True
    
    @classmethod
    def to_dict(cls) -> Dict[str, Any]:
        """Convert configuration to dictionary"""
        return {
            "api_key": cls.DEEPSEEK_API_KEY[:5] + "..." if cls.DEEPSEEK_API_KEY else None,
            "base_url": cls.DEEPSEEK_BASE_URL,
            "model_name": cls.MODEL_NAME,
            "max_tokens": cls.MAX_TOKENS,
            "temperature": cls.TEMPERATURE,
            "context_window": cls.CONTEXT_WINDOW,
            "app_name": cls.APP_NAME,
            "version": cls.VERSION,
            "debug": cls.DEBUG
        }

# Initialize and validate configuration
config = Config()
config.validate()

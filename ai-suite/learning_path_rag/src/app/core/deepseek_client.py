

"""
DeepSeek API client for learning path generation
"""

import os
import logging
import json
from typing import Any, Dict, Optional
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

logger = logging.getLogger(__name__)

class DeepSeekClient:
    """Client for interacting with DeepSeek API"""
    
    def __init__(self):
        """Initialize DeepSeek client with API configuration"""
        self.api_key = os.getenv("DEEPSEEK_API_KEY")
        self.api_base = os.getenv("DEEPSEEK_API_URL", "https://api.deepseek.com/v1")
        self.model = "deepseek-chat"
        
        if not self.api_key:
            raise ValueError("DEEPSEEK_API_KEY environment variable is required")
        
        # Initialize OpenAI client with DeepSeek configuration
        self.client = OpenAI(
            api_key=self.api_key,
            base_url=self.api_base
        )
    
    async def generate_completion(
        self, 
        prompt: str, 
        system_prompt: str = None,
        temperature: float = 0.7,
        max_tokens: int = 2048
    ) -> str:
        """
        Generate a completion using DeepSeek API
        
        Args:
            prompt: The user prompt
            system_prompt: Optional system prompt for context
            temperature: Sampling temperature (0.0 to 1.0)
            max_tokens: Maximum tokens to generate
            
        Returns:
            Generated completion text
        """
        try:
            messages = []
            
            if system_prompt:
                messages.append({"role": "system", "content": system_prompt})
            
            messages.append({"role": "user", "content": prompt})
            
            response = self.client.chat.completions.create(
                model=self.model,
                messages=messages,
                temperature=temperature,
                max_tokens=max_tokens
            )
            
            return response.choices[0].message.content
            
        except Exception as e:
            logger.error(f"Error generating completion: {e}")
            raise
    
    async def generate_structured_response(
        self,
        prompt: str,
        system_prompt: str,
        temperature: float = 0.3
    ) -> str:
        """
        Generate a structured JSON response for learning plan generation
        
        Args:
            prompt: The user prompt
            system_prompt: System prompt with instructions
            temperature: Sampling temperature (lower for more structured output)
            
        Returns:
            Generated structured response as JSON string
        """
        return await self.generate_completion(
            prompt=prompt,
            system_prompt=system_prompt,
            temperature=temperature,
            max_tokens=3000
        )
    
    async def generate_learning_plan_json(
        self,
        user_query: str,
        context: str = ""
    ) -> Dict[str, Any]:
        """
        Generate a learning plan in JSON format
        
        Args:
            user_query: User's learning request
            context: Additional context from vector store
            
        Returns:
            Learning plan as dictionary
        """
        system_prompt = """You are an expert learning path advisor. Generate a comprehensive, personalized learning plan in valid JSON format.

The JSON should include:
- track: The learning track name
- current_level: User's current skill level
- goal: User's learning goal
- estimated_duration: Time estimate (e.g., "8-12 weeks")
- prerequisites: List of required knowledge/skills
- learning_objectives: List of specific objectives
- recommended_courses: List of course titles
- projects: List of practical projects
- resources: List of additional resources
- milestones: List of objects with week, title, description
- skills_gained: List of skills the user will acquire

Ensure the response is valid JSON and comprehensive."""

        context_section = f"\n\nRelevant Context:\n{context}" if context else ""
        
        full_prompt = f"""Create a personalized learning plan for the following request:

{user_query}{context_section}

Please provide a detailed learning plan in valid JSON format."""
        
        try:
            response = await self.generate_structured_response(
                prompt=full_prompt,
                system_prompt=system_prompt,
                temperature=0.2
            )
            
            try:
                plan_dict = json.loads(response)
                return plan_dict
            except json.JSONDecodeError:
                logger.error(f"Failed to parse JSON response: {response}")
                # Try to extract JSON from response
                import re
                json_match = re.search(r'\{.*\}', response, re.DOTALL)
                if json_match:
                    return json.loads(json_match.group())
                else:
                    raise ValueError("No valid JSON found in response")
                    
        except Exception as e:
            logger.error(f"Error generating learning plan: {e}")
            raise

def get_deepseek_client() -> DeepSeekClient:
    """Get DeepSeek client instance"""
    return DeepSeekClient()

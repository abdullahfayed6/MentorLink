

import logging
import time
from fastapi import APIRouter, HTTPException, status

from app.models.schemas import (
    UserInput, 
    LearningPlan, 
    PlanGenerationResponse,
    HealthResponse
)
from app.services.learning_plan_service import get_learning_plan_service

logger = logging.getLogger(__name__)

router = APIRouter()

try:
    learning_service = get_learning_plan_service()
    logger.info("Learning service initialized successfully")
except Exception as e:
    logger.error(f"Failed to initialize learning service: {e}")
    learning_service = None

@router.get("/health", response_model=HealthResponse)
async def health_check():
    """Health check endpoint
    Generate a personalized learning plan
    
    Args:
        user_input: User requirements and preferences
        
    Returns:
        Generated learning plan with metadata
    Get list of available learning tracks"""
    try:
        if learning_service is None:
            raise HTTPException(
                status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
                detail="Learning service is not available"
            )
            
        tracks = learning_service.get_available_tracks()
        return {
            "success": True,
            "tracks": tracks,
            "count": len(tracks)
        }
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Error fetching tracks: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="Failed to fetch available tracks"
        )

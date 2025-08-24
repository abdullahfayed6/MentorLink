from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
import logging
from contextlib import asynccontextmanager

from .config import config, MentorQuery, MentorSearchResponse, MentorRecommendation, HealthCheck
from .mentor_service import MentorService

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

mentor_service: MentorService = None

@asynccontextmanager
async def lifespan(app: FastAPI):
    global mentor_service
    try:
        config.validate()
        
        logger.info("Initializing mentor service...")
        mentor_service = MentorService()
        logger.info("Mentor service initialized successfully")
        
        yield
        
    except Exception as e:
        logger.error(f"Failed to initialize application: {e}")
        raise
    finally:
        logger.info("Shutting down application")

app = FastAPI(
    title="RAG Mentors API",
    description="AI-powered mentor recommendation system using RAG (Retrieval-Augmented Generation)",
    version="1.0.0",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_mentor_service() -> MentorService:
    if mentor_service is None:
        raise HTTPException(status_code=500, detail="Mentor service not initialized")
    return mentor_service

@app.get("/", response_model=HealthCheck)
async def root():
    return HealthCheck(
        status="healthy",
        message="RAG Mentors API is running"
    )

@app.get("/health", response_model=HealthCheck)
async def health_check():
    return HealthCheck(
        status="healthy",
        message="Service is operational"
    )

@app.get("/stats")
async def get_stats(service: MentorService = Depends(get_mentor_service)):
    try:
        stats = service.get_stats()
        return {
            "status": "success",
            "data": stats
        }
    except Exception as e:
        logger.error(f"Error getting stats: {e}")
        raise HTTPException(status_code=500, detail="Failed to retrieve statistics")

@app.post("/search", response_model=MentorSearchResponse)
async def search_mentors(
    query: MentorQuery,
    service: MentorService = Depends(get_mentor_service)
):
    try:
        logger.info(f"Searching mentors for query: {query.query}")
        
        results = service.search_mentors(
            query=query.query,
            limit=query.limit,
            filter_available=query.filter_available
        )
        
        recommendations = []
        for result in results:
            recommendation = MentorRecommendation(
                mentor_id=result["mentor_id"],
                mentor_name=result["mentor_name"],
                email=result["email"],
                availability=result["availability"],
                mentorship_rate=result["mentorship_rate"],
                reasoning=result["reasoning"]
            )
            recommendations.append(recommendation)
        
        response = MentorSearchResponse(
            query=query.query,
            total_mentors_found=len(recommendations),
            recommendations=recommendations
        )
        
        logger.info(f"Found {len(recommendations)} mentors for query")
        return response
        
    except Exception as e:
        logger.error(f"Error searching mentors: {e}")
        raise HTTPException(status_code=500, detail=f"Failed to search mentors: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "main:app",
        host="0.0.0.0",
        port=config.API_PORT,
        reload=True
    )

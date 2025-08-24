"""
FastAPI Web Interface for MentorAI
High-performance REST API for the AI mentor system.
"""

from fastapi import FastAPI, HTTPException, BackgroundTasks
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from typing import List, Optional, Dict, Any
import asyncio
import json
import time
import uuid
from datetime import datetime

from .mentor_ai import get_mentor_ai, initialize_mentor_ai
from .config import config

app = FastAPI(
    title="MentorAI API",
    description="Professional AI mentor system API for technical guidance",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

mentor_ai = None

class ChatRequest(BaseModel):
    message: str
    session_id: Optional[str] = None

class ChatResponse(BaseModel):
    response: str
    session_id: str
    timestamp: datetime

class ConversationExport(BaseModel):
    conversation_id: str
    messages: List[Dict[str, Any]]
    metadata: Dict[str, Any]

class HealthResponse(BaseModel):
    status: str
    timestamp: datetime
    details: Dict[str, Any]

class ConversationStats(BaseModel):
    total_messages: int
    total_tokens: int
    average_tokens_per_message: float
    conversation_duration: float
    topics: Dict[str, int]

active_sessions: Dict[str, Any] = {}

@app.on_event("startup")
async def startup_event():
    """Initialize MentorAI on startup"""
    global mentor_ai
    try:
        mentor_ai = await initialize_mentor_ai()
        print("✅ MentorAI initialized successfully!")
    except Exception as e:
        print(f"❌ Failed to initialize MentorAI: {str(e)}")
        raise

@app.get("/")
async def root():
    """API information endpoint"""
    return {
        "name": "MentorAI API",
        "version": "1.0.0",
        "description": "Professional Technical Mentor Assistant API",
        "endpoints": {
            "chat": "/chat",
            "health": "/health",
            "docs": "/docs",
            "streamlit": "Run 'streamlit run streamlit_app.py' for web interface"
        },
        "status": "active"
    }

@app.post("/chat", response_model=ChatResponse)
async def chat(request: ChatRequest):
    """Main chat endpoint"""
    if not mentor_ai:
        raise HTTPException(status_code=503, detail="MentorAI not initialized")
    
    session_id = request.session_id or str(uuid.uuid4())
    
    try:
        response = await mentor_ai.chat(request.message)
        
        if session_id not in active_sessions:
            active_sessions[session_id] = {
                'created_at': datetime.now(),
                'messages': []
            }
        
        active_sessions[session_id]['messages'].extend([
            {'role': 'user', 'content': request.message, 'timestamp': datetime.now()},
            {'role': 'assistant', 'content': response.content, 'timestamp': datetime.now()}
        ])
        
        return ChatResponse(
            response=response.content,
            session_id=session_id,
            timestamp=datetime.now()
        )
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Chat error: {str(e)}")

@app.get("/health", response_model=HealthResponse)
async def health_check():
    """Health check endpoint"""
    try:
        if mentor_ai:
            health = await mentor_ai.health_check()
            return HealthResponse(
                status=health["status"],
                timestamp=datetime.now(),
                details=health
            )
        else:
            return HealthResponse(
                status="unhealthy",
                timestamp=datetime.now(),
                details={"error": "MentorAI not initialized"}
            )
    except Exception as e:
        return HealthResponse(
            status="error",
            timestamp=datetime.now(),
            details={"error": str(e)}
        )

@app.get("/conversation/{session_id}/stats")
async def get_conversation_stats(session_id: str):
    """Get conversation statistics"""
    if session_id not in active_sessions:
        raise HTTPException(status_code=404, detail="Session not found")
    
    try:
        session_data = active_sessions[session_id]
        total_messages = len(session_data['messages'])
        user_messages = len([m for m in session_data['messages'] if m['role'] == 'user'])
        
        return {
            "total_messages": total_messages,
            "user_messages": user_messages,
            "assistant_messages": total_messages - user_messages,
            "session_created": session_data['created_at'].isoformat(),
            "session_id": session_id
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Stats error: {str(e)}")

@app.post("/conversation/{session_id}/clear")
async def clear_conversation(session_id: str):
    """Clear conversation history"""
    if session_id in active_sessions:
        del active_sessions[session_id]
    
    return {"message": "Conversation cleared", "session_id": session_id}

@app.get("/conversation/{session_id}/export", response_model=ConversationExport)
async def export_conversation(session_id: str):
    """Export conversation data"""
    if session_id not in active_sessions:
        raise HTTPException(status_code=404, detail="Session not found")
    
    session_data = active_sessions[session_id]
    
    return ConversationExport(
        conversation_id=session_id,
        messages=[
            {
                'role': msg['role'],
                'content': msg['content'],
                'timestamp': msg['timestamp'].isoformat()
            }
            for msg in session_data['messages']
        ],
        metadata={
            'created_at': session_data['created_at'].isoformat(),
            'total_messages': len(session_data['messages']),
            'session_id': session_id
        }
    )

@app.get("/config")
async def get_config():
    """Get current configuration"""
    return config.to_dict()

@app.get("/sessions")
async def get_sessions():
    """Get active sessions"""
    return {
        "active_sessions": len(active_sessions),
        "sessions": {
            session_id: {
                "created_at": data["created_at"].isoformat(),
                "message_count": len(data["messages"])
            }
            for session_id, data in active_sessions.items()
        }
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "app:app",
        host="0.0.0.0",
        port=5050,
        reload=True,
        log_level="info"
    )

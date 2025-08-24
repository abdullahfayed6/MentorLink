#!/usr/bin/env python3
"""
FastAPI Runner for MentorAI
Simple script to run the FastAPI application with proper configuration.
"""

import uvicorn
import os
from dotenv import load_dotenv

load_dotenv()

def main():
    
    uvicorn.run(
        "app:app",
        host="0.0.0.0",
        port=5050,
        reload=True,
        log_level="info",
        access_log=True
    )

if __name__ == "__main__":
    main()

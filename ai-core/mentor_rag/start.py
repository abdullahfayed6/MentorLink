#!/usr/bin/env python3
"""
Startup script for Mentor RAG Service
Run this from the ai/mentor_rag directory
"""

import sys
import os
from pathlib import Path

# Add the service directory to Python path
service_root = Path(__file__).parent
sys.path.insert(0, str(service_root))

# Change to service directory for relative imports
os.chdir(service_root)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        "src.main:app",
        host="127.0.0.1",
        port=6050,
        reload=True,
        log_level="info"
    )

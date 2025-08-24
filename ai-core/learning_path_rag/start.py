#!/usr/bin/env python3
"""
Startup script for Learning Path RAG Service
Run this from the ai/learning_path_rag directory
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
    from src.run import main
    main()

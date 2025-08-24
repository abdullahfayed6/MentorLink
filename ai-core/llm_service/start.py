"""
Startup script for LLM Service
Run this from the ai/llm_service directory
"""

import sys
import os
from pathlib import Path

service_root = Path(__file__).parent
sys.path.insert(0, str(service_root))

os.chdir(service_root)

if __name__ == "__main__":
    from src.run import main
    main()

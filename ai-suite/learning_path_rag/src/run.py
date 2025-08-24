

import os
import sys
import logging
from pathlib import Path
import signal
import time
from dotenv import load_dotenv

project_root = Path(__file__).parent
sys.path.insert(0, str(project_root))

env_file = project_root / ".env"
if env_file.exists():
    load_dotenv(env_file)
    print(f"Loaded environment variables from {env_file}")
else:
    print("No .env file found, using system environment variables")

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.StreamHandler(sys.stdout),
        logging.FileHandler('app.log', mode='a')
    ]
)

logger = logging.getLogger(__name__)

def signal_handler(signum, frame):
    """Handle shutdown signals gracefullyCheck environment variables and dependenciesMain startup function"""
    try:
        signal.signal(signal.SIGINT, signal_handler)
        signal.signal(signal.SIGTERM, signal_handler)
        
        logger.info("Starting MentorLink Learning Path Generator v2.0")
        logger.info("Using direct file reading for content analysis")
        
        if not check_environment():
            logger.error("Environment check failed. Exiting.")
            sys.exit(1)
        
        from app.main import app
        import uvicorn
        
        host = os.getenv("API_HOST", "0.0.0.0")
        port = int(os.getenv("API_PORT", "8000"))
        workers = int(os.getenv("WORKERS", "1"))
        log_level = os.getenv("LOG_LEVEL", "info").lower()
        
        logger.info(f"Starting server on {host}:{port}")
        logger.info(f"Workers: {workers}")
        logger.info(f"Log level: {log_level}")
        logger.info(f"API Documentation: http://{host}:{port}/docs")
        logger.info(f"Alternative docs: http://{host}:{port}/redoc")
        logger.info(f"Health check: http://{host}:{port}/health")
        
        uvicorn_config = {
            "app": app,
            "host": host,
            "port": port,
            "log_level": log_level,
            "access_log": True,
            "loop": "asyncio",
            "http": "httptools",
        }
        
        if os.getenv("ENVIRONMENT") == "production" and workers > 1:
            uvicorn_config["workers"] = workers
            logger.info(f"Running in production mode with {workers} workers")
        
        uvicorn.run(**uvicorn_config)
        
    except KeyboardInterrupt:
        logger.info("Received keyboard interrupt. Shutting down MentorLink API")
    except Exception as e:
        logger.error(f"Failed to start MentorLink API: {e}")
        logger.exception("Full traceback:")
        sys.exit(1)

if __name__ == "__main__":
    main()

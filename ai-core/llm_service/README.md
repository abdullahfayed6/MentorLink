## MentorAI

A lightweight FastAPI service that calls DeepSeek and returns concise answers. Simple prompts, simple API.

### Features
- FastAPI REST API with docs
- Async HTTP via httpx
- Chain-of-thought–aware prompts that output only the answer
- .env-based config
- Dockerfile included

### Requirements
- Python 3.10+
- DeepSeek API key

### Setup
1) Create and activate a virtual environment
2) Install dependencies from `requirements.txt`
3) Create `.env` (see below)

### .env example
```
DEEPSEEK_API_KEY=your_api_key_here
DEEPSEEK_BASE_URL=https://api.deepseek.com/v1
MODEL_NAME=deepseek-chat
MAX_TOKENS=4000
TEMPERATURE=0.2
CONTEXT_WINDOW=32000
APP_NAME=MentorAI
VERSION=1.0.0
DEBUG=True
```

### Run (local)
- Runner: `python run.py`
- Uvicorn: `uvicorn app:app --host 0.0.0.0 --port 5050 --reload`

Open:
- Docs: http://localhost:5050/docs
- ReDoc: http://localhost:5050/redoc

### Endpoints (quick)
- POST /chat { message, session_id? }
- GET /health
- GET /config
- GET /sessions
- GET /conversation/{session_id}/export
- POST /conversation/{session_id}/clear

### Project files
- `app.py` FastAPI app
- `mentor_ai.py` DeepSeek client
- `prompts.py` prompt templates
- `config.py` settings
- `run.py` local runner
- `requirements.txt` dependencies

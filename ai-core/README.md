# AI Services - MentorLink

This directory contains three AI microservices that power the MentorLink platform's intelligent features.

## New Structure Overview

```
ai/
├── requirements.txt          # Unified requirements for all services
├── .gitignore                # Unified gitignore for all services
├── llm_service/              # Large Language Model Service
│   ├── src/                  # Source code
│   │   ├── app.py            # FastAPI app
│   │   ├── mentor_ai.py      # AI logic
│   │   ├── config.py         # Configuration
│   │   ├── prompts.py        # Prompt templates
│   │   └── run.py            # Uvicorn runner
│   ├── start.py              # Service startup script
│   └── Dockerfile            # Container configuration
│
├── mentor_rag/               # Mentor Retrieval-Augmented Generation
│   ├── src/                  # Source code
│   │   ├── main.py           # FastAPI app
│   │   ├── mentor_service.py # RAG logic
│   │   ├── config.py         # Configuration
│   │   └── app/              # Additional modules
│   ├── data/                 # Mentor data and datasets
│   │   └── mentors.csv       # Mentor database
│   ├── notebooks/            # Jupyter notebooks
│   │   └── notebook.ipynb    # Analysis notebook
│   ├── start.py              # Service startup script
│   └──  Dockerfile           # Container configuration
│
└── learning_path_rag/        # Learning Path RAG Service
    ├── src/                  # Source code
    │   ├── run.py            # Main runner
    │   └── app/              # Application modules
    │       ├── main.py       # FastAPI app
    │       ├── api/          # API routes
    │       ├── core/         # Core services
    │       ├── models/       # Data models
    │       └── services/     # Business logic
    ├── data/                 # Course and learning path data
    ├── notebooks/            # Jupyter notebooks
    ├── storage/              # Vector store and cache
    ├── start.py              # Service startup script
    └── Dockerfile            # Container configuration
```

## Quick Start

### Option 1: Interactive Service Manager
```bash
cd ai
```

### Option 2: Individual Services
```bash
# LLM Service (Port 5050)
cd ai/llm_service
python start.py

# Mentor RAG (Port 6050)
cd ai/mentor_rag
python start.py

# Learning Path RAG (Port 8000)
cd ai/learning_path_rag
python start.py
```

### Option 3: Docker
```bash
# Build and run individual services
cd ai/llm_service
docker build -t llm-service .
docker run -p 5050:5050 llm-service

cd ai/mentor_rag
docker build -t mentor-rag .
docker run -p 6050:6050 mentor-rag

cd ai/learning_path_rag
docker build -t learning-path-rag .
docker run -p 8000:8000 learning-path-rag
```

## Development Setup

### 1. Install Dependencies
```bash
cd ai
pip install -r requirements.txt
```

### 2. Environment Configuration
Each service needs its own `.env` file:

**llm_service/.env:**
```env
DEEPSEEK_API_KEY=your_deepseek_api_key
DEEPSEEK_API_URL=https://api.deepseek.com/v1/chat/completions
```

**mentor_rag/.env:**
```env
DEEPSEEK_API_KEY=your_deepseek_api_key
DEEPSEEK_API_URL=https://api.deepseek.com/v1/chat/completions
MENTORS_CSV_PATH=data/mentors.csv
```

**learning_path_rag/.env:**
```env
DEEPSEEK_API_KEY=your_deepseek_api_key
DEEPSEEK_API_URL=https://api.deepseek.com/v1/chat/completions
```

## Services Description

### LLM Service (Port 5050)
**Purpose:** Core language model service for AI mentoring conversations

**Key Features:**
- AI-powered mentoring conversations
- Natural language understanding
- Response generation and processing

**API Endpoints:**
- `GET /` - Service info
- `POST /chat` - Chat with AI mentor
- `GET /health` - Health check

### Mentor RAG (Port 6050)
**Purpose:** Retrieval-Augmented Generation for mentor matching

**Key Features:**
- Mentor matching and recommendations
- Mentor profile analysis
- Context-aware mentor suggestions

**API Endpoints:**
- `GET /` - Service info
- `POST /search` - Search mentors
- `GET /health` - Health check

### Learning Path RAG (Port 8000)
**Purpose:** Intelligent learning path generation and recommendations

**Key Features:**
- Personalized learning path creation
- Course recommendations
- Skill gap analysis and progression tracking

**API Endpoints:**
- `GET /` - Service info
- `POST /learning-plan` - Generate learning plan
- `GET /health` - Health check

## Import Structure Fixed

The new structure resolves import issues by:

1. **Relative Imports:** All internal imports use relative imports (e.g., `from .config import config`)
2. **Proper Package Structure:** Each `src` directory is a proper Python package with `__init__.py`
3. **Startup Scripts:** Each service has a `start.py` script that handles path configuration
4. **Data Path Updates:** Configuration files point to correct data locations

## Docker Integration

All Dockerfiles have been updated to work with the new structure:
- Use unified requirements.txt at AI root level
- Updated CMD to use `start.py` scripts
- Proper working directory setup

### Default ports

- LLM Service: 5050
- Mentor RAG: 6050
- Learning Path RAG: 8000

Change ports in the respective configuration files if needed.

### Data Path Issues
- Mentor data: `mentor_rag/data/mentors.csv`
- Learning paths: `learning_path_rag/data/docs_learning_path/`
- Courses: `learning_path_rag/data/Coureses/courses.csv`
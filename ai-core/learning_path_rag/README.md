# MentorLink - AI Learning Path Generator

**Create personalized learning plans using AI and smart recommendations.**

MentorLink generates customized educational roadmaps based on your goals, skill level, and available time using DeepSeek AI and intelligent content analysis 

## Features

- **🤖 AI-Powered**: Uses DeepSeek AI for intelligent plan generation
- **📚 Smart Recommendations**: Analyzes learning materials for relevant courses
- **⏱️ Personalized**: Plans based on your time, level, and goals
- **🌐 Web API**: Easy-to-use REST API with documentation
- **📖 Rich Content**: Supports various learning material formats

[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/abdullahfayed6/MentorLink)

## Quick Start

1. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   ```

2. **Set Up Environment**
   Create `.env` file with your DeepSeek API key:
   ```env
   DEEPSEEK_API_KEY=your_api_key_here
   ```

3. **Add Learning Materials**
   - Place your course files (`.md`, `.csv`) in the `data/` folder
   - The system will automatically index them

4. **Start the Server**
   ```bash
   python run.py
   ```

5. **Access the API**
   - API: http://localhost:8000
   - Documentation: http://localhost:8000/docs

## API Usage

### Generate a Learning Plan

```bash
curl -X POST "http://localhost:8000/api/v1/generate-plan" \
-H "Content-Type: application/json" \
-d '{
  "user_id": "user123",
  "track": "Web Development",
  "level": "Beginner",
  "goal": "Become a web developer",
  "available_hours_per_week": 10,
  "timeframe_months": 6,
  "preferred_languages": ["JavaScript", "Python"],
  "focus_areas": ["Frontend", "Backend"]
}'
```

### Check Health
```bash
curl http://localhost:8000/health
```

## Project Structure

```
MentorLink/
├── app/
│   ├── api/           # API routes
│   ├── core/          # AI & database services
│   ├── models/        # Data models
│   └── services/      # Business logic
├── data/              # Learning materials
├── storage/           # Database storage
└── run.py             # Start script
```

## Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| `DEEPSEEK_API_KEY` | DeepSeek API key | Required |
| `API_PORT` | Server port | `8000` |
| `LOG_LEVEL` | Logging level | `INFO` |

## Docker Deployment

```bash
# Build image
docker build -t mentorlink .

# Run container
docker run -p 8000:8000 -e DEEPSEEK_API_KEY=your_key mentorlink
```

## Development

### Local Development
```bash
python -m uvicorn app.main:app --reload --port 8000
```

### Add New Features
1. Update models in `app/models/schemas.py`
2. Add business logic to `app/services/`
3. Create API endpoints in `app/api/routes.py`

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | API information |
| `/health` | GET | Health check |
| `/api/v1/generate-plan` | POST | Generate learning plan |
| `/api/v1/status` | GET | System status |

## Example Response

```json
{
  "success": true,
  "plan": {
    "title": "Web Development Learning Path",
    "description": "6-month beginner program",
    "total_duration_months": 6,
    "total_hours": 240,
    "difficulty_level": "Beginner",
    "phases": [
      {
        "title": "Foundation Phase",
        "focus": "HTML, CSS, JavaScript",
        "weeks": [...]
      }
    ]
  }
}
```
---
**Built with FastAPI, DeepSeek AI, and ChromaDB**

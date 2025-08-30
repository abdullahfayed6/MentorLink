# MentorLink API

[![.NET](https://img.shields.io/badge/.NET-9.0-blue.svg)](https://dotnet.microsoft.com/download/dotnet/9.0)
[![ASP.NET Core](https://img.shields.io/badge/ASP.NET%20Core-9.0-green.svg)](https://docs.microsoft.com/en-us/aspnet/core/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📋 Project Overview

MentorLink is a comprehensive mentoring platform API built with **ASP.NET Core Web API**. The platform connects trainees with experienced mentors, facilitating knowledge sharing and skill development. The API provides robust authentication, user management, and mentor discovery features.

**Production URL**: [http://mentorlink.runasp.net/](http://mentorlink.runasp.net/)

## ✨ Features

- 🔐 **JWT Authentication** - Secure token-based authentication with refresh tokens
- 👤 **User Management** - Complete user registration, login, and profile management
- 🔑 **Password Reset** - Email-based password reset with verification codes
- 👨‍🏫 **Mentor Discovery** - Search and filter mentors by various criteria
- 🛡️ **Protected Endpoints** - Role-based access control for secure operations
- 📧 **Email Integration** - Automated email notifications for password reset
- 🔄 **Token Refresh** - Automatic token renewal for seamless user experience
- 🌐 **CORS Support** - Cross-origin resource sharing enabled
- 📚 **Swagger Documentation** - Interactive API documentation

## 🚀 API Endpoints

### Authentication Endpoints

#### 1. User Registration
```http
POST /api/Auth/signup
```

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john.doe@example.com",
  "password": "SecurePass123!",
  "confirmPassword": "SecurePass123!",
  "phone": "12345678901"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "token": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "refresh_token_here",
    "expiresAt": "2024-01-01T12:00:00Z",
    "tokenType": "Bearer"
  },
  "user": {
    "traineeId": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "12345678901",
    "level": "Beginner"
  }
}
```

#### 2. User Login
```http
POST /api/Auth/signin
```

**Request Body:**
```json
{
  "email": "john.doe@example.com",
  "password": "SecurePass123!"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "token": {
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "refresh_token_here",
    "expiresAt": "2024-01-01T12:00:00Z",
    "tokenType": "Bearer"
  },
  "user": {
    "traineeId": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "phone": "12345678901",
    "level": "Beginner"
  }
}
```

#### 3. Refresh Token
```http
POST /api/Auth/refresh-token
```

**Request Body:**
```json
{
  "refreshToken": "your_refresh_token_here"
}
```

#### 4. Logout
```http
POST /api/Auth/logout
```

**Request Body:**
```json
{
  "refreshToken": "your_refresh_token_here"
}
```

#### 5. Forgot Password
```http
POST /api/Auth/forgot-password
```

**Request Body:**
```json
{
  "email": "john.doe@example.com"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password reset code sent to your email",
  "expiresAt": "2024-01-01T12:05:00Z"
}
```

#### 6. Verify Reset Code
```http
POST /api/Auth/verify-code
```

**Request Body:**
```json
{
  "email": "john.doe@example.com",
  "resetCode": "12345"
}
```

#### 7. Reset Password
```http
POST /api/Auth/reset-password
```

**Request Body:**
```json
{
  "email": "john.doe@example.com",
  "resetCode": "12345",
  "newPassword": "NewSecurePass123!",
  "confirmPassword": "NewSecurePass123!"
}
```

### Mentor Endpoints

#### 1. Get All Mentors
```http
GET /api/Mentor
```

**Query Parameters:**
- `searchTerm` (optional): Search mentors by name or skills
- `level` (optional): Filter by mentor level (Beginner, Intermediate, Advanced)
- `page` (optional): Page number for pagination
- `pageSize` (optional): Number of items per page

**Example:**
```http
GET /api/Mentor?searchTerm=javascript&level=Advanced&page=1&pageSize=10
```

**Response:**
```json
[
  {
    "mentorId": 1,
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "pictureUrl": "https://example.com/avatar.jpg",
    "level": "Advanced",
    "skills": ["JavaScript", "React", "Node.js"],
    "focusAreas": ["Web Development", "Frontend"],
    "languages": ["English", "Spanish"]
  }
]
```

#### 2. Get Mentor by ID
```http
GET /api/Mentor/{id}
```

**Example:**
```http
GET /api/Mentor/1
```

### Trainee Endpoints

#### 1. Delete Trainee
```http
DELETE /api/Trainees/{id}
```

Responses:
- `204 No Content` → deleted successfully
- `404 Not Found` → trainee does not exist

### Protected Endpoints

#### 1. Get User Profile
```http
GET /api/Protected/profile
```

**Headers:**
```
Authorization: Bearer your_access_token_here
```

**Response:**
```json
{
  "message": "This is a protected endpoint",
  "user": {
    "userId": "1",
    "email": "john.doe@example.com",
    "name": "John Doe",
    "phone": "12345678901",
    "level": "Beginner"
  }
}
```

#### 2. Test Protected Endpoint
```http
GET /api/Protected/test
```

**Headers:**
```
Authorization: Bearer your_access_token_here
```

**Response:**
```json
{
  "message": "Authentication is working! You have access to this protected endpoint."
}
```

### Roadmap Endpoints

#### 1. Create a Roadmap (Generate and store HTML)
```http
POST /api/Roadmaps?traineeId={traineeId}
```

Headers:
```
Content-Type: application/json
```

Request Body:
```json
{
  "title": "Full-Stack Web Developer",
  "difficultyLevel": "Intermediate",
  "totalDurationMonths": 6,
  "totalHours": 240,
  "description": "A guided path to become a full-stack developer focusing on practical skills.",
  "phases": [
    {
      "title": "Foundations",
      "month": 1,
      "focus": "HTML, CSS, and JavaScript fundamentals",
      "skillsGained": ["HTML", "CSS", "JavaScript Basics"],
      "prerequisites": ["Basic computer literacy"],
      "recommendedCourses": [
        "Intro to HTML & CSS - https://example.com/html-css",
        "JavaScript Basics - https://example.com/js-basics"
      ],
      "weeks": [
        {
          "week": 1,
          "focus": "HTML Essentials",
          "hours": 8,
          "topics": ["Semantic HTML", "Forms", "Accessibility"],
          "deliverables": ["Static multi-page site"]
        }
      ]
    }
  ],
  "careerOutcomes": ["Junior Full-Stack Developer"]
}
```

Responses:
- `201 Created` → `{ id, html }`
- `400 Bad Request` → validation errors
- `404 Not Found` → traineeId not found

Notes:
- `traineeId` is required as a query parameter and the generated HTML is saved to the trainee's `RoadMap` in the database.

#### 2. Get a Roadmap by Id
```http
GET /api/Roadmaps/{id}
```

Response:
```json
{
  "id": 1,
  "title": "Full-Stack Web Developer",
  "html": "<!DOCTYPE html>..."
}
```

## 🛠️ How to Run Locally

### Prerequisites
- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) or [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) or [Visual Studio Code](https://code.visualstudio.com/)

### Setup Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/mentorlink-api.git
   cd mentorlink-api
   ```

2. **Restore Dependencies**
   ```bash
   dotnet restore
   ```

3. **Update Database Connection**
   - Open `MentorLink/appsettings.json`
   - Update the `DefaultConnection` string with your database details

4. **Run Database Migrations**
   ```bash
   cd Presistence
   dotnet ef database update
   cd ..
   ```

5. **Run the Application**
   ```bash
   dotnet run --project MentorLink
   ```

6. **Access the API**
   - API: `https://localhost:7042/`
   - Swagger UI: `https://localhost:7042/swagger`

## 🧪 How to Test the API

### Using Swagger UI
1. Navigate to `https://localhost:7042/swagger` (local) or `http://mentorlink.runasp.net/swagger` (production)
2. Use the interactive interface to test endpoints
3. Click "Try it out" on any endpoint
4. Fill in the required parameters
5. Click "Execute" to see the response

### Using Postman

#### 1. Register a New User
```http
POST http://mentorlink.runasp.net/api/Auth/signup
Content-Type: application/json

{
  "name": "Test User",
  "email": "test@example.com",
  "password": "TestPass123!",
  "confirmPassword": "TestPass123!",
  "phone": "12345678901"
}
```

#### 2. Login
```http
POST http://mentorlink.runasp.net/api/Auth/signin
Content-Type: application/json

{
  "email": "test@example.com",
  "password": "TestPass123!"
}
```

#### 3. Access Protected Endpoint
```http
GET http://mentorlink.runasp.net/api/Protected/profile
Authorization: Bearer your_access_token_here
```

#### 4. Get All Mentors
```http
GET http://mentorlink.runasp.net/api/Mentor?page=1&pageSize=10
```

### Using cURL

#### Register User
```bash
curl -X POST http://mentorlink.runasp.net/api/Auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Test User",
    "email": "test@example.com",
    "password": "TestPass123!",
    "confirmPassword": "TestPass123!",
    "phone": "12345678901"
  }'
```

#### Login
```bash
curl -X POST http://mentorlink.runasp.net/api/Auth/signin \
  -H "Content-Type: application/json" \
  -d '{
    "email": "test@example.com",
    "password": "TestPass123!"
  }'
```

#### Access Protected Endpoint
```bash
curl -X GET http://mentorlink.runasp.net/api/Protected/profile \
  -H "Authorization: Bearer your_access_token_here"
```

## 🔐 Authentication

The API uses **JWT (JSON Web Token)** authentication with the following features:

### Token Structure
- **Access Token**: Short-lived token (1 hour) for API access
- **Refresh Token**: Long-lived token for obtaining new access tokens
- **Token Type**: Bearer

### Authentication Flow

1. **Register/Login** → Receive access token and refresh token
2. **API Calls** → Include access token in Authorization header
3. **Token Expiry** → Use refresh token to get new access token
4. **Logout** → Revoke refresh token

### Example Authentication Flow

```javascript
// 1. Login
const loginResponse = await fetch('http://mentorlink.runasp.net/api/Auth/signin', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    email: 'user@example.com',
    password: 'password123!'
  })
});

const { token } = await loginResponse.json();

// 2. Use token for protected requests
const profileResponse = await fetch('http://mentorlink.runasp.net/api/Protected/profile', {
  headers: {
    'Authorization': `Bearer ${token.accessToken}`
  }
});

// 3. Refresh token when expired
const refreshResponse = await fetch('http://mentorlink.runasp.net/api/Auth/refresh-token', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    refreshToken: token.refreshToken
  })
});
```

## 🚀 Deployment

The API is currently deployed and accessible at:
**Production URL**: [http://mentorlink.runasp.net/](http://mentorlink.runasp.net/)


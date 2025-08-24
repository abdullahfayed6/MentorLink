# Node.js Backend Development

## Node.js Fundamentals

### Core Modules
- **File System (fs)**: Reading and writing files
- **Path**: Working with file and directory paths
- **HTTP**: Creating HTTP servers and clients
- **Events**: EventEmitter pattern and custom events
- **Stream**: Readable, writable, and transform streams

### NPM and Package Management
- **package.json**: Project configuration and dependencies
- **NPM Commands**: install, update, publish, scripts
- **Semantic Versioning**: Understanding version numbers
- **Lock Files**: package-lock.json for dependency consistency
- **NPX**: Executing packages without installation

### Asynchronous Programming
- **Callbacks**: Traditional async pattern
- **Promises**: Promise-based async operations
- **Async/Await**: Modern async syntax
- **Error Handling**: Async error management
- **Event Loop**: Understanding Node.js concurrency

## Express.js Framework

### Server Setup and Routing
- **Express Application**: Creating and configuring Express apps
- **Routing**: GET, POST, PUT, DELETE route handlers
- **Route Parameters**: Dynamic route segments
- **Query Parameters**: Handling URL query strings
- **Route Handlers**: Multiple handler functions

### Middleware
- **Built-in Middleware**: express.json, express.static
- **Third-party Middleware**: cors, helmet, morgan
- **Custom Middleware**: Writing application-specific middleware
- **Error Handling Middleware**: Centralized error management
- **Middleware Order**: Understanding execution sequence

### Request and Response
- **Request Object**: Accessing request data
- **Response Methods**: send, json, status, redirect
- **Headers**: Setting and reading HTTP headers
- **Cookies**: Setting and parsing cookies
- **File Uploads**: Handling multipart/form-data

## Database Integration

### MongoDB with Mongoose
- **Schema Definition**: Defining data models
- **CRUD Operations**: Create, read, update, delete
- **Validation**: Data validation and sanitization
- **Relationships**: References and embedded documents
- **Middleware**: Pre and post hooks

### SQL Databases
- **MySQL/PostgreSQL**: Relational database integration
- **Query Builders**: Knex.js for SQL queries
- **ORMs**: Sequelize for object-relational mapping
- **Migrations**: Database schema versioning
- **Connection Pooling**: Optimizing database connections

### Authentication and Security
- **JWT**: JSON Web Token authentication
- **bcrypt**: Password hashing and verification
- **Session Management**: Server-side session storage
- **CORS**: Cross-origin resource sharing
- **Input Validation**: Sanitizing and validating user input

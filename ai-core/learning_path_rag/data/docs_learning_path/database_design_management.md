# Database Design and Management

## Database Fundamentals

### Relational Database Concepts
- Tables, rows, and columns
- Primary keys and foreign keys
- Relationships (one-to-one, one-to-many, many-to-many)
- Referential integrity

### Database Normalization
- **First Normal Form (1NF)**: Eliminate duplicate columns
- **Second Normal Form (2NF)**: Remove partial dependencies
- **Third Normal Form (3NF)**: Remove transitive dependencies
- **BCNF**: Boyce-Codd Normal Form for advanced normalization

### SQL (Structured Query Language)
- Data Definition Language (DDL): CREATE, ALTER, DROP
- Data Manipulation Language (DML): INSERT, UPDATE, DELETE
- Data Query Language (DQL): SELECT statements
- Data Control Language (DCL): GRANT, REVOKE

## Advanced SQL Concepts

### Complex Queries
- JOINs (INNER, LEFT, RIGHT, FULL OUTER)
- Subqueries and correlated subqueries
- Common Table Expressions (CTEs)
- Window functions for analytics

### Indexes and Performance
- B-tree indexes for fast lookups
- Composite indexes for multi-column queries
- Query execution plans
- Index optimization strategies

### Stored Procedures and Functions
- Reusable database code
- Parameter handling
- Control flow statements
- Error handling in database code

## NoSQL Databases

### Document Databases
- **MongoDB**: Flexible JSON-like documents
- Schema-less design
- Embedded documents vs references
- Aggregation pipelines

### Key-Value Stores
- **Redis**: In-memory data structure store
- **DynamoDB**: AWS managed NoSQL database
- High performance for simple queries
- Caching and session storage

### Column-Family Databases
- **Cassandra**: Distributed wide-column store
- **HBase**: Hadoop-based column store
- Scalability for big data applications

### Graph Databases
- **Neo4j**: Property graph model
- **Amazon Neptune**: Managed graph database
- Relationship-focused data modeling
- Graph traversal queries

## Database Administration

### Backup and Recovery
- Full, incremental, and differential backups
- Point-in-time recovery
- Disaster recovery planning
- High availability configurations

### Security and Access Control
- User authentication and authorization
- Role-based security models
- Data encryption at rest and in transit
- Audit logging and compliance

### Performance Tuning
- Query optimization techniques
- Database monitoring and metrics
- Resource allocation and scaling
- Partitioning and sharding strategies

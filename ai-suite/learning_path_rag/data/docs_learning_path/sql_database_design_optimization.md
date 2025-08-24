# SQL Database Design and Optimization

## Database Design Principles

### Normalization
- **First Normal Form (1NF)**: Atomic values and unique rows
- **Second Normal Form (2NF)**: Eliminating partial dependencies
- **Third Normal Form (3NF)**: Removing transitive dependencies
- **Boyce-Codd Normal Form (BCNF)**: Stricter form of 3NF
- **Denormalization**: Strategic violation for performance

### Entity-Relationship Modeling
- **Entities**: Business objects and their attributes
- **Relationships**: Connections between entities
- **Cardinality**: One-to-one, one-to-many, many-to-many
- **Primary Keys**: Unique identifiers for records
- **Foreign Keys**: References to other tables

### Data Types and Constraints
- **Numeric Types**: INT, DECIMAL, FLOAT precision considerations
- **String Types**: VARCHAR, CHAR, TEXT length optimization
- **Date/Time Types**: DATE, DATETIME, TIMESTAMP handling
- **Boolean Types**: TRUE/FALSE value storage
- **Constraints**: NOT NULL, UNIQUE, CHECK, DEFAULT

## Advanced SQL Queries

### Joins and Subqueries
- **INNER JOIN**: Matching records from both tables
- **LEFT/RIGHT JOIN**: Including non-matching records
- **FULL OUTER JOIN**: All records from both tables
- **CROSS JOIN**: Cartesian product of tables
- **Subqueries**: Nested queries and correlated subqueries

### Window Functions
- **ROW_NUMBER()**: Assigning row numbers
- **RANK() and DENSE_RANK()**: Ranking with ties
- **PARTITION BY**: Grouping for window calculations
- **Running Totals**: Cumulative calculations
- **Moving Averages**: Sliding window calculations

### Aggregate Functions and Grouping
- **Basic Aggregates**: COUNT, SUM, AVG, MIN, MAX
- **GROUP BY**: Grouping rows for aggregation
- **HAVING**: Filtering grouped results
- **ROLLUP and CUBE**: Subtotals and cross-tabulations
- **GROUPING SETS**: Custom grouping combinations

## Performance Optimization

### Indexing Strategies
- **B-Tree Indexes**: Standard index structure
- **Unique Indexes**: Enforcing uniqueness with performance
- **Composite Indexes**: Multi-column index optimization
- **Partial Indexes**: Conditional index creation
- **Index Maintenance**: Rebuilding and monitoring

### Query Optimization
- **Execution Plans**: Understanding query execution
- **Index Usage**: Ensuring indexes are utilized
- **Query Rewriting**: Optimizing query structure
- **Statistics**: Database statistics for optimization
- **Hints**: Influencing optimizer decisions

### Database Performance
- **Connection Pooling**: Managing database connections
- **Caching**: Query result and data caching
- **Partitioning**: Dividing large tables
- **Sharding**: Horizontal database scaling
- **Monitoring**: Performance metrics and alerts

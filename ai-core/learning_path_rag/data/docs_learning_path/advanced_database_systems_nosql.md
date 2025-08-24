# Advanced Database Systems & NoSQL

## Table of Contents
- [Introduction](#introduction)
- [Advanced SQL Features](#advanced-sql-features)
- [NoSQL Database Types](#nosql-database-types)
- [Database Performance Optimization](#database-performance-optimization)
- [Distributed Database Systems](#distributed-database-systems)
- [Database Security](#database-security)
- [Modern Database Technologies](#modern-database-technologies)
- [Database Design Patterns](#database-design-patterns)

## Introduction

Advanced database systems encompass modern SQL features, NoSQL alternatives, distributed architectures, and specialized databases for different use cases and performance requirements.

## Advanced SQL Features

### Window Functions
```sql
-- Advanced window function examples
SELECT 
    employee_id,
    department,
    salary,
    AVG(salary) OVER (PARTITION BY department) as dept_avg,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as salary_rank,
    LAG(salary, 1) OVER (PARTITION BY department ORDER BY salary) as prev_salary
FROM employees;

-- Cumulative calculations
SELECT 
    order_date,
    sales_amount,
    SUM(sales_amount) OVER (ORDER BY order_date ROWS UNBOUNDED PRECEDING) as running_total
FROM sales_data;
```

### Common Table Expressions (CTEs)
```sql
-- Recursive CTE for hierarchical data
WITH RECURSIVE employee_hierarchy AS (
    -- Base case: top-level managers
    SELECT employee_id, name, manager_id, 1 as level
    FROM employees 
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: employees with managers
    SELECT e.employee_id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy ORDER BY level, name;
```

### Advanced Indexing
- **Partial indexes**: Conditional indexing
- **Expression indexes**: Function-based indexes
- **Covering indexes**: Include columns
- **Multi-column indexes**: Composite indexing

### JSON and Semi-Structured Data
```sql
-- PostgreSQL JSON operations
SELECT 
    id,
    data->>'name' as customer_name,
    data->'address'->>'city' as city,
    jsonb_array_elements(data->'orders') as orders
FROM customers 
WHERE data @> '{"status": "active"}';

-- JSON path queries
SELECT * FROM products 
WHERE metadata @@ '$.features[*] ? (@ == "wireless")';
```

## NoSQL Database Types

### Document Databases
```javascript
// MongoDB advanced operations
db.products.aggregate([
    {
        $match: {
            "category": "electronics",
            "price": { $gte: 100, $lte: 500 }
        }
    },
    {
        $lookup: {
            from: "reviews",
            localField: "_id",
            foreignField: "product_id",
            as: "reviews"
        }
    },
    {
        $addFields: {
            "avg_rating": { $avg: "$reviews.rating" },
            "review_count": { $size: "$reviews" }
        }
    },
    {
        $sort: { "avg_rating": -1, "review_count": -1 }
    }
]);
```

### Key-Value Stores
```python
# Redis advanced patterns
import redis

# Distributed locking
def acquire_lock(redis_client, lock_name, timeout=10):
    identifier = str(uuid.uuid4())
    end = time.time() + timeout
    
    while time.time() < end:
        if redis_client.set(lock_name, identifier, nx=True, ex=timeout):
            return identifier
        time.sleep(0.001)
    
    return False

# Pub/Sub with patterns
def setup_pubsub_patterns():
    pubsub = redis_client.pubsub()
    pubsub.psubscribe('user:*:notifications')
    
    for message in pubsub.listen():
        if message['type'] == 'pmessage':
            handle_user_notification(message)
```

### Column-Family Databases
```python
# Cassandra data modeling
from cassandra.cluster import Cluster
from cassandra.policies import DCAwareRoundRobinPolicy

class UserActivityTracker:
    def __init__(self):
        self.cluster = Cluster(
            ['127.0.0.1'],
            load_balancing_policy=DCAwareRoundRobinPolicy()
        )
        self.session = self.cluster.connect()
    
    def create_keyspace(self):
        self.session.execute("""
            CREATE KEYSPACE IF NOT EXISTS user_activity
            WITH REPLICATION = {
                'class': 'SimpleStrategy',
                'replication_factor': 3
            }
        """)
    
    def track_activity(self, user_id, activity_type, timestamp, data):
        query = """
            INSERT INTO user_activity.activities 
            (user_id, activity_date, activity_time, activity_type, data)
            VALUES (?, ?, ?, ?, ?)
        """
        self.session.execute(query, (user_id, timestamp.date(), 
                                   timestamp, activity_type, data))
```

### Graph Databases
```cypher
// Neo4j advanced queries
// Find influential users in social network
MATCH (u:User)-[:FOLLOWS]->(influencer:User)
WHERE u.active = true
WITH influencer, count(u) as follower_count
WHERE follower_count > 1000
MATCH (influencer)-[:POSTS]->(content:Content)
WHERE content.created > date() - duration('P30D')
RETURN influencer.name, follower_count, 
       count(content) as recent_posts,
       avg(content.engagement_score) as avg_engagement
ORDER BY avg_engagement DESC;

// Shortest path with weighted relationships
MATCH path = shortestPath(
    (start:Location {name: 'New York'})-[:CONNECTED*]-(end:Location {name: 'Los Angeles'})
)
RETURN path, 
       reduce(distance = 0, rel in relationships(path) | distance + rel.distance) as total_distance;
```

## Database Performance Optimization

### Query Optimization
```sql
-- Query plan analysis
EXPLAIN (ANALYZE, BUFFERS) 
SELECT c.customer_name, 
       COUNT(o.order_id) as order_count,
       SUM(o.total_amount) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2023-01-01'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 5
ORDER BY total_spent DESC;
```

### Indexing Strategies
```sql
-- Composite index for common query patterns
CREATE INDEX CONCURRENTLY idx_orders_customer_date_status 
ON orders (customer_id, order_date, status) 
INCLUDE (total_amount);

-- Partial index for active records
CREATE INDEX idx_products_active 
ON products (category, price) 
WHERE status = 'active';

-- Expression index for case-insensitive searches
CREATE INDEX idx_customers_email_lower 
ON customers (lower(email));
```

### Partitioning
```sql
-- Range partitioning by date
CREATE TABLE sales_data (
    id SERIAL,
    sale_date DATE,
    amount DECIMAL(10,2),
    customer_id INTEGER
) PARTITION BY RANGE (sale_date);

-- Create monthly partitions
CREATE TABLE sales_2024_01 PARTITION OF sales_data 
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE sales_2024_02 PARTITION OF sales_data 
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');
```

### Connection Pooling
```python
# Advanced connection pool configuration
from sqlalchemy import create_engine
from sqlalchemy.pool import QueuePool

engine = create_engine(
    'postgresql://user:password@localhost/db',
    poolclass=QueuePool,
    pool_size=20,
    max_overflow=30,
    pool_pre_ping=True,
    pool_recycle=3600,
    echo_pool=True
)
```

## Distributed Database Systems

### Sharding Strategies
```python
# Hash-based sharding implementation
class DatabaseSharding:
    def __init__(self, shard_configs):
        self.shards = {}
        for shard_id, config in shard_configs.items():
            self.shards[shard_id] = create_engine(config['connection_string'])
    
    def get_shard(self, key):
        shard_id = hash(str(key)) % len(self.shards)
        return self.shards[shard_id]
    
    def execute_query(self, key, query, params=None):
        shard = self.get_shard(key)
        return shard.execute(query, params)
    
    def execute_distributed_query(self, query, params=None):
        results = []
        for shard in self.shards.values():
            result = shard.execute(query, params)
            results.extend(result.fetchall())
        return results
```

### Replication Patterns
- **Master-slave replication**: Read scalability
- **Master-master replication**: Write scalability
- **Multi-master replication**: Geographic distribution
- **Chain replication**: Consistency guarantees

### Consensus in Distributed Databases
- **Raft in CockroachDB**: Strong consistency
- **Paxos in Spanner**: Global consistency
- **PBFT in blockchain databases**: Byzantine tolerance
- **Eventual consistency**: BASE properties

## Database Security

### Access Control
```sql
-- Role-based access control
CREATE ROLE data_analyst;
GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO data_analyst;
GRANT USAGE ON SCHEMA analytics TO data_analyst;

-- Row-level security
CREATE POLICY tenant_isolation ON customers
FOR ALL TO application_role
USING (tenant_id = current_setting('app.current_tenant')::uuid);

ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
```

### Data Encryption
```python
# Application-level encryption
from cryptography.fernet import Fernet
import base64

class EncryptedField:
    def __init__(self, key):
        self.cipher = Fernet(key)
    
    def encrypt(self, data):
        if isinstance(data, str):
            data = data.encode()
        encrypted = self.cipher.encrypt(data)
        return base64.urlsafe_b64encode(encrypted).decode()
    
    def decrypt(self, encrypted_data):
        encrypted_bytes = base64.urlsafe_b64decode(encrypted_data.encode())
        decrypted = self.cipher.decrypt(encrypted_bytes)
        return decrypted.decode()
```

### Audit Logging
```sql
-- Trigger-based audit trail
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    table_name TEXT,
    operation TEXT,
    old_values JSONB,
    new_values JSONB,
    user_name TEXT,
    timestamp TIMESTAMP DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (table_name, operation, new_values, user_name)
        VALUES (TG_TABLE_NAME, TG_OP, row_to_json(NEW), current_user);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (table_name, operation, old_values, new_values, user_name)
        VALUES (TG_TABLE_NAME, TG_OP, row_to_json(OLD), row_to_json(NEW), current_user);
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
```

## Modern Database Technologies

### NewSQL Databases
- **CockroachDB**: Distributed SQL
- **TiDB**: Hybrid transactional/analytical processing
- **VoltDB**: In-memory OLTP
- **FoundationDB**: Distributed key-value store

### Time-Series Databases
```python
# InfluxDB time-series operations
from influxdb_client import InfluxDBClient, Point

client = InfluxDBClient(url="http://localhost:8086", token="your-token")
write_api = client.write_api()

# Write time-series data
point = Point("sensor_data") \
    .tag("sensor_id", "temp_001") \
    .tag("location", "datacenter_a") \
    .field("temperature", 23.5) \
    .field("humidity", 45.2)

write_api.write("monitoring", "my-org", point)

# Query with InfluxDB Flux language
query = '''
from(bucket: "monitoring")
  |> range(start: -1h)
  |> filter(fn: (r) => r._measurement == "sensor_data")
  |> aggregateWindow(every: 5m, fn: mean)
'''
```

### Vector Databases
```python
# Vector similarity search with Pinecone
import pinecone

pinecone.init(api_key="your-api-key", environment="your-env")

# Create index for high-dimensional vectors
index = pinecone.Index("similarity-search")

# Insert vectors with metadata
vectors = [
    ("doc1", [0.1, 0.2, 0.3, ...], {"category": "tech", "date": "2024-01-01"}),
    ("doc2", [0.4, 0.5, 0.6, ...], {"category": "finance", "date": "2024-01-02"})
]
index.upsert(vectors)

# Similarity search
query_vector = [0.15, 0.25, 0.35, ...]
results = index.query(
    vector=query_vector,
    top_k=10,
    filter={"category": {"$eq": "tech"}},
    include_metadata=True
)
```

## Database Design Patterns

### Event Sourcing
```python
class EventStore:
    def __init__(self, connection):
        self.conn = connection
    
    def append_event(self, aggregate_id, event_type, event_data, expected_version):
        query = """
        INSERT INTO events (aggregate_id, event_type, event_data, version, timestamp)
        VALUES (%s, %s, %s, %s, NOW())
        """
        with self.conn.cursor() as cursor:
            cursor.execute(query, (aggregate_id, event_type, 
                                 json.dumps(event_data), expected_version + 1))
    
    def get_events(self, aggregate_id, from_version=0):
        query = """
        SELECT event_type, event_data, version, timestamp
        FROM events 
        WHERE aggregate_id = %s AND version > %s
        ORDER BY version
        """
        with self.conn.cursor() as cursor:
            cursor.execute(query, (aggregate_id, from_version))
            return cursor.fetchall()
```

### CQRS (Command Query Responsibility Segregation)
```python
# Separate read and write models
class WriteModel:
    def __init__(self, write_db):
        self.db = write_db
    
    def create_order(self, order_data):
        # Complex business logic for writes
        order = Order(**order_data)
        order.validate()
        self.db.save(order)
        
        # Publish event for read model update
        event_bus.publish(OrderCreated(order.id, order_data))

class ReadModel:
    def __init__(self, read_db):
        self.db = read_db
    
    def get_order_summary(self, customer_id):
        # Optimized queries for reads
        return self.db.query("""
            SELECT customer_id, 
                   COUNT(*) as total_orders,
                   SUM(amount) as total_spent
            FROM order_summaries 
            WHERE customer_id = %s
        """, (customer_id,))
```

---

*This guide covers advanced database concepts including modern SQL features, NoSQL systems, performance optimization, and distributed database architectures.*

# Distributed Systems Architecture & Design

## Table of Contents
- [Introduction](#introduction)
- [Distributed System Models](#distributed-system-models)
- [Consistency & Consensus](#consistency--consensus)
- [Fault Tolerance & Reliability](#fault-tolerance--reliability)
- [Distributed Algorithms](#distributed-algorithms)
- [Communication Patterns](#communication-patterns)
- [Scalability Strategies](#scalability-strategies)
- [Modern Distributed Frameworks](#modern-distributed-frameworks)

## Introduction

Distributed systems enable computing across multiple networked machines, providing scalability, fault tolerance, and geographic distribution while managing complexity and consistency challenges.

## Distributed System Models

### System Architecture Patterns
- **Client-Server**: Traditional request-response model
- **Peer-to-Peer**: Decentralized architecture
- **Service-Oriented**: SOA and microservices
- **Event-Driven**: Asynchronous message processing

### Communication Models
```python
# Synchronous RPC example
import grpc
from concurrent import futures

class CalculatorService:
    def Add(self, request, context):
        result = request.a + request.b
        return CalculatorResponse(result=result)

# Asynchronous message passing
import asyncio
import aioredis

async def publish_message(channel, message):
    redis = await aioredis.from_url("redis://localhost")
    await redis.publish(channel, message)
```

### Distributed System Properties
- **Scalability**: Horizontal and vertical scaling
- **Availability**: System uptime guarantees
- **Partition tolerance**: Network failure resilience
- **Consistency**: Data consistency guarantees

### CAP Theorem
- **Consistency**: All nodes see same data
- **Availability**: System remains operational
- **Partition tolerance**: System continues despite network failures
- **Trade-offs**: Choose two of three properties

## Consistency & Consensus

### Consistency Models
- **Strong consistency**: Linearizability guarantees
- **Eventual consistency**: Convergence over time
- **Causal consistency**: Causal ordering preservation
- **Session consistency**: Per-session guarantees

### Consensus Algorithms
```python
# Raft consensus implementation sketch
class RaftNode:
    def __init__(self, node_id):
        self.node_id = node_id
        self.state = 'follower'
        self.current_term = 0
        self.voted_for = None
        self.log = []
        self.commit_index = 0
    
    def request_vote(self, term, candidate_id, last_log_index, last_log_term):
        if term > self.current_term:
            self.current_term = term
            self.voted_for = None
            self.state = 'follower'
        
        vote_granted = (
            term >= self.current_term and
            (self.voted_for is None or self.voted_for == candidate_id)
        )
        
        if vote_granted:
            self.voted_for = candidate_id
        
        return vote_granted, self.current_term
```

### Popular Consensus Protocols
- **Raft**: Understandable consensus algorithm
- **PBFT**: Byzantine fault tolerance
- **Paxos**: Classic consensus protocol
- **RAFT vs Paxos**: Trade-offs and use cases

### Distributed Transactions
- **Two-Phase Commit**: Atomic transaction protocol
- **Three-Phase Commit**: Non-blocking variant
- **SAGA pattern**: Long-running transactions
- **Eventual consistency**: BASE properties

## Fault Tolerance & Reliability

### Failure Models
- **Crash failures**: Node stops responding
- **Omission failures**: Message loss
- **Byzantine failures**: Arbitrary behavior
- **Network partitions**: Split-brain scenarios

### Replication Strategies
```python
# Master-slave replication example
class ReplicationManager:
    def __init__(self):
        self.master = None
        self.slaves = []
        self.consistency_level = 'quorum'
    
    async def write_data(self, key, value):
        # Write to master first
        await self.master.write(key, value)
        
        # Replicate to slaves
        replicas_written = 0
        required_replicas = len(self.slaves) // 2 + 1
        
        for slave in self.slaves:
            try:
                await slave.write(key, value)
                replicas_written += 1
                if replicas_written >= required_replicas:
                    break
            except Exception:
                continue
        
        return replicas_written >= required_replicas
```

### Fault Detection
- **Heartbeat mechanisms**: Liveness detection
- **Failure detectors**: Unreliable vs reliable
- **Circuit breakers**: Cascading failure prevention
- **Health checks**: Service monitoring

### Recovery Mechanisms
- Checkpointing and rollback
- Write-ahead logging
- State machine replication
- Byzantine fault tolerance

## Distributed Algorithms

### Leader Election
```python
# Bully algorithm implementation
class BullyElection:
    def __init__(self, node_id, all_nodes):
        self.node_id = node_id
        self.all_nodes = all_nodes
        self.coordinator = None
    
    def start_election(self):
        higher_nodes = [n for n in self.all_nodes if n > self.node_id]
        
        if not higher_nodes:
            # I am the coordinator
            self.coordinator = self.node_id
            self.broadcast_coordinator()
        else:
            # Send election message to higher nodes
            responses = []
            for node in higher_nodes:
                response = self.send_election_message(node)
                responses.append(response)
            
            if not any(responses):
                # No responses, I become coordinator
                self.coordinator = self.node_id
                self.broadcast_coordinator()
```

### Distributed Sorting
- **Distributed merge sort**: Parallel sorting
- **Bitonic sort**: Network-based sorting
- **Sample sort**: Load-balanced approach
- **External sorting**: Large dataset handling

### Graph Algorithms
- **PageRank**: Distributed graph ranking
- **Shortest paths**: Distributed Dijkstra
- **Connected components**: Graph traversal
- **Graph partitioning**: Load distribution

### Clock Synchronization
- **Lamport timestamps**: Logical ordering
- **Vector clocks**: Causal relationships
- **NTP**: Network time synchronization
- **Hybrid logical clocks**: Physical and logical time

## Communication Patterns

### Message Passing
```python
# Message queue pattern with Redis
import redis
import json

class MessageQueue:
    def __init__(self, redis_host='localhost'):
        self.redis = redis.Redis(host=redis_host, decode_responses=True)
    
    def publish(self, topic, message):
        self.redis.lpush(topic, json.dumps(message))
    
    def subscribe(self, topic, callback):
        while True:
            message = self.redis.brpop(topic, timeout=1)
            if message:
                data = json.loads(message[1])
                callback(data)
```

### Publish-Subscribe
- **Apache Kafka**: Distributed streaming platform
- **Apache Pulsar**: Cloud-native messaging
- **Redis Pub/Sub**: Lightweight messaging
- **NATS**: High-performance messaging

### Request-Response Patterns
- **RPC frameworks**: gRPC, Apache Thrift
- **REST APIs**: HTTP-based communication
- **GraphQL**: Flexible query language
- **WebSockets**: Real-time communication

### Event Sourcing
- Event store design
- Projection strategies
- Snapshot optimization
- CQRS pattern integration

## Scalability Strategies

### Horizontal Scaling
```python
# Consistent hashing for load distribution
import hashlib

class ConsistentHash:
    def __init__(self, nodes=None, replicas=3):
        self.replicas = replicas
        self.ring = {}
        self.sorted_keys = []
        
        if nodes:
            for node in nodes:
                self.add_node(node)
    
    def _hash(self, key):
        return int(hashlib.md5(key.encode()).hexdigest(), 16)
    
    def add_node(self, node):
        for i in range(self.replicas):
            key = self._hash(f"{node}:{i}")
            self.ring[key] = node
            self.sorted_keys.append(key)
        self.sorted_keys.sort()
    
    def get_node(self, key):
        if not self.ring:
            return None
        
        hash_key = self._hash(key)
        for ring_key in self.sorted_keys:
            if hash_key <= ring_key:
                return self.ring[ring_key]
        
        return self.ring[self.sorted_keys[0]]
```

### Load Balancing
- **Round-robin**: Equal distribution
- **Weighted round-robin**: Capacity-based
- **Least connections**: Connection-aware
- **Consistent hashing**: Minimized redistribution

### Caching Strategies
- **Distributed caching**: Redis, Memcached
- **CDN integration**: Geographic distribution
- **Cache coherence**: Consistency protocols
- **Cache partitioning**: Sharding strategies

### Database Scaling
- **Sharding**: Horizontal partitioning
- **Read replicas**: Read scalability
- **Federation**: Functional partitioning
- **Denormalization**: Performance optimization

## Modern Distributed Frameworks

### Container Orchestration
```yaml
# Kubernetes deployment example
apiVersion: apps/v1
kind: Deployment
metadata:
  name: microservice-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: microservice
  template:
    metadata:
      labels:
        app: microservice
    spec:
      containers:
      - name: microservice
        image: my-microservice:latest
        ports:
        - containerPort: 8080
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

### Service Mesh
- **Istio**: Comprehensive service mesh
- **Linkerd**: Lightweight proxy
- **Consul Connect**: HashiCorp solution
- **Traffic management**: Routing, load balancing

### Stream Processing
- **Apache Kafka Streams**: Stream processing library
- **Apache Flink**: Low-latency processing
- **Apache Storm**: Real-time computation
- **Akka Streams**: Reactive streams

### Serverless Computing
- Function-as-a-Service platforms
- Event-driven architectures
- Cold start optimization
- State management challenges

---

*This guide covers advanced distributed systems concepts for building scalable, fault-tolerant, and reliable distributed applications.*

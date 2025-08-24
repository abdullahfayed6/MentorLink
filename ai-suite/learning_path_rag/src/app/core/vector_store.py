"""
Vector store implementation for learning path documents
"""

import os
import logging
from pathlib import Path
from typing import List, Dict, Any, Optional
import numpy as np
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import pickle
import hashlib

logger = logging.getLogger(__name__)

class VectorStore:
    """Simple vector store for document embeddings"""
    
    def __init__(self, model_name: str = "all-MiniLM-L6-v2"):
        """Initialize vector store with embedding model"""
        self.model_name = model_name
        self.model = None
        self.documents = []
        self.embeddings = None
        self.metadata = []
        
    def load_model(self):
        """Load the embedding model"""
        if self.model is None:
            try:
                self.model = SentenceTransformer(self.model_name)
                logger.info(f"✅ Loaded embedding model: {self.model_name}")
            except Exception as e:
                logger.error(f"❌ Failed to load embedding model: {e}")
                raise
    
    def add_documents(self, documents: List[str], metadata: List[Dict] = None):
        """Add documents to the vector store"""
        if not self.model:
            self.load_model()
            
        logger.info(f"Adding {len(documents)} documents to vector store...")
        
        # Generate embeddings
        try:
            new_embeddings = self.model.encode(documents, show_progress_bar=True)
            
            # Add to existing data
            self.documents.extend(documents)
            if metadata:
                self.metadata.extend(metadata)
            else:
                self.metadata.extend([{}] * len(documents))
            
            # Combine embeddings
            if self.embeddings is None:
                self.embeddings = new_embeddings
            else:
                self.embeddings = np.vstack([self.embeddings, new_embeddings])
                
            logger.info(f"✅ Added {len(documents)} documents. Total: {len(self.documents)}")
            
        except Exception as e:
            logger.error(f"❌ Failed to add documents: {e}")
            raise
    
    def search(self, query: str, top_k: int = 5, threshold: float = 0.3) -> List[Dict]:
        """Search for similar documents"""
        if not self.model:
            self.load_model()
            
        if self.embeddings is None or len(self.documents) == 0:
            logger.warning("No documents in vector store")
            return []
        
        try:
            # Generate query embedding
            query_embedding = self.model.encode([query])
            
            # Calculate similarities
            similarities = cosine_similarity(query_embedding, self.embeddings)[0]
            
            # Get top results
            top_indices = np.argsort(similarities)[::-1][:top_k]
            
            results = []
            for idx in top_indices:
                similarity = similarities[idx]
                if similarity >= threshold:
                    results.append({
                        'content': self.documents[idx],
                        'metadata': self.metadata[idx],
                        'similarity': float(similarity),
                        'index': int(idx)
                    })
            
            logger.info(f"Found {len(results)} relevant documents for query")
            return results
            
        except Exception as e:
            logger.error(f"❌ Search failed: {e}")
            return []
    
    def save(self, filepath: str):
        """Save vector store to disk"""
        try:
            data = {
                'documents': self.documents,
                'embeddings': self.embeddings,
                'metadata': self.metadata,
                'model_name': self.model_name
            }
            
            os.makedirs(os.path.dirname(filepath), exist_ok=True)
            with open(filepath, 'wb') as f:
                pickle.dump(data, f)
                
            logger.info(f"✅ Vector store saved to {filepath}")
            
        except Exception as e:
            logger.error(f"❌ Failed to save vector store: {e}")
            raise
    
    def load(self, filepath: str):
        """Load vector store from disk"""
        try:
            if not os.path.exists(filepath):
                logger.warning(f"Vector store file not found: {filepath}")
                return False
                
            with open(filepath, 'rb') as f:
                data = pickle.load(f)
            
            self.documents = data.get('documents', [])
            self.embeddings = data.get('embeddings')
            self.metadata = data.get('metadata', [])
            self.model_name = data.get('model_name', self.model_name)
            
            logger.info(f"✅ Vector store loaded from {filepath}. Documents: {len(self.documents)}")
            return True
            
        except Exception as e:
            logger.error(f"❌ Failed to load vector store: {e}")
            return False
    
    def get_stats(self) -> Dict[str, Any]:
        """Get vector store statistics"""
        return {
            'total_documents': len(self.documents),
            'embedding_dimension': self.embeddings.shape[1] if self.embeddings is not None else 0,
            'model_name': self.model_name,
            'has_embeddings': self.embeddings is not None
        }

# Global instance
_vector_store_instance: Optional[VectorStore] = None

def get_vector_store() -> VectorStore:
    """Get or create vector store instance"""
    global _vector_store_instance
    if _vector_store_instance is None:
        _vector_store_instance = VectorStore()
    return _vector_store_instance

def initialize_vector_store(data_path: str = None) -> VectorStore:
    """Initialize vector store with learning path documents"""
    vector_store = get_vector_store()
    
    # Try to load existing vector store
    storage_path = os.path.join("storage", "vector_store.pkl")
    if vector_store.load(storage_path):
        return vector_store
    
    # If no existing store, create new one
    if data_path is None:
        data_path = os.path.join("data", "docs_learning_path")
    
    if not os.path.exists(data_path):
        logger.warning(f"Data path not found: {data_path}")
        return vector_store
    
    # Load documents from markdown files
    documents = []
    metadata = []
    
    for file_path in Path(data_path).glob("*.md"):
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                documents.append(content)
                metadata.append({
                    'filename': file_path.name,
                    'path': str(file_path),
                    'topic': file_path.stem.replace('_', ' ').title()
                })
        except Exception as e:
            logger.error(f"Failed to load {file_path}: {e}")
    
    if documents:
        vector_store.add_documents(documents, metadata)
        
        # Save for future use
        try:
            vector_store.save(storage_path)
        except Exception as e:
            logger.warning(f"Failed to save vector store: {e}")
    
    return vector_store

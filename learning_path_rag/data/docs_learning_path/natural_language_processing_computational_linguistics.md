# Natural Language Processing & Computational Linguistics

## Table of Contents
- [Introduction](#introduction)
- [Text Processing Fundamentals](#text-processing-fundamentals)
- [Language Models](#language-models)
- [Named Entity Recognition](#named-entity-recognition)
- [Sentiment Analysis](#sentiment-analysis)
- [Machine Translation](#machine-translation)
- [Question Answering Systems](#question-answering-systems)
- [Advanced NLP Techniques](#advanced-nlp-techniques)

## Introduction

Natural Language Processing (NLP) enables computers to understand, interpret, and generate human language, combining computational linguistics with machine learning and AI.

## Text Processing Fundamentals

### Text Preprocessing
```python
import nltk
import spacy
from transformers import AutoTokenizer

# Traditional preprocessing
def preprocess_text(text):
    # Tokenization
    tokens = nltk.word_tokenize(text.lower())
    
    # Remove stopwords
    stop_words = set(nltk.corpus.stopwords.words('english'))
    filtered_tokens = [w for w in tokens if w not in stop_words]
    
    # Lemmatization
    lemmatizer = nltk.stem.WordNetLemmatizer()
    lemmatized = [lemmatizer.lemmatize(token) for token in filtered_tokens]
    
    return lemmatized
```

### Tokenization Techniques
- **Word-level tokenization**: Traditional approach
- **Subword tokenization**: BPE, SentencePiece, WordPiece
- **Character-level**: Fine-grained representation
- **Morphological analysis**: Root and affix separation

### Text Representation
- **Bag of Words**: Frequency-based vectors
- **TF-IDF**: Term frequency-inverse document frequency
- **Word embeddings**: Word2Vec, GloVe, FastText
- **Contextual embeddings**: BERT, RoBERTa, GPT

### Syntactic Analysis
- Part-of-speech tagging
- Dependency parsing
- Constituency parsing
- Semantic role labeling

## Language Models

### N-gram Models
```python
from collections import defaultdict, Counter

class NGramModel:
    def __init__(self, n):
        self.n = n
        self.ngrams = defaultdict(Counter)
    
    def train(self, corpus):
        for sentence in corpus:
            tokens = ['<s>'] * (self.n - 1) + sentence + ['</s>']
            for i in range(len(tokens) - self.n + 1):
                context = tuple(tokens[i:i+self.n-1])
                next_word = tokens[i+self.n-1]
                self.ngrams[context][next_word] += 1
```

### Neural Language Models
- **RNN-based**: LSTM, GRU architectures
- **Transformer-based**: GPT, BERT, T5
- **Autoregressive**: Left-to-right generation
- **Masked language models**: Bidirectional context

### Large Language Models
- **GPT series**: GPT-3, GPT-4, ChatGPT
- **BERT family**: BERT, RoBERTa, DeBERTa
- **T5**: Text-to-Text Transfer Transformer
- **PaLM**: Pathways Language Model

### Training Techniques
- Pretraining strategies
- Fine-tuning approaches
- In-context learning
- Prompt engineering

## Named Entity Recognition

### Traditional Approaches
```python
import spacy

# spaCy NER example
nlp = spacy.load("en_core_web_sm")

def extract_entities(text):
    doc = nlp(text)
    entities = [(ent.text, ent.label_, ent.start_char, ent.end_char) 
                for ent in doc.ents]
    return entities
```

### Deep Learning Methods
- **BiLSTM-CRF**: Sequence labeling
- **BERT-based NER**: Contextual understanding
- **SpaCy transformers**: Production-ready models
- **Custom entity extraction**: Domain-specific models

### Entity Linking
- Knowledge base integration
- Disambiguation techniques
- Coreference resolution
- Relation extraction

### Applications
- Information extraction
- Knowledge graph construction
- Document understanding
- Content analysis

## Sentiment Analysis

### Approaches
```python
from transformers import pipeline

# Transformer-based sentiment analysis
sentiment_analyzer = pipeline("sentiment-analysis")

def analyze_sentiment(texts):
    results = sentiment_analyzer(texts)
    return [(text, result['label'], result['score']) 
            for text, result in zip(texts, results)]
```

### Techniques
- **Lexicon-based**: VADER, TextBlob
- **Machine learning**: SVM, Naive Bayes
- **Deep learning**: CNN, LSTM, Transformers
- **Aspect-based**: Fine-grained analysis

### Challenges
- Sarcasm detection
- Context understanding
- Multilingual sentiment
- Domain adaptation

### Applications
- Social media monitoring
- Customer feedback analysis
- Brand reputation management
- Market research

## Machine Translation

### Statistical Machine Translation
- **Phrase-based MT**: Statistical alignment
- **Hierarchical MT**: Syntactic structures
- **Factored models**: Linguistic factors
- **Domain adaptation**: Specialized translation

### Neural Machine Translation
```python
from transformers import MarianMTModel, MarianTokenizer

# Neural machine translation example
model_name = 'Helsinki-NLP/opus-mt-en-de'
tokenizer = MarianTokenizer.from_pretrained(model_name)
model = MarianMTModel.from_pretrained(model_name)

def translate_text(text):
    tokens = tokenizer(text, return_tensors="pt", padding=True)
    translated = model.generate(**tokens)
    return tokenizer.decode(translated[0], skip_special_tokens=True)
```

### Advanced Architectures
- **Transformer models**: Attention mechanisms
- **Multilingual models**: mBART, M2M-100
- **Zero-shot translation**: Language-agnostic models
- **Back-translation**: Data augmentation

### Evaluation Metrics
- BLEU score
- ROUGE metrics
- METEOR score
- Human evaluation

## Question Answering Systems

### Types of QA Systems
- **Extractive QA**: Answer extraction from text
- **Generative QA**: Answer generation
- **Open-domain QA**: Web-scale question answering
- **Reading comprehension**: Context-based QA

### Implementation
```python
from transformers import pipeline

# Question answering pipeline
qa_pipeline = pipeline("question-answering")

def answer_question(question, context):
    result = qa_pipeline(question=question, context=context)
    return {
        'answer': result['answer'],
        'confidence': result['score'],
        'start': result['start'],
        'end': result['end']
    }
```

### Advanced Techniques
- **Retrieval-augmented generation**: RAG models
- **Knowledge-grounded QA**: External knowledge integration
- **Multi-hop reasoning**: Complex question handling
- **Conversational QA**: Dialog-based systems

### Applications
- Customer support chatbots
- Educational systems
- Information retrieval
- Virtual assistants

## Advanced NLP Techniques

### Text Summarization
```python
from transformers import pipeline

# Abstractive summarization
summarizer = pipeline("summarization", model="facebook/bart-large-cnn")

def summarize_text(text, max_length=130, min_length=30):
    summary = summarizer(text, max_length=max_length, 
                        min_length=min_length, do_sample=False)
    return summary[0]['summary_text']
```

### Text Generation
- **Controlled generation**: Topic-specific content
- **Style transfer**: Writing style adaptation
- **Data-to-text**: Structured data narration
- **Creative writing**: Story and poetry generation

### Dialogue Systems
- **Task-oriented**: Goal-driven conversations
- **Open-domain**: General conversation
- **Multimodal**: Text, speech, and vision integration
- **Persona-based**: Personality-driven responses

### Information Extraction
- Event extraction
- Temporal relation extraction
- Causal relation mining
- Knowledge graph population

### Cross-lingual NLP
- Multilingual models
- Zero-shot transfer learning
- Cross-lingual embeddings
- Code-switching handling

---

*This guide covers advanced natural language processing techniques for building sophisticated language understanding systems.*

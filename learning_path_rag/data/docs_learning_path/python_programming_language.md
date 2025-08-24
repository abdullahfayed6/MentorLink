# Python Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Functions](#functions)
- [Object-Oriented Programming](#object-oriented-programming)
- [File Handling](#file-handling)
- [Libraries and Modules](#libraries-and-modules)

## Introduction

Python is a high-level, interpreted programming language known for its simplicity and readability. It's widely used in web development, data science, artificial intelligence, and automation.

## Syntax Basics

### Hello World
```python
print("Hello, World!")
```

### Variables and Assignment
```python
# Variable assignment
name = "Alice"
age = 30
height = 5.6
is_student = True

# Multiple assignment
x, y, z = 10, 20, 30

# Swapping variables
a, b = 5, 3
a, b = b, a  # Now a=3, b=5
```

### Comments
```python
# This is a single-line comment

"""
This is a 
multi-line comment
or docstring
"""
```

## Data Types

### Numbers
```python
# Integer
num_int = 42

# Float
num_float = 3.14

# Complex
num_complex = 2 + 3j

# Operations
result = 10 + 5 * 2  # 20
power = 2 ** 3       # 8
division = 10 / 3    # 3.333...
floor_div = 10 // 3  # 3
modulo = 10 % 3      # 1
```

### Strings
```python
# String creation
single_quotes = 'Hello'
double_quotes = "World"
multi_line = """This is a
multi-line string"""

# String operations
full_name = "John" + " " + "Doe"  # Concatenation
repeated = "Ha" * 3               # "HaHaHa"

# String methods
text = "Hello World"
print(text.lower())      # hello world
print(text.upper())      # HELLO WORLD
print(text.split())      # ['Hello', 'World']
print(text.replace("Hello", "Hi"))  # Hi World

# String formatting
name = "Alice"
age = 30
print(f"My name is {name} and I am {age} years old")
print("My name is {} and I am {} years old".format(name, age))
```

### Lists
```python
# List creation
fruits = ["apple", "banana", "cherry"]
numbers = [1, 2, 3, 4, 5]
mixed = [1, "hello", 3.14, True]

# List operations
fruits.append("orange")      # Add to end
fruits.insert(1, "grape")   # Insert at index
removed = fruits.pop()       # Remove and return last
fruits.remove("banana")     # Remove specific item

# List slicing
print(numbers[1:4])    # [2, 3, 4]
print(numbers[:3])     # [1, 2, 3]
print(numbers[2:])     # [3, 4, 5]
print(numbers[::-1])   # [5, 4, 3, 2, 1] (reverse)

# List comprehensions
squares = [x**2 for x in range(10)]
evens = [x for x in range(20) if x % 2 == 0]
```

### Dictionaries
```python
# Dictionary creation
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

# Accessing values
print(person["name"])        # John
print(person.get("age"))     # 30

# Dictionary operations
person["email"] = "john@email.com"  # Add new key-value
del person["city"]                  # Remove key-value
keys = person.keys()               # Get all keys
values = person.values()           # Get all values

# Dictionary comprehension
squares = {x: x**2 for x in range(5)}
```

## Control Structures

### Conditional Statements
```python
age = 18

if age < 13:
    print("Child")
elif age < 20:
    print("Teenager")
else:
    print("Adult")

# Ternary operator
status = "Adult" if age >= 18 else "Minor"
```

### Loops
```python
# For loop
for i in range(5):
    print(i)

for fruit in ["apple", "banana", "cherry"]:
    print(fruit)

for i, value in enumerate(["a", "b", "c"]):
    print(f"Index: {i}, Value: {value}")

# While loop
count = 0
while count < 5:
    print(count)
    count += 1

# Loop control
for i in range(10):
    if i == 3:
        continue  # Skip this iteration
    if i == 7:
        break     # Exit the loop
    print(i)
```

## Functions

### Function Definition
```python
def greet(name):
    return f"Hello, {name}!"

def add(a, b=0):  # Default parameter
    return a + b

def multiply(*args):  # Variable arguments
    result = 1
    for num in args:
        result *= num
    return result

def person_info(**kwargs):  # Keyword arguments
    for key, value in kwargs.items():
        print(f"{key}: {value}")

# Function calls
print(greet("Alice"))
print(add(5, 3))
print(multiply(2, 3, 4))
person_info(name="John", age=30, city="NYC")
```

### Lambda Functions
```python
# Lambda function
square = lambda x: x**2
print(square(5))  # 25

# Using with built-in functions
numbers = [1, 2, 3, 4, 5]
squares = list(map(lambda x: x**2, numbers))
evens = list(filter(lambda x: x % 2 == 0, numbers))
```

## Object-Oriented Programming

### Classes and Objects
```python
class Person:
    # Class variable
    species = "Homo sapiens"
    
    def __init__(self, name, age):
        # Instance variables
        self.name = name
        self.age = age
    
    def introduce(self):
        return f"Hi, I'm {self.name} and I'm {self.age} years old"
    
    def have_birthday(self):
        self.age += 1
        return self.age

# Creating objects
person1 = Person("Alice", 25)
person2 = Person("Bob", 30)

print(person1.introduce())
print(person1.have_birthday())
```

### Inheritance
```python
class Animal:
    def __init__(self, name):
        self.name = name
    
    def speak(self):
        pass

class Dog(Animal):
    def speak(self):
        return f"{self.name} says Woof!"

class Cat(Animal):
    def speak(self):
        return f"{self.name} says Meow!"

# Using inheritance
dog = Dog("Buddy")
cat = Cat("Whiskers")

print(dog.speak())
print(cat.speak())
```

## File Handling

### Reading and Writing Files
```python
# Writing to a file
with open("example.txt", "w") as file:
    file.write("Hello, World!")
    file.write("\nThis is a new line.")

# Reading from a file
with open("example.txt", "r") as file:
    content = file.read()
    print(content)

# Reading line by line
with open("example.txt", "r") as file:
    for line in file:
        print(line.strip())

# Appending to a file
with open("example.txt", "a") as file:
    file.write("\nAppended text")
```

## Libraries and Modules

### Importing Modules
```python
import math
import random
from datetime import datetime, timedelta

# Using imported modules
print(math.pi)
print(math.sqrt(16))
print(random.randint(1, 10))
print(datetime.now())
```

### Popular Libraries
```python
# requests - HTTP library
# import requests
# response = requests.get("https://api.github.com")

# pandas - Data manipulation
# import pandas as pd
# df = pd.read_csv("data.csv")

# numpy - Numerical computing
# import numpy as np
# array = np.array([1, 2, 3, 4, 5])

# matplotlib - Plotting
# import matplotlib.pyplot as plt
# plt.plot([1, 2, 3, 4], [1, 4, 9, 16])
# plt.show()
```

### Creating Your Own Module
```python
# Save this as math_utils.py
def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

# Using the module
# from math_utils import factorial, is_prime
# print(factorial(5))
# print(is_prime(17))
```

---

*Python is an excellent language for beginners and experienced developers alike, offering simplicity, versatility, and a vast ecosystem of libraries.*

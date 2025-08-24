# JavaScript Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Functions](#functions)
- [Objects and Classes](#objects-and-classes)
- [DOM Manipulation](#dom-manipulation)
- [Asynchronous Programming](#asynchronous-programming)
- [Modern JavaScript Features](#modern-javascript-features)

## Introduction

JavaScript is a dynamic, interpreted programming language that's essential for web development. It runs in browsers and on servers (Node.js), making it versatile for both frontend and backend development.

## Syntax Basics

### Hello World
```javascript
console.log("Hello, World!");
alert("Hello from JavaScript!");
```

### Variables
```javascript
// var (function-scoped, can be redeclared)
var name = "John";
var age = 30;

// let (block-scoped, cannot be redeclared)
let city = "New York";
let isStudent = true;

// const (block-scoped, cannot be reassigned)
const PI = 3.14159;
const colors = ["red", "green", "blue"];

// Multiple variable declaration
let a = 1, b = 2, c = 3;

// Variable naming rules
let userName = "alice";     // camelCase
let user_name = "bob";      // snake_case
let $element = document;    // Can start with $
let _private = "hidden";    // Can start with _
```

### Comments
```javascript
// Single-line comment

/*
Multi-line comment
Can span multiple lines
*/

/**
 * JSDoc comment for documentation
 * @param {string} name - The user's name
 * @returns {string} A greeting message
 */
function greet(name) {
    return `Hello, ${name}!`;
}
```

## Data Types

### Primitive Types
```javascript
// Number
let integer = 42;
let float = 3.14;
let negative = -17;
let scientific = 2.5e10;
let infinity = Infinity;
let notANumber = NaN;

// String
let singleQuote = 'Hello';
let doubleQuote = "World";
let templateLiteral = `Hello ${name}, you are ${age} years old`;

// Boolean
let isTrue = true;
let isFalse = false;

// Undefined
let undefinedVar;
console.log(undefinedVar); // undefined

// Null
let emptyVar = null;

// Symbol (ES6)
let sym1 = Symbol('description');
let sym2 = Symbol('description');
console.log(sym1 === sym2); // false

// BigInt (for large integers)
let bigNumber = 1234567890123456789012345678901234567890n;
```

### Type Conversion
```javascript
// String conversion
let num = 42;
let str = String(num);        // "42"
let str2 = num.toString();    // "42"
let str3 = `${num}`;          // "42"

// Number conversion
let text = "123";
let number = Number(text);    // 123
let parsed = parseInt(text);  // 123
let floated = parseFloat("123.45"); // 123.45

// Boolean conversion
let bool1 = Boolean(1);       // true
let bool2 = Boolean(0);       // false
let bool3 = Boolean("");      // false
let bool4 = Boolean("text");  // true

// Type checking
console.log(typeof 42);           // "number"
console.log(typeof "hello");      // "string"
console.log(typeof true);         // "boolean"
console.log(typeof undefined);    // "undefined"
console.log(typeof null);         // "object" (this is a known quirk)
console.log(Array.isArray([]));   // true
```

### Arrays
```javascript
// Array creation
let fruits = ["apple", "banana", "cherry"];
let numbers = [1, 2, 3, 4, 5];
let mixed = [1, "hello", true, null];
let empty = [];

// Array access and modification
console.log(fruits[0]);        // "apple"
fruits[1] = "blueberry";       // Change element
fruits.push("orange");         // Add to end
let last = fruits.pop();       // Remove from end
fruits.unshift("grape");       // Add to beginning
let first = fruits.shift();    // Remove from beginning

// Array methods
let length = fruits.length;
let joined = fruits.join(", ");           // "grape,blueberry,cherry,orange"
let sliced = fruits.slice(1, 3);         // ["blueberry", "cherry"]
let found = fruits.indexOf("cherry");     // 2
let exists = fruits.includes("apple");    // false

// Array iteration
fruits.forEach(function(fruit, index) {
    console.log(`${index}: ${fruit}`);
});

// Array transformation
let uppercased = fruits.map(fruit => fruit.toUpperCase());
let filtered = fruits.filter(fruit => fruit.length > 5);
let total = numbers.reduce((sum, num) => sum + num, 0);
```

### Objects
```javascript
// Object creation
let person = {
    name: "Alice",
    age: 30,
    city: "New York",
    isStudent: false
};

// Object access
console.log(person.name);        // "Alice"
console.log(person["age"]);      // 30

// Object modification
person.email = "alice@email.com"; // Add property
person.age = 31;                  // Modify property
delete person.city;               // Delete property

// Object methods
let calculator = {
    add: function(a, b) {
        return a + b;
    },
    subtract(a, b) {           // ES6 shorthand
        return a - b;
    },
    multiply: (a, b) => a * b  // Arrow function
};

console.log(calculator.add(5, 3));      // 8
console.log(calculator.subtract(10, 4)); // 6

// Object destructuring
let {name, age} = person;
console.log(name); // "Alice"
console.log(age);  // 31

// Object methods
let keys = Object.keys(person);         // ["name", "age", "isStudent", "email"]
let values = Object.values(person);     // ["Alice", 31, false, "alice@email.com"]
let entries = Object.entries(person);   // [["name", "Alice"], ["age", 31], ...]
```

## Functions

### Function Declaration and Expression
```javascript
// Function declaration
function greet(name) {
    return `Hello, ${name}!`;
}

// Function expression
let sayBye = function(name) {
    return `Goodbye, ${name}!`;
};

// Arrow function (ES6)
let add = (a, b) => a + b;
let square = x => x * x;
let sayHello = () => console.log("Hello!");

// Function with default parameters
function introduce(name, age = 25) {
    return `I'm ${name} and I'm ${age} years old`;
}

// Rest parameters
function sum(...numbers) {
    return numbers.reduce((total, num) => total + num, 0);
}

console.log(sum(1, 2, 3, 4, 5)); // 15

// Function calls
console.log(greet("World"));
console.log(sayBye("Friend"));
console.log(add(5, 3));
console.log(introduce("Bob"));
console.log(introduce("Alice", 30));
```

### Higher-Order Functions
```javascript
// Function that returns a function
function createMultiplier(factor) {
    return function(number) {
        return number * factor;
    };
}

let double = createMultiplier(2);
let triple = createMultiplier(3);

console.log(double(5)); // 10
console.log(triple(4)); // 12

// Function that takes a function as parameter
function processArray(arr, callback) {
    let result = [];
    for (let item of arr) {
        result.push(callback(item));
    }
    return result;
}

let numbers = [1, 2, 3, 4, 5];
let doubled = processArray(numbers, x => x * 2);
let squared = processArray(numbers, x => x * x);

console.log(doubled); // [2, 4, 6, 8, 10]
console.log(squared); // [1, 4, 9, 16, 25]
```

## Objects and Classes

### Constructor Functions
```javascript
// Constructor function
function Person(name, age) {
    this.name = name;
    this.age = age;
    this.introduce = function() {
        return `Hi, I'm ${this.name}`;
    };
}

// Creating objects
let person1 = new Person("Alice", 25);
let person2 = new Person("Bob", 30);

console.log(person1.introduce()); // "Hi, I'm Alice"

// Prototype
Person.prototype.sayAge = function() {
    return `I am ${this.age} years old`;
};

console.log(person1.sayAge()); // "I am 25 years old"
```

### ES6 Classes
```javascript
class Animal {
    constructor(name, species) {
        this.name = name;
        this.species = species;
    }
    
    speak() {
        return `${this.name} makes a sound`;
    }
    
    // Static method
    static getKingdom() {
        return "Animalia";
    }
    
    // Getter
    get info() {
        return `${this.name} is a ${this.species}`;
    }
    
    // Setter
    set rename(newName) {
        this.name = newName;
    }
}

class Dog extends Animal {
    constructor(name, breed) {
        super(name, "Canine");
        this.breed = breed;
    }
    
    speak() {
        return `${this.name} barks`;
    }
    
    fetch() {
        return `${this.name} fetches the ball`;
    }
}

// Usage
let dog = new Dog("Buddy", "Golden Retriever");
console.log(dog.speak());      // "Buddy barks"
console.log(dog.fetch());      // "Buddy fetches the ball"
console.log(dog.info);         // "Buddy is a Canine"
console.log(Animal.getKingdom()); // "Animalia"

dog.rename = "Max";
console.log(dog.name); // "Max"
```

## DOM Manipulation

### Selecting Elements
```javascript
// Select by ID
let header = document.getElementById('header');

// Select by class
let buttons = document.getElementsByClassName('btn');
let firstButton = document.querySelector('.btn');
let allButtons = document.querySelectorAll('.btn');

// Select by tag
let paragraphs = document.getElementsByTagName('p');
let firstParagraph = document.querySelector('p');

// Select by attribute
let requiredInputs = document.querySelectorAll('input[required]');
```

### Modifying Elements
```javascript
// Change content
let title = document.getElementById('title');
title.textContent = 'New Title';
title.innerHTML = '<strong>Bold Title</strong>';

// Change attributes
let image = document.querySelector('img');
image.src = 'new-image.jpg';
image.setAttribute('alt', 'New image description');

// Change styles
title.style.color = 'blue';
title.style.fontSize = '24px';
title.style.backgroundColor = '#f0f0f0';

// Add/remove classes
title.classList.add('highlight');
title.classList.remove('old-style');
title.classList.toggle('active');

// Create new elements
let newDiv = document.createElement('div');
newDiv.textContent = 'This is a new div';
newDiv.className = 'new-element';

// Append to DOM
document.body.appendChild(newDiv);

// Insert before another element
let existingElement = document.getElementById('existing');
document.body.insertBefore(newDiv, existingElement);
```

### Event Handling
```javascript
// Add event listener
let button = document.getElementById('myButton');

button.addEventListener('click', function(event) {
    console.log('Button clicked!');
    console.log(event.target); // The clicked element
});

// Arrow function event handler
button.addEventListener('click', (e) => {
    e.preventDefault(); // Prevent default behavior
    alert('Hello from arrow function!');
});

// Multiple event types
let input = document.getElementById('myInput');

input.addEventListener('focus', () => {
    input.style.backgroundColor = '#e6f3ff';
});

input.addEventListener('blur', () => {
    input.style.backgroundColor = '';
});

input.addEventListener('input', (e) => {
    console.log('Input value:', e.target.value);
});

// Event delegation
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('delete-btn')) {
        e.target.parentElement.remove();
    }
});
```

## Asynchronous Programming

### Callbacks
```javascript
// Simple callback example
function fetchData(callback) {
    setTimeout(() => {
        let data = {id: 1, name: "John Doe"};
        callback(data);
    }, 1000);
}

fetchData(function(result) {
    console.log('Received data:', result);
});
```

### Promises
```javascript
// Creating a promise
let myPromise = new Promise((resolve, reject) => {
    let success = Math.random() > 0.5;
    
    setTimeout(() => {
        if (success) {
            resolve("Operation successful!");
        } else {
            reject("Operation failed!");
        }
    }, 1000);
});

// Using the promise
myPromise
    .then(result => {
        console.log(result);
        return "Next step";
    })
    .then(nextResult => {
        console.log(nextResult);
    })
    .catch(error => {
        console.error(error);
    })
    .finally(() => {
        console.log("Promise completed");
    });

// Fetch API example
fetch('https://jsonplaceholder.typicode.com/users/1')
    .then(response => response.json())
    .then(user => {
        console.log('User:', user);
    })
    .catch(error => {
        console.error('Error:', error);
    });
```

### Async/Await
```javascript
// Async function
async function fetchUserData(userId) {
    try {
        let response = await fetch(`https://jsonplaceholder.typicode.com/users/${userId}`);
        let user = await response.json();
        return user;
    } catch (error) {
        console.error('Error fetching user:', error);
        throw error;
    }
}

// Using async function
async function displayUser() {
    try {
        let user = await fetchUserData(1);
        console.log('User name:', user.name);
        console.log('User email:', user.email);
    } catch (error) {
        console.error('Failed to display user:', error);
    }
}

displayUser();

// Multiple async operations
async function fetchMultipleUsers() {
    try {
        let promises = [
            fetchUserData(1),
            fetchUserData(2),
            fetchUserData(3)
        ];
        
        let users = await Promise.all(promises);
        console.log('All users:', users);
    } catch (error) {
        console.error('Error fetching users:', error);
    }
}
```

## Modern JavaScript Features

### Destructuring
```javascript
// Array destructuring
let numbers = [1, 2, 3, 4, 5];
let [first, second, ...rest] = numbers;
console.log(first);  // 1
console.log(second); // 2
console.log(rest);   // [3, 4, 5]

// Object destructuring
let person = {name: "Alice", age: 30, city: "NYC"};
let {name, age, city} = person;
let {name: fullName, age: years} = person; // Rename variables
```

### Template Literals
```javascript
let name = "World";
let greeting = `Hello, ${name}!`;
let multiline = `
    This is a
    multi-line
    string
`;

// Tagged template literals
function highlight(strings, ...values) {
    return strings.reduce((result, string, i) => {
        return result + string + (values[i] ? `<strong>${values[i]}</strong>` : '');
    }, '');
}

let highlighted = highlight`Hello ${name}, you are ${age} years old!`;
```

### Spread and Rest Operators
```javascript
// Spread operator
let arr1 = [1, 2, 3];
let arr2 = [4, 5, 6];
let combined = [...arr1, ...arr2]; // [1, 2, 3, 4, 5, 6]

let obj1 = {a: 1, b: 2};
let obj2 = {c: 3, d: 4};
let merged = {...obj1, ...obj2}; // {a: 1, b: 2, c: 3, d: 4}

// Rest operator in functions
function sum(...numbers) {
    return numbers.reduce((total, num) => total + num, 0);
}

console.log(sum(1, 2, 3, 4, 5)); // 15
```

### Modules (ES6)
```javascript
// math.js - Export
export function add(a, b) {
    return a + b;
}

export function subtract(a, b) {
    return a - b;
}

export default function multiply(a, b) {
    return a * b;
}

// main.js - Import
import multiply, {add, subtract} from './math.js';
import * as math from './math.js';

console.log(add(5, 3));        // 8
console.log(multiply(4, 2));   // 8
console.log(math.subtract(10, 5)); // 5
```

---

*JavaScript is the language of the web, essential for creating interactive and dynamic web applications both on the client and server side.*

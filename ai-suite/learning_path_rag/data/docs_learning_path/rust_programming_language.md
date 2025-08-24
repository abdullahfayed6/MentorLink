# Rust Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Functions](#functions)
- [Ownership and Borrowing](#ownership-and-borrowing)
- [Structs and Enums](#structs-and-enums)
- [Error Handling](#error-handling)

## Introduction

Rust is a systems programming language that focuses on memory safety, speed, and concurrency. It prevents common programming errors like null pointer dereferences and buffer overflows through its unique ownership system.

## Syntax Basics

### Hello World
```rust
fn main() {
    println!("Hello, World!");
}
```

### Variables and Mutability
```rust
fn main() {
    // Immutable variables (default)
    let name = "Alice";
    let age = 25;
    let height = 5.9;
    let is_student = true;
    
    // Mutable variables
    let mut score = 95;
    let mut city = String::from("New York");
    
    println!("Name: {}, Age: {}", name, age);
    println!("Height: {:.1}, Student: {}", height, is_student);
    
    // Modify mutable variables
    score = 97;
    city = String::from("San Francisco");
    println!("Updated - Score: {}, City: {}", score, city);
    
    // Constants (always uppercase)
    const PI: f64 = 3.14159;
    const MAX_SIZE: i32 = 100;
    
    // Variable shadowing
    let x = 5;
    let x = x + 1;  // Shadows previous x
    let x = x * 2;  // Shadows again
    println!("Final x: {}", x); // Prints 12
    
    // Type annotations
    let number: i32 = 42;
    let temperature: f64 = 98.6;
    let character: char = 'A';
    
    // Type inference
    let auto_int = 10;          // i32
    let auto_float = 3.14;      // f64
    let auto_string = "hello";  // &str
    
    println!("Number: {}, Temperature: {:.1}", number, temperature);
    println!("Character: {}, Auto values: {}, {}, {}", 
             character, auto_int, auto_float, auto_string);
}
```

### Comments and Formatting
```rust
fn main() {
    // Single-line comment
    
    /*
     * Multi-line comment
     * Can span multiple lines
     */
    
    /// Documentation comment for the following item
    /// These comments support Markdown formatting
    
    //! Inner documentation comment for the enclosing item
    
    // String formatting
    let name = "Bob";
    let age = 30;
    let height = 6.2;
    
    // Basic formatting
    println!("Hello, {}!", name);
    println!("{} is {} years old", name, age);
    
    // Positional arguments
    println!("{0} is {1} years old and {1} is a good age", name, age);
    
    // Named arguments
    println!("{name} is {age} years old and {height:.1} feet tall", 
             name = name, age = age, height = height);
    
    // Format specifiers
    println!("Binary: {:b}", 42);        // 101010
    println!("Hex: {:x}", 255);          // ff
    println!("Octal: {:o}", 64);         // 100
    println!("Scientific: {:e}", 1234.5); // 1.2345e3
    println!("Precision: {:.2}", 3.14159); // 3.14
    println!("Width: {:>10}", "hello");   // "     hello"
    println!("Zero-pad: {:05}", 42);     // 00042
}
```

## Data Types

### Scalar Types
```rust
fn main() {
    // Integer types
    let int8: i8 = -128;           // 8-bit signed
    let uint8: u8 = 255;           // 8-bit unsigned
    let int16: i16 = -32768;       // 16-bit signed
    let uint16: u16 = 65535;       // 16-bit unsigned
    let int32: i32 = -2147483648;  // 32-bit signed
    let uint32: u32 = 4294967295;  // 32-bit unsigned
    let int64: i64 = -9223372036854775808; // 64-bit signed
    let uint64: u64 = 18446744073709551615; // 64-bit unsigned
    let int_arch: isize = -100;    // Architecture-dependent signed
    let uint_arch: usize = 100;    // Architecture-dependent unsigned
    
    // Floating-point types
    let float32: f32 = 3.14;       // 32-bit
    let float64: f64 = 3.141592653589793; // 64-bit (default)
    
    // Boolean type
    let is_true: bool = true;
    let is_false: bool = false;
    
    // Character type (Unicode scalar value)
    let letter: char = 'A';
    let emoji: char = '😀';
    let chinese: char = '中';
    
    println!("Integers: i8={}, u16={}, i32={}", int8, uint16, int32);
    println!("Floats: f32={:.2}, f64={:.10}", float32, float64);
    println!("Booleans: {}, {}", is_true, is_false);
    println!("Characters: {}, {}, {}", letter, emoji, chinese);
    
    // Integer overflow handling
    let mut overflow_u8: u8 = 255;
    // overflow_u8 += 1; // This would panic in debug mode
    
    // Safe arithmetic operations
    let safe_add = overflow_u8.checked_add(1);
    match safe_add {
        Some(value) => println!("Safe add result: {}", value),
        None => println!("Overflow detected!"),
    }
    
    // Wrapping arithmetic
    let wrapped = overflow_u8.wrapping_add(1);
    println!("Wrapped add: {}", wrapped); // 0
    
    // Saturating arithmetic
    let saturated = overflow_u8.saturating_add(1);
    println!("Saturated add: {}", saturated); // 255
}
```

### Compound Types
```rust
fn main() {
    // Tuples
    let tuple: (i32, f64, char) = (42, 3.14, 'A');
    let (x, y, z) = tuple; // Destructuring
    
    println!("Tuple: {:?}", tuple);
    println!("Elements: {}, {:.2}, {}", x, y, z);
    println!("Access by index: {}, {}", tuple.0, tuple.1);
    
    // Arrays (fixed size, same type)
    let numbers: [i32; 5] = [1, 2, 3, 4, 5];
    let zeros = [0; 10]; // Array of 10 zeros
    let first = numbers[0];
    let last = numbers[numbers.len() - 1];
    
    println!("Numbers array: {:?}", numbers);
    println!("Array length: {}", numbers.len());
    println!("First: {}, Last: {}", first, last);
    
    // Slices (references to contiguous sequence of elements)
    let slice: &[i32] = &numbers[1..4]; // Elements 1, 2, 3
    println!("Slice: {:?}", slice);
    
    // String types
    let string_literal: &str = "Hello"; // String slice (immutable)
    let mut string_owned: String = String::from("World"); // Owned string
    
    // String operations
    string_owned.push_str(", Rust!");
    string_owned.push('!');
    
    let concatenated = format!("{} {}", string_literal, string_owned);
    println!("Strings: '{}', '{}'", string_literal, string_owned);
    println!("Concatenated: '{}'", concatenated);
    
    // String slicing
    let hello = &concatenated[0..5];
    let world = &concatenated[6..11];
    println!("Sliced: '{}', '{}'", hello, world);
    
    // Vectors (dynamic arrays)
    let mut vector: Vec<i32> = vec![1, 2, 3];
    vector.push(4);
    vector.push(5);
    vector.pop(); // Removes last element
    
    println!("Vector: {:?}", vector);
    println!("Vector length: {}, capacity: {}", vector.len(), vector.capacity());
    
    // Iterate over collections
    println!("Iterating over array:");
    for number in &numbers {
        print!("{} ", number);
    }
    println!();
    
    println!("Iterating with index:");
    for (index, value) in numbers.iter().enumerate() {
        println!("  Index {}: {}", index, value);
    }
}
```

### Option and Result Types
```rust
fn main() {
    // Option<T> - represents optional values
    let some_number: Option<i32> = Some(42);
    let no_number: Option<i32> = None;
    
    // Pattern matching with Option
    match some_number {
        Some(value) => println!("Found number: {}", value),
        None => println!("No number found"),
    }
    
    // Using Option methods
    let doubled = some_number.map(|x| x * 2);
    let default_value = no_number.unwrap_or(0);
    
    println!("Doubled: {:?}", doubled);
    println!("Default value: {}", default_value);
    
    // Result<T, E> - represents success or failure
    let success: Result<i32, String> = Ok(100);
    let failure: Result<i32, String> = Err(String::from("Something went wrong"));
    
    // Pattern matching with Result
    match success {
        Ok(value) => println!("Success: {}", value),
        Err(error) => println!("Error: {}", error),
    }
    
    match failure {
        Ok(value) => println!("Success: {}", value),
        Err(error) => println!("Error: {}", error),
    }
    
    // Using Result methods
    let doubled_result = success.map(|x| x * 2);
    let default_on_error = failure.unwrap_or(0);
    
    println!("Doubled result: {:?}", doubled_result);
    println!("Default on error: {}", default_on_error);
    
    // Chaining operations
    let processed = some_number
        .map(|x| x * 2)
        .filter(|&x| x > 50)
        .unwrap_or(0);
    
    println!("Processed: {}", processed);
}
```

## Control Structures

### Conditional Statements
```rust
fn main() {
    let score = 85;
    
    // if-else expression
    let grade = if score >= 90 {
        "A"
    } else if score >= 80 {
        "B"
    } else if score >= 70 {
        "C"
    } else {
        "F"
    };
    
    println!("Score: {}, Grade: {}", score, grade);
    
    // if as expression
    let number = 6;
    let description = if number % 2 == 0 {
        "even"
    } else {
        "odd"
    };
    
    println!("{} is {}", number, description);
    
    // Pattern matching with match
    let day = 3;
    let day_name = match day {
        1 => "Monday",
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thursday",
        5 => "Friday",
        6 | 7 => "Weekend", // Multiple patterns
        _ => "Invalid day", // Default case
    };
    
    println!("Day {}: {}", day, day_name);
    
    // Match with ranges
    let temperature = 75;
    let comfort = match temperature {
        0..=32 => "Freezing",
        33..=60 => "Cool",
        61..=80 => "Comfortable",
        81..=100 => "Hot",
        _ => "Extreme",
    };
    
    println!("Temperature {}: {}", temperature, comfort);
    
    // Match with guards
    let pair = (2, 5);
    match pair {
        (x, y) if x < y => println!("{} < {}", x, y),
        (x, y) if x > y => println!("{} > {}", x, y),
        (x, y) => println!("{} == {}", x, y),
    }
    
    // Destructuring in match
    let point = (3, 4);
    match point {
        (0, 0) => println!("Origin"),
        (x, 0) => println!("On x-axis at {}", x),
        (0, y) => println!("On y-axis at {}", y),
        (x, y) => println!("Point at ({}, {})", x, y),
    }
}
```

### Loops
```rust
fn main() {
    // loop - infinite loop
    let mut counter = 0;
    let result = loop {
        counter += 1;
        if counter == 5 {
            break counter * 2; // Return value from loop
        }
    };
    println!("Loop result: {}", result);
    
    // while loop
    let mut number = 3;
    while number != 0 {
        println!("{}!", number);
        number -= 1;
    }
    println!("Liftoff!");
    
    // for loop with range
    println!("Counting up:");
    for i in 1..=5 {
        println!("  {}", i);
    }
    
    println!("Counting down:");
    for i in (1..=5).rev() {
        println!("  {}", i);
    }
    
    // for loop with collections
    let numbers = [10, 20, 30, 40, 50];
    println!("Array elements:");
    for number in &numbers {
        println!("  {}", number);
    }
    
    // for loop with enumerate
    println!("Array with indices:");
    for (index, value) in numbers.iter().enumerate() {
        println!("  Index {}: {}", index, value);
    }
    
    // Nested loops with labels
    'outer: for i in 1..=3 {
        for j in 1..=3 {
            if i == 2 && j == 2 {
                break 'outer; // Break outer loop
            }
            println!("({}, {})", i, j);
        }
    }
    
    // Loop control
    println!("Skip even numbers:");
    for i in 1..=10 {
        if i % 2 == 0 {
            continue; // Skip even numbers
        }
        println!("  {}", i);
    }
    
    // while let pattern
    let mut optional = Some(5);
    while let Some(value) = optional {
        println!("Optional value: {}", value);
        if value == 1 {
            optional = None;
        } else {
            optional = Some(value - 1);
        }
    }
}
```

## Functions

### Function Definition and Parameters
```rust
fn main() {
    // Function calls
    greet();
    
    let sum = add(5, 3);
    println!("5 + 3 = {}", sum);
    
    let (quotient, remainder) = divide(17, 5);
    println!("17 ÷ 5 = {} remainder {}", quotient, remainder);
    
    // Functions are expressions
    let result = {
        let x = 3;
        let y = 4;
        x + y // No semicolon = expression (returns value)
    };
    println!("Block result: {}", result);
    
    // Function pointers
    let operation: fn(i32, i32) -> i32 = add;
    println!("Function pointer result: {}", operation(10, 20));
    
    // Higher-order functions
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled: Vec<i32> = numbers.iter().map(|x| x * 2).collect();
    println!("Doubled: {:?}", doubled);
    
    let sum_all = numbers.iter().sum::<i32>();
    println!("Sum: {}", sum_all);
    
    let evens: Vec<&i32> = numbers.iter().filter(|&&x| x % 2 == 0).collect();
    println!("Even numbers: {:?}", evens);
}

// Function with no parameters and no return value
fn greet() {
    println!("Hello from function!");
}

// Function with parameters and return value
fn add(a: i32, b: i32) -> i32 {
    a + b // Expression (no semicolon)
}

// Function with multiple return values (tuple)
fn divide(dividend: i32, divisor: i32) -> (i32, i32) {
    (dividend / divisor, dividend % divisor)
}

// Function with reference parameters
fn calculate_length(s: &String) -> usize {
    s.len()
}

// Function that modifies parameter (mutable reference)
fn modify_string(s: &mut String) {
    s.push_str(", World!");
}

// Generic function
fn largest<T: PartialOrd>(list: &[T]) -> &T {
    let mut largest = &list[0];
    for item in list {
        if item > largest {
            largest = item;
        }
    }
    largest
}

// Function with lifetimes
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Function usage examples
fn function_examples() {
    // Reference example
    let s = String::from("Hello");
    let length = calculate_length(&s);
    println!("String '{}' has length {}", s, length);
    
    // Mutable reference example
    let mut s = String::from("Hello");
    modify_string(&mut s);
    println!("Modified string: {}", s);
    
    // Generic function example
    let numbers = vec![34, 50, 25, 100, 65];
    let result = largest(&numbers);
    println!("Largest number: {}", result);
    
    let chars = vec!['y', 'm', 'a', 'q'];
    let result = largest(&chars);
    println!("Largest char: {}", result);
    
    // Lifetime example
    let string1 = String::from("long string is long");
    let string2 = "xyz";
    let result = longest(string1.as_str(), string2);
    println!("Longest string: {}", result);
}
```

### Closures
```rust
fn main() {
    // Basic closures
    let add_one = |x: i32| x + 1;
    let multiply = |x: i32, y: i32| x * y;
    
    println!("Add one to 5: {}", add_one(5));
    println!("Multiply 3 and 4: {}", multiply(3, 4));
    
    // Closures can capture environment
    let factor = 10;
    let multiply_by_factor = |x: i32| x * factor;
    println!("5 * {}: {}", factor, multiply_by_factor(5));
    
    // Closures with type inference
    let double = |x| x * 2;
    println!("Double 7: {}", double(7));
    
    // Closures capturing by reference, mutable reference, or ownership
    let mut list = vec![1, 2, 3];
    println!("Before: {:?}", list);
    
    // Capturing by mutable reference
    let mut append_four = || list.push(4);
    append_four();
    println!("After append: {:?}", list);
    
    // Move closures (take ownership)
    let consume_list = move || {
        println!("Consumed list: {:?}", list);
    };
    consume_list();
    // list is no longer available here
    
    // Using closures with iterators
    let numbers = vec![1, 2, 3, 4, 5];
    
    let squares: Vec<i32> = numbers
        .iter()
        .map(|x| x * x)
        .collect();
    println!("Squares: {:?}", squares);
    
    let sum_of_squares: i32 = numbers
        .iter()
        .map(|x| x * x)
        .sum();
    println!("Sum of squares: {}", sum_of_squares);
    
    let evens: Vec<i32> = numbers
        .into_iter()
        .filter(|x| x % 2 == 0)
        .collect();
    println!("Even numbers: {:?}", evens);
    
    // Closure as function parameter
    let numbers = vec![1, 2, 3, 4, 5];
    let doubled = apply_operation(&numbers, |x| x * 2);
    let incremented = apply_operation(&numbers, |x| x + 1);
    
    println!("Doubled: {:?}", doubled);
    println!("Incremented: {:?}", incremented);
    
    // Closure that returns a closure
    let make_multiplier = |factor: i32| {
        move |x: i32| x * factor
    };
    
    let times_three = make_multiplier(3);
    println!("7 * 3 = {}", times_three(7));
}

fn apply_operation<F>(numbers: &[i32], op: F) -> Vec<i32>
where
    F: Fn(i32) -> i32,
{
    numbers.iter().map(|&x| op(x)).collect()
}
```

## Ownership and Borrowing

### Ownership Rules
```rust
fn main() {
    // Ownership rules:
    // 1. Each value has a single owner
    // 2. When owner goes out of scope, value is dropped
    // 3. Ownership can be transferred (moved)
    
    // Basic ownership
    let s1 = String::from("hello");  // s1 owns the string
    let s2 = s1;                     // Ownership moves to s2
    // println!("{}", s1);           // Error! s1 no longer valid
    println!("s2: {}", s2);
    
    // Clone to avoid move
    let s3 = String::from("world");
    let s4 = s3.clone();             // Deep copy
    println!("s3: {}, s4: {}", s3, s4); // Both are valid
    
    // Functions and ownership
    let s = String::from("hello");
    takes_ownership(s);              // s is moved into function
    // println!("{}", s);            // Error! s no longer valid
    
    let x = 5;
    makes_copy(x);                   // x is copied (integers implement Copy)
    println!("x: {}", x);            // x is still valid
    
    // Return values and ownership
    let s1 = gives_ownership();      // Function returns ownership
    let s2 = String::from("hello");
    let s3 = takes_and_gives_back(s2); // s2 moved in, ownership returned
    println!("s1: {}, s3: {}", s1, s3);
    
    // Scope and dropping
    {
        let temp = String::from("temporary");
        println!("Inside scope: {}", temp);
    } // temp goes out of scope and is dropped here
    
    // Multiple variables and tuples
    let s1 = String::from("hello");
    let (s2, len) = calculate_length_owned(s1);
    println!("String '{}' has length {}", s2, len);
}

fn takes_ownership(some_string: String) {
    println!("Took ownership: {}", some_string);
} // some_string goes out of scope and is dropped

fn makes_copy(some_integer: i32) {
    println!("Copied value: {}", some_integer);
} // some_integer goes out of scope, but nothing special happens

fn gives_ownership() -> String {
    let some_string = String::from("hello");
    some_string // Return value transfers ownership
}

fn takes_and_gives_back(a_string: String) -> String {
    a_string // Return value transfers ownership
}

fn calculate_length_owned(s: String) -> (String, usize) {
    let length = s.len();
    (s, length) // Return tuple with ownership
}
```

### References and Borrowing
```rust
fn main() {
    // Immutable references (borrowing)
    let s1 = String::from("hello");
    let len = calculate_length(&s1); // Borrow s1
    println!("String '{}' has length {}", s1, len); // s1 still valid
    
    // Multiple immutable references are allowed
    let s2 = String::from("world");
    let r1 = &s2;
    let r2 = &s2;
    println!("r1: {}, r2: {}", r1, r2);
    
    // Mutable references
    let mut s3 = String::from("hello");
    change(&mut s3);
    println!("Changed string: {}", s3);
    
    // Only one mutable reference at a time
    let mut s4 = String::from("hello");
    let r1 = &mut s4;
    // let r2 = &mut s4; // Error! Cannot have two mutable references
    println!("Mutable reference: {}", r1);
    
    // Cannot mix mutable and immutable references
    let mut s5 = String::from("hello");
    let r1 = &s5;      // Immutable reference
    let r2 = &s5;      // Another immutable reference
    println!("Immutable references: {}, {}", r1, r2);
    // r1 and r2 are no longer used after this point
    
    let r3 = &mut s5;  // Mutable reference (OK, immutable refs out of scope)
    println!("Mutable reference: {}", r3);
    
    // Reference scope ends when last used
    let mut s = String::from("hello");
    let r1 = &s;
    let r2 = &s;
    println!("Immutable: {}, {}", r1, r2); // r1 and r2 scope ends here
    
    let r3 = &mut s; // This is OK
    println!("Mutable: {}", r3);
    
    // Dangling references are prevented
    // let reference_to_nothing = dangle(); // Error! Would create dangling reference
    
    let valid_reference = no_dangle();
    println!("Valid reference: {}", valid_reference);
}

fn calculate_length(s: &String) -> usize { // Immutable reference parameter
    s.len()
} // s goes out of scope, but doesn't drop the data (doesn't own it)

fn change(some_string: &mut String) { // Mutable reference parameter
    some_string.push_str(", world");
}

// This would cause a compile error
// fn dangle() -> &String {
//     let s = String::from("hello");
//     &s // Return reference to s
// } // s goes out of scope and is dropped, reference would be invalid

fn no_dangle() -> String {
    let s = String::from("hello");
    s // Return ownership instead of reference
}
```

### Slices
```rust
fn main() {
    // String slices
    let s = String::from("hello world");
    
    let hello = &s[0..5];  // String slice
    let world = &s[6..11];
    let hello2 = &s[..5];  // Same as &s[0..5]
    let world2 = &s[6..];  // Same as &s[6..11]
    let entire = &s[..];   // Entire string
    
    println!("Original: {}", s);
    println!("Slices: '{}', '{}'", hello, world);
    
    // Finding first word
    let first_word = first_word(&s);
    println!("First word: '{}'", first_word);
    
    // String literals are slices
    let literal = "Hello, world!";  // Type is &str
    let first = first_word(literal); // Can pass &str directly
    println!("First word of literal: '{}'", first);
    
    // Array slices
    let numbers = [1, 2, 3, 4, 5];
    let slice = &numbers[1..4]; // &[i32]
    println!("Array: {:?}", numbers);
    println!("Slice: {:?}", slice);
    
    // Slice methods
    let mut array = [1, 2, 3, 4, 5];
    let slice = &mut array[..3];
    slice[0] = 10;
    println!("Modified array: {:?}", array);
    
    // Vector slices
    let vector = vec![1, 2, 3, 4, 5];
    let vec_slice = &vector[2..];
    println!("Vector slice: {:?}", vec_slice);
    
    // Slice pattern matching
    let numbers = [1, 2, 3, 4, 5];
    match &numbers[..] {
        [first, second, rest @ ..] => {
            println!("First: {}, Second: {}, Rest: {:?}", first, second, rest);
        }
    }
    
    match &numbers[..] {
        [] => println!("Empty slice"),
        [single] => println!("Single element: {}", single),
        [first, last] => println!("Two elements: {}, {}", first, last),
        _ => println!("Multiple elements"),
    }
}

fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();
    
    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[0..i];
        }
    }
    
    &s[..] // Return entire string if no space found
}
```

## Structs and Enums

### Struct Definition and Usage
```rust
// Regular struct
#[derive(Debug)] // Automatically implement Debug trait
struct User {
    username: String,
    email: String,
    age: u32,
    active: bool,
}

// Tuple struct
#[derive(Debug)]
struct Point(i32, i32, i32);

#[derive(Debug)]
struct Color(u8, u8, u8);

// Unit struct (no fields)
struct Unit;

// Struct with methods
#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    // Associated function (like static method)
    fn new(width: u32, height: u32) -> Rectangle {
        Rectangle { width, height }
    }
    
    // Method (takes &self)
    fn area(&self) -> u32 {
        self.width * self.height
    }
    
    // Method that can modify (takes &mut self)
    fn scale(&mut self, factor: u32) {
        self.width *= factor;
        self.height *= factor;
    }
    
    // Method that takes ownership (takes self)
    fn into_square(self) -> Rectangle {
        let size = std::cmp::min(self.width, self.height);
        Rectangle::new(size, size)
    }
    
    // Method with multiple parameters
    fn can_hold(&self, other: &Rectangle) -> bool {
        self.width > other.width && self.height > other.height
    }
}

fn main() {
    // Creating struct instances
    let user1 = User {
        email: String::from("user1@example.com"),
        username: String::from("user1"),
        age: 25,
        active: true,
    };
    
    // Accessing fields
    println!("User: {}, Email: {}", user1.username, user1.email);
    
    // Mutable struct
    let mut user2 = User {
        email: String::from("user2@example.com"),
        username: String::from("user2"),
        age: 30,
        active: true,
    };
    
    user2.age = 31; // Modify field
    println!("User2 age: {}", user2.age);
    
    // Struct update syntax
    let user3 = User {
        email: String::from("user3@example.com"),
        username: String::from("user3"),
        ..user1 // Use remaining fields from user1
    };
    
    println!("User3: {:?}", user3);
    
    // Tuple structs
    let origin = Point(0, 0, 0);
    let red = Color(255, 0, 0);
    
    println!("Origin: {:?}", origin);
    println!("Red color: ({}, {}, {})", red.0, red.1, red.2);
    
    // Unit struct
    let unit = Unit;
    
    // Using Rectangle methods
    let mut rect1 = Rectangle::new(10, 20);
    let rect2 = Rectangle { width: 5, height: 8 };
    
    println!("Rectangle: {:?}", rect1);
    println!("Area: {}", rect1.area());
    println!("Can hold rect2: {}", rect1.can_hold(&rect2));
    
    rect1.scale(2);
    println!("After scaling: {:?}", rect1);
    
    let square = rect1.into_square();
    println!("Square: {:?}", square);
    // rect1 is no longer available (moved into into_square)
}
```

### Enums and Pattern Matching
```rust
// Basic enum
#[derive(Debug)]
enum Direction {
    North,
    South,
    East,
    West,
}

// Enum with data
#[derive(Debug)]
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

// Enum with methods
impl Message {
    fn process(&self) {
        match self {
            Message::Quit => println!("Quit message received"),
            Message::Move { x, y } => println!("Move to ({}, {})", x, y),
            Message::Write(text) => println!("Write: {}", text),
            Message::ChangeColor(r, g, b) => println!("Change color to ({}, {}, {})", r, g, b),
        }
    }
}

// Generic enum (like Option<T>)
#[derive(Debug)]
enum CustomOption<T> {
    Some(T),
    None,
}

// Enum for error handling
#[derive(Debug)]
enum MathError {
    DivisionByZero,
    NegativeSquareRoot,
    InvalidInput(String),
}

fn divide(a: f64, b: f64) -> Result<f64, MathError> {
    if b == 0.0 {
        Err(MathError::DivisionByZero)
    } else {
        Ok(a / b)
    }
}

fn sqrt(x: f64) -> Result<f64, MathError> {
    if x < 0.0 {
        Err(MathError::NegativeSquareRoot)
    } else {
        Ok(x.sqrt())
    }
}

fn main() {
    // Basic enum usage
    let direction = Direction::North;
    println!("Direction: {:?}", direction);
    
    // Pattern matching with enums
    match direction {
        Direction::North => println!("Going north!"),
        Direction::South => println!("Going south!"),
        Direction::East => println!("Going east!"),
        Direction::West => println!("Going west!"),
    }
    
    // Using if let for single pattern
    let dir = Direction::East;
    if let Direction::East = dir {
        println!("We're going east!");
    }
    
    // Enum with data
    let messages = vec![
        Message::Quit,
        Message::Move { x: 10, y: 20 },
        Message::Write(String::from("Hello, world!")),
        Message::ChangeColor(255, 128, 64),
    ];
    
    for message in &messages {
        message.process();
    }
    
    // Pattern matching with data extraction
    for message in &messages {
        match message {
            Message::Move { x, y } if *x > 5 => {
                println!("Big move: ({}, {})", x, y);
            },
            Message::Write(text) if text.len() > 10 => {
                println!("Long message: {}", text);
            },
            _ => {}, // Ignore other cases
        }
    }
    
    // Using Option<T>
    let some_number = Some(5);
    let no_number: Option<i32> = None;
    
    // Pattern matching with Option
    match some_number {
        Some(x) if x > 3 => println!("Got a big number: {}", x),
        Some(x) => println!("Got a small number: {}", x),
        None => println!("No number"),
    }
    
    // Using unwrap_or for default values
    let value = some_number.unwrap_or(0);
    let default_value = no_number.unwrap_or(42);
    println!("Values: {}, {}", value, default_value);
    
    // Custom Option usage
    let custom_some: CustomOption<String> = CustomOption::Some(String::from("Hello"));
    let custom_none: CustomOption<String> = CustomOption::None;
    
    match custom_some {
        CustomOption::Some(value) => println!("Custom option has: {}", value),
        CustomOption::None => println!("Custom option is empty"),
    }
    
    // Error handling with Result and custom enums
    match divide(10.0, 2.0) {
        Ok(result) => println!("Division result: {}", result),
        Err(error) => println!("Division error: {:?}", error),
    }
    
    match divide(10.0, 0.0) {
        Ok(result) => println!("Division result: {}", result),
        Err(MathError::DivisionByZero) => println!("Cannot divide by zero!"),
        Err(other_error) => println!("Other error: {:?}", other_error),
    }
    
    // Chaining operations with Result
    let result = divide(20.0, 4.0)
        .and_then(|x| sqrt(x))
        .and_then(|x| divide(x, 2.0));
    
    match result {
        Ok(value) => println!("Final result: {}", value),
        Err(error) => println!("Error in chain: {:?}", error),
    }
}
```

## Error Handling

### Result Type and Error Propagation
```rust
use std::fs::File;
use std::io::{self, Read, ErrorKind};
use std::error::Error;
use std::fmt;

// Custom error type
#[derive(Debug)]
struct CustomError {
    message: String,
}

impl CustomError {
    fn new(message: &str) -> CustomError {
        CustomError {
            message: message.to_string(),
        }
    }
}

impl fmt::Display for CustomError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Custom error: {}", self.message)
    }
}

impl Error for CustomError {}

fn main() -> Result<(), Box<dyn Error>> {
    // Basic Result handling
    let result = divide(10.0, 2.0);
    match result {
        Ok(value) => println!("Division result: {}", value),
        Err(error) => println!("Error: {}", error),
    }
    
    // Using unwrap and expect (will panic on error)
    let safe_result = divide(8.0, 2.0).unwrap();
    println!("Safe result: {}", safe_result);
    
    let expected_result = divide(12.0, 3.0).expect("Division should work");
    println!("Expected result: {}", expected_result);
    
    // Error propagation with ?
    let file_content = read_file_content("example.txt")?;
    println!("File content length: {}", file_content.len());
    
    // Multiple error handling strategies
    handle_file_operations();
    
    // Custom error usage
    let custom_result = process_number(-5);
    match custom_result {
        Ok(value) => println!("Processed: {}", value),
        Err(error) => println!("Error: {}", error),
    }
    
    Ok(())
}

fn divide(a: f64, b: f64) -> Result<f64, String> {
    if b == 0.0 {
        Err(String::from("Division by zero"))
    } else {
        Ok(a / b)
    }
}

// Function that reads file and propagates errors
fn read_file_content(filename: &str) -> Result<String, Box<dyn Error>> {
    let mut file = File::open(filename)?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    Ok(contents)
}

// Alternative implementation without ?
fn read_file_content_verbose(filename: &str) -> Result<String, Box<dyn Error>> {
    let mut file = match File::open(filename) {
        Ok(file) => file,
        Err(error) => return Err(Box::new(error)),
    };
    
    let mut contents = String::new();
    match file.read_to_string(&mut contents) {
        Ok(_) => Ok(contents),
        Err(error) => Err(Box::new(error)),
    }
}

fn handle_file_operations() {
    // Different ways to handle file errors
    match File::open("hello.txt") {
        Ok(file) => println!("File opened successfully"),
        Err(error) => match error.kind() {
            ErrorKind::NotFound => {
                println!("File not found, creating new file...");
                match File::create("hello.txt") {
                    Ok(file) => println!("File created successfully"),
                    Err(error) => println!("Failed to create file: {}", error),
                }
            },
            other_error => {
                println!("Problem opening file: {:?}", other_error);
            }
        },
    }
    
    // Using unwrap_or_else for custom error handling
    let file = File::open("hello.txt").unwrap_or_else(|error| {
        if error.kind() == ErrorKind::NotFound {
            File::create("hello.txt").unwrap_or_else(|error| {
                panic!("Problem creating file: {:?}", error);
            })
        } else {
            panic!("Problem opening file: {:?}", error);
        }
    });
}

fn process_number(n: i32) -> Result<i32, CustomError> {
    if n < 0 {
        Err(CustomError::new("Negative numbers not allowed"))
    } else if n == 0 {
        Err(CustomError::new("Zero is not allowed"))
    } else {
        Ok(n * 2)
    }
}

// Function demonstrating different Result methods
fn result_methods_demo() {
    let good: Result<i32, &str> = Ok(42);
    let bad: Result<i32, &str> = Err("Something went wrong");
    
    // map - transform the Ok value
    let doubled = good.map(|x| x * 2);
    println!("Doubled: {:?}", doubled); // Ok(84)
    
    // map_err - transform the Err value
    let better_error = bad.map_err(|e| format!("Error: {}", e));
    println!("Better error: {:?}", better_error);
    
    // and_then - chain operations that return Result
    let chained = good.and_then(|x| {
        if x > 40 {
            Ok(x + 10)
        } else {
            Err("Too small")
        }
    });
    println!("Chained: {:?}", chained);
    
    // or_else - provide alternative on error
    let alternative = bad.or_else(|_| Ok(100));
    println!("Alternative: {:?}", alternative);
    
    // unwrap_or - provide default value on error
    let with_default = bad.unwrap_or(0);
    println!("With default: {}", with_default);
}
```

---

*Rust provides memory safety without garbage collection, making it ideal for systems programming, web backends, and performance-critical applications where control and safety are paramount.*

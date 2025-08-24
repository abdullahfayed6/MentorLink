# Java Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Methods](#methods)
- [Object-Oriented Programming](#object-oriented-programming)
- [Collections Framework](#collections-framework)
- [Exception Handling](#exception-handling)

## Introduction

Java is a popular, object-oriented programming language known for its "write once, run anywhere" philosophy. It's platform-independent and widely used for enterprise applications, Android development, and web services.

## Syntax Basics

### Hello World
```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
```

### Variables and Data Types
```java
public class Variables {
    public static void main(String[] args) {
        // Primitive data types
        int age = 25;
        double height = 5.9;
        char grade = 'A';
        boolean isStudent = true;
        
        // Reference types
        String name = "Alice";
        
        // Constants
        final double PI = 3.14159;
        
        System.out.println("Name: " + name + ", Age: " + age);
    }
}
```

### Comments
```java
// Single-line comment

/*
 * Multi-line comment
 * Can span multiple lines
 */

/**
 * JavaDoc comment
 * Used for documentation
 * @param args command line arguments
 */
public static void main(String[] args) {
    // Code here
}
```

## Data Types

### Primitive Types
```java
public class PrimitiveTypes {
    public static void main(String[] args) {
        // Integer types
        byte smallNumber = 127;        // 8-bit
        short mediumNumber = 32767;    // 16-bit
        int number = 2147483647;       // 32-bit
        long bigNumber = 9223372036854775807L; // 64-bit
        
        // Floating-point types
        float decimal = 3.14f;         // 32-bit
        double preciseDecimal = 3.14159265359; // 64-bit
        
        // Character and boolean
        char letter = 'A';
        boolean flag = true;
        
        // Type conversion
        int intValue = 100;
        double doubleValue = intValue; // Implicit casting
        int backToInt = (int) doubleValue; // Explicit casting
    }
}
```

### Strings
```java
public class StringExample {
    public static void main(String[] args) {
        // String creation
        String str1 = "Hello";
        String str2 = new String("World");
        
        // String operations
        String combined = str1 + " " + str2;
        String formatted = String.format("Hello %s, you are %d years old", "Alice", 25);
        
        // String methods
        System.out.println(str1.length());           // 5
        System.out.println(str1.toUpperCase());      // HELLO
        System.out.println(str1.charAt(1));          // e
        System.out.println(str1.substring(1, 4));    // ell
        System.out.println(str1.contains("ell"));    // true
        
        // String comparison
        String a = "hello";
        String b = "hello";
        System.out.println(a.equals(b));             // true
        System.out.println(a.equalsIgnoreCase("HELLO")); // true
    }
}
```

### Arrays
```java
public class ArrayExample {
    public static void main(String[] args) {
        // Array declaration and initialization
        int[] numbers = {1, 2, 3, 4, 5};
        String[] fruits = new String[3];
        fruits[0] = "Apple";
        fruits[1] = "Banana";
        fruits[2] = "Cherry";
        
        // Array operations
        System.out.println("Length: " + numbers.length);
        System.out.println("First element: " + numbers[0]);
        
        // Iterating arrays
        for (int i = 0; i < numbers.length; i++) {
            System.out.println(numbers[i]);
        }
        
        // Enhanced for loop
        for (String fruit : fruits) {
            System.out.println(fruit);
        }
        
        // Multidimensional arrays
        int[][] matrix = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        System.out.println(matrix[1][2]); // 6
    }
}
```

## Control Structures

### Conditional Statements
```java
public class Conditionals {
    public static void main(String[] args) {
        int score = 85;
        
        // if-else statement
        if (score >= 90) {
            System.out.println("A");
        } else if (score >= 80) {
            System.out.println("B");
        } else if (score >= 70) {
            System.out.println("C");
        } else {
            System.out.println("F");
        }
        
        // Ternary operator
        String grade = (score >= 60) ? "Pass" : "Fail";
        System.out.println(grade);
        
        // Switch statement
        int day = 3;
        switch (day) {
            case 1:
                System.out.println("Monday");
                break;
            case 2:
                System.out.println("Tuesday");
                break;
            case 3:
                System.out.println("Wednesday");
                break;
            default:
                System.out.println("Other day");
        }
    }
}
```

### Loops
```java
public class Loops {
    public static void main(String[] args) {
        // For loop
        for (int i = 0; i < 5; i++) {
            System.out.println("Count: " + i);
        }
        
        // While loop
        int count = 0;
        while (count < 5) {
            System.out.println("While: " + count);
            count++;
        }
        
        // Do-while loop
        int num = 0;
        do {
            System.out.println("Do-while: " + num);
            num++;
        } while (num < 3);
        
        // Loop control statements
        for (int i = 0; i < 10; i++) {
            if (i == 3) {
                continue; // Skip iteration
            }
            if (i == 7) {
                break; // Exit loop
            }
            System.out.println(i);
        }
    }
}
```

## Methods

### Method Definition and Calling
```java
public class MethodExample {
    
    // Method with no parameters and no return value
    public static void greet() {
        System.out.println("Hello!");
    }
    
    // Method with parameters and return value
    public static int add(int a, int b) {
        return a + b;
    }
    
    // Method overloading
    public static int add(int a, int b, int c) {
        return a + b + c;
    }
    
    public static double add(double a, double b) {
        return a + b;
    }
    
    // Varargs method
    public static int sum(int... numbers) {
        int total = 0;
        for (int num : numbers) {
            total += num;
        }
        return total;
    }
    
    public static void main(String[] args) {
        greet();
        
        int result = add(5, 3);
        System.out.println("5 + 3 = " + result);
        
        int result2 = add(1, 2, 3);
        System.out.println("1 + 2 + 3 = " + result2);
        
        double result3 = add(2.5, 3.7);
        System.out.println("2.5 + 3.7 = " + result3);
        
        int total = sum(1, 2, 3, 4, 5);
        System.out.println("Sum: " + total);
    }
}
```

## Object-Oriented Programming

### Classes and Objects
```java
public class Person {
    // Instance variables
    private String name;
    private int age;
    private String email;
    
    // Constructor
    public Person(String name, int age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }
    
    // Default constructor
    public Person() {
        this("Unknown", 0, "");
    }
    
    // Getter methods
    public String getName() {
        return name;
    }
    
    public int getAge() {
        return age;
    }
    
    public String getEmail() {
        return email;
    }
    
    // Setter methods
    public void setName(String name) {
        this.name = name;
    }
    
    public void setAge(int age) {
        if (age >= 0) {
            this.age = age;
        }
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    // Instance method
    public void introduce() {
        System.out.println("Hi, I'm " + name + " and I'm " + age + " years old.");
    }
    
    // Override toString method
    @Override
    public String toString() {
        return "Person{name='" + name + "', age=" + age + ", email='" + email + "'}";
    }
    
    public static void main(String[] args) {
        // Creating objects
        Person person1 = new Person("Alice", 25, "alice@email.com");
        Person person2 = new Person();
        
        person1.introduce();
        person2.setName("Bob");
        person2.setAge(30);
        person2.introduce();
        
        System.out.println(person1);
    }
}
```

### Inheritance
```java
// Base class
class Animal {
    protected String name;
    protected int age;
    
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public void eat() {
        System.out.println(name + " is eating.");
    }
    
    public void sleep() {
        System.out.println(name + " is sleeping.");
    }
}

// Derived class
class Dog extends Animal {
    private String breed;
    
    public Dog(String name, int age, String breed) {
        super(name, age); // Call parent constructor
        this.breed = breed;
    }
    
    public void bark() {
        System.out.println(name + " is barking!");
    }
    
    @Override
    public void eat() {
        System.out.println(name + " the dog is eating dog food.");
    }
}

class Cat extends Animal {
    public Cat(String name, int age) {
        super(name, age);
    }
    
    public void meow() {
        System.out.println(name + " is meowing!");
    }
}

public class InheritanceExample {
    public static void main(String[] args) {
        Dog dog = new Dog("Buddy", 3, "Golden Retriever");
        Cat cat = new Cat("Whiskers", 2);
        
        dog.eat();
        dog.bark();
        
        cat.eat();
        cat.meow();
    }
}
```

## Collections Framework

### ArrayList
```java
import java.util.ArrayList;
import java.util.Collections;

public class ArrayListExample {
    public static void main(String[] args) {
        // Creating ArrayList
        ArrayList<String> fruits = new ArrayList<>();
        
        // Adding elements
        fruits.add("Apple");
        fruits.add("Banana");
        fruits.add("Cherry");
        fruits.add(1, "Blueberry"); // Insert at index
        
        // Accessing elements
        System.out.println("First fruit: " + fruits.get(0));
        System.out.println("Size: " + fruits.size());
        
        // Iterating
        for (String fruit : fruits) {
            System.out.println(fruit);
        }
        
        // Modifying
        fruits.set(0, "Apricot");
        fruits.remove("Banana");
        fruits.remove(0);
        
        // Sorting
        Collections.sort(fruits);
        System.out.println("Sorted: " + fruits);
        
        // Searching
        boolean hasCherry = fruits.contains("Cherry");
        int index = fruits.indexOf("Cherry");
    }
}
```

### HashMap
```java
import java.util.HashMap;
import java.util.Map;

public class HashMapExample {
    public static void main(String[] args) {
        // Creating HashMap
        HashMap<String, Integer> ages = new HashMap<>();
        
        // Adding key-value pairs
        ages.put("Alice", 25);
        ages.put("Bob", 30);
        ages.put("Charlie", 35);
        
        // Accessing values
        int aliceAge = ages.get("Alice");
        System.out.println("Alice's age: " + aliceAge);
        
        // Checking existence
        if (ages.containsKey("Bob")) {
            System.out.println("Bob's age: " + ages.get("Bob"));
        }
        
        // Iterating
        for (Map.Entry<String, Integer> entry : ages.entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }
        
        // Removing
        ages.remove("Charlie");
        
        // Size
        System.out.println("Size: " + ages.size());
    }
}
```

## Exception Handling

### Try-Catch Blocks
```java
public class ExceptionHandling {
    public static void main(String[] args) {
        // Basic try-catch
        try {
            int result = 10 / 0; // This will throw ArithmeticException
        } catch (ArithmeticException e) {
            System.out.println("Cannot divide by zero!");
            System.out.println("Error: " + e.getMessage());
        }
        
        // Multiple catch blocks
        try {
            String str = null;
            int length = str.length(); // NullPointerException
            
            int[] array = {1, 2, 3};
            int value = array[10]; // ArrayIndexOutOfBoundsException
        } catch (NullPointerException e) {
            System.out.println("Null pointer error: " + e.getMessage());
        } catch (ArrayIndexOutOfBoundsException e) {
            System.out.println("Array index error: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("General error: " + e.getMessage());
        } finally {
            System.out.println("This always executes");
        }
        
        // Try with resources
        try (java.util.Scanner scanner = new java.util.Scanner(System.in)) {
            // Scanner will be automatically closed
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Method that throws exception
    public static void checkAge(int age) throws IllegalArgumentException {
        if (age < 0) {
            throw new IllegalArgumentException("Age cannot be negative");
        }
    }
}
```

---

*Java is a robust, object-oriented programming language perfect for building large-scale applications with its strong type system and extensive standard library.*

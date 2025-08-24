# C# Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Methods](#methods)
- [Object-Oriented Programming](#object-oriented-programming)
- [Collections](#collections)
- [Exception Handling](#exception-handling)

## Introduction

C# (C-Sharp) is a modern, object-oriented programming language developed by Microsoft. It's part of the .NET framework and is widely used for Windows applications, web development, and enterprise software.

## Syntax Basics

### Hello World
```csharp
using System;

class Program
{
    static void Main(string[] args)
    {
        Console.WriteLine("Hello, World!");
        Console.ReadLine(); // Wait for user input
    }
}
```

### Variables and Constants
```csharp
using System;

class VariableExample
{
    static void Main()
    {
        // Variable declarations
        int age = 25;
        double height = 5.9;
        char grade = 'A';
        bool isStudent = true;
        string name = "Alice";
        
        // Type inference with var
        var city = "New York";        // string
        var temperature = 72.5;       // double
        var count = 10;               // int
        
        // Constants
        const double PI = 3.14159;
        const int MAX_SIZE = 100;
        
        // Nullable types
        int? nullableInt = null;
        bool? nullableBool = true;
        
        Console.WriteLine($"Name: {name}, Age: {age}");
        Console.WriteLine($"City: {city}, Temperature: {temperature}");
        
        // Check nullable values
        if (nullableInt.HasValue)
        {
            Console.WriteLine($"Nullable int: {nullableInt.Value}");
        }
        else
        {
            Console.WriteLine("Nullable int is null");
        }
    }
}
```

### Comments
```csharp
// Single-line comment

/*
Multi-line comment
Can span multiple lines
*/

/// <summary>
/// XML documentation comment
/// Calculates the sum of two numbers
/// </summary>
/// <param name="a">First number</param>
/// <param name="b">Second number</param>
/// <returns>Sum of a and b</returns>
public static int Add(int a, int b)
{
    return a + b;
}
```

## Data Types

### Value Types
```csharp
using System;

class ValueTypes
{
    static void Main()
    {
        // Integer types
        byte smallByte = 255;           // 8-bit unsigned
        sbyte signedByte = -128;        // 8-bit signed
        short shortNumber = -32768;     // 16-bit
        ushort unsignedShort = 65535;   // 16-bit unsigned
        int number = -2147483648;       // 32-bit
        uint unsignedInt = 4294967295;  // 32-bit unsigned
        long bigNumber = -9223372036854775808L; // 64-bit
        ulong unsignedLong = 18446744073709551615UL; // 64-bit unsigned
        
        // Floating-point types
        float singlePrecision = 3.14f;           // 32-bit
        double doublePrecision = 3.14159265359;  // 64-bit
        decimal precise = 3.14159265359m;        // 128-bit (for financial calculations)
        
        // Character and boolean
        char character = 'A';
        bool flag = true;
        
        // Display type information
        Console.WriteLine($"int size: {sizeof(int)} bytes");
        Console.WriteLine($"double size: {sizeof(double)} bytes");
        Console.WriteLine($"decimal size: {sizeof(decimal)} bytes");
        
        // Type conversion
        int intValue = 100;
        double doubleValue = intValue;      // Implicit conversion
        int backToInt = (int)doubleValue;   // Explicit conversion
        
        string numberString = "123";
        int parsed = int.Parse(numberString);           // Parse string to int
        bool success = int.TryParse("456", out int result); // Safe parsing
        
        Console.WriteLine($"Parsed: {parsed}, TryParse result: {result}");
    }
}
```

### Strings
```csharp
using System;

class StringExample
{
    static void Main()
    {
        // String creation
        string str1 = "Hello";
        string str2 = "World";
        string str3 = string.Empty;
        
        // String concatenation
        string combined = str1 + " " + str2;
        string formatted = string.Format("Hello {0}, you are {1} years old", "Alice", 25);
        string interpolated = $"Hello {str1}, welcome to {str2}!";
        
        // String methods
        Console.WriteLine($"Length: {str1.Length}");
        Console.WriteLine($"Upper: {str1.ToUpper()}");
        Console.WriteLine($"Lower: {str1.ToLower()}");
        Console.WriteLine($"Substring: {combined.Substring(0, 5)}");
        Console.WriteLine($"Contains 'Hello': {combined.Contains("Hello")}");
        Console.WriteLine($"Index of 'World': {combined.IndexOf("World")}");
        
        // String comparison
        string a = "hello";
        string b = "HELLO";
        Console.WriteLine($"Equals: {a.Equals(b)}");
        Console.WriteLine($"Equals ignore case: {a.Equals(b, StringComparison.OrdinalIgnoreCase)}");
        
        // String splitting and joining
        string sentence = "apple,banana,cherry,date";
        string[] fruits = sentence.Split(',');
        string rejoined = string.Join(" | ", fruits);
        
        Console.WriteLine($"Split: [{string.Join(", ", fruits)}]");
        Console.WriteLine($"Rejoined: {rejoined}");
        
        // String builder for performance
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        for (int i = 0; i < 5; i++)
        {
            sb.Append($"Number {i} ");
        }
        Console.WriteLine($"StringBuilder result: {sb.ToString()}");
    }
}
```

### Arrays and Collections
```csharp
using System;
using System.Collections.Generic;

class ArraysAndCollections
{
    static void Main()
    {
        // Arrays
        int[] numbers = {1, 2, 3, 4, 5};
        string[] fruits = new string[3] {"apple", "banana", "cherry"};
        int[] dynamicArray = new int[5]; // Default values (0 for int)
        
        // Array operations
        Console.WriteLine($"Array length: {numbers.Length}");
        Console.WriteLine($"First element: {numbers[0]}");
        
        // Iterate array
        Console.Write("Numbers: ");
        for (int i = 0; i < numbers.Length; i++)
        {
            Console.Write($"{numbers[i]} ");
        }
        Console.WriteLine();
        
        // Enhanced for loop (foreach)
        Console.Write("Fruits: ");
        foreach (string fruit in fruits)
        {
            Console.Write($"{fruit} ");
        }
        Console.WriteLine();
        
        // Multidimensional arrays
        int[,] matrix = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        Console.WriteLine($"Matrix element [1,2]: {matrix[1, 2]}");
        
        // Jagged arrays
        int[][] jaggedArray = new int[3][];
        jaggedArray[0] = new int[4] {1, 2, 3, 4};
        jaggedArray[1] = new int[2] {5, 6};
        jaggedArray[2] = new int[3] {7, 8, 9};
        
        // List<T> - dynamic array
        List<string> cities = new List<string> {"New York", "London", "Tokyo"};
        cities.Add("Paris");
        cities.Insert(1, "Berlin");
        cities.Remove("London");
        
        Console.Write("Cities: ");
        foreach (string city in cities)
        {
            Console.Write($"{city} ");
        }
        Console.WriteLine();
    }
}
```

## Control Structures

### Conditional Statements
```csharp
using System;

class Conditionals
{
    static void Main()
    {
        int score = 85;
        
        // if-else statement
        if (score >= 90)
        {
            Console.WriteLine("Grade: A");
        }
        else if (score >= 80)
        {
            Console.WriteLine("Grade: B");
        }
        else if (score >= 70)
        {
            Console.WriteLine("Grade: C");
        }
        else
        {
            Console.WriteLine("Grade: F");
        }
        
        // Ternary operator
        string result = (score >= 60) ? "Pass" : "Fail";
        Console.WriteLine($"Result: {result}");
        
        // Switch statement
        char grade = 'B';
        switch (grade)
        {
            case 'A':
                Console.WriteLine("Excellent!");
                break;
            case 'B':
                Console.WriteLine("Good job!");
                break;
            case 'C':
                Console.WriteLine("Average");
                break;
            default:
                Console.WriteLine("Need improvement");
                break;
        }
        
        // Switch expression (C# 8.0)
        string feedback = grade switch
        {
            'A' => "Excellent!",
            'B' => "Good job!",
            'C' => "Average",
            _ => "Need improvement"
        };
        Console.WriteLine($"Feedback: {feedback}");
        
        // Pattern matching with switch
        object obj = 42;
        string description = obj switch
        {
            int i when i > 0 => $"Positive integer: {i}",
            int i when i < 0 => $"Negative integer: {i}",
            int => "Zero",
            string s => $"String: {s}",
            _ => "Unknown type"
        };
        Console.WriteLine(description);
    }
}
```

### Loops
```csharp
using System;
using System.Collections.Generic;

class Loops
{
    static void Main()
    {
        // For loop
        Console.Write("For loop: ");
        for (int i = 0; i < 5; i++)
        {
            Console.Write($"{i} ");
        }
        Console.WriteLine();
        
        // While loop
        Console.Write("While loop: ");
        int count = 0;
        while (count < 5)
        {
            Console.Write($"{count} ");
            count++;
        }
        Console.WriteLine();
        
        // Do-while loop
        Console.Write("Do-while loop: ");
        int num = 0;
        do
        {
            Console.Write($"{num} ");
            num++;
        } while (num < 3);
        Console.WriteLine();
        
        // Foreach loop
        string[] colors = {"red", "green", "blue", "yellow"};
        Console.Write("Colors: ");
        foreach (string color in colors)
        {
            Console.Write($"{color} ");
        }
        Console.WriteLine();
        
        // Loop control statements
        Console.Write("Break and continue: ");
        for (int i = 0; i < 10; i++)
        {
            if (i == 3) continue;  // Skip 3
            if (i == 7) break;     // Exit at 7
            Console.Write($"{i} ");
        }
        Console.WriteLine();
        
        // Nested loops
        Console.WriteLine("Multiplication table:");
        for (int i = 1; i <= 3; i++)
        {
            for (int j = 1; j <= 3; j++)
            {
                Console.Write($"{i * j}\t");
            }
            Console.WriteLine();
        }
    }
}
```

## Methods

### Method Definition and Overloading
```csharp
using System;

class MethodExample
{
    // Method with no parameters and no return value
    static void Greet()
    {
        Console.WriteLine("Hello!");
    }
    
    // Method with parameters and return value
    static int Add(int a, int b)
    {
        return a + b;
    }
    
    // Method with default parameters
    static void Introduce(string name, int age = 25, string city = "Unknown")
    {
        Console.WriteLine($"I'm {name}, {age} years old, from {city}");
    }
    
    // Method overloading
    static int Multiply(int a, int b)
    {
        return a * b;
    }
    
    static double Multiply(double a, double b)
    {
        return a * b;
    }
    
    static int Multiply(int a, int b, int c)
    {
        return a * b * c;
    }
    
    // Method with params keyword (variable arguments)
    static int Sum(params int[] numbers)
    {
        int total = 0;
        foreach (int num in numbers)
        {
            total += num;
        }
        return total;
    }
    
    // Method with ref parameter (pass by reference)
    static void Swap(ref int a, ref int b)
    {
        int temp = a;
        a = b;
        b = temp;
    }
    
    // Method with out parameter
    static bool TryDivide(int dividend, int divisor, out double result)
    {
        if (divisor != 0)
        {
            result = (double)dividend / divisor;
            return true;
        }
        result = 0;
        return false;
    }
    
    static void Main()
    {
        Greet();
        
        int result = Add(5, 3);
        Console.WriteLine($"5 + 3 = {result}");
        
        Introduce("Alice");
        Introduce("Bob", 30);
        Introduce("Charlie", 35, "New York");
        
        Console.WriteLine($"Multiply(5, 3) = {Multiply(5, 3)}");
        Console.WriteLine($"Multiply(2.5, 4.0) = {Multiply(2.5, 4.0)}");
        Console.WriteLine($"Multiply(2, 3, 4) = {Multiply(2, 3, 4)}");
        
        Console.WriteLine($"Sum(1, 2, 3, 4, 5) = {Sum(1, 2, 3, 4, 5)}");
        
        int x = 10, y = 20;
        Console.WriteLine($"Before swap: x={x}, y={y}");
        Swap(ref x, ref y);
        Console.WriteLine($"After swap: x={x}, y={y}");
        
        if (TryDivide(15, 3, out double divisionResult))
        {
            Console.WriteLine($"15 / 3 = {divisionResult}");
        }
        else
        {
            Console.WriteLine("Division failed");
        }
    }
}
```

### Lambda Expressions and Delegates
```csharp
using System;
using System.Collections.Generic;
using System.Linq;

class LambdaExample
{
    // Delegate declaration
    delegate int MathOperation(int a, int b);
    
    static void Main()
    {
        // Lambda expressions
        Func<int, int> square = x => x * x;
        Func<int, int, int> add = (a, b) => a + b;
        Action<string> print = message => Console.WriteLine(message);
        
        Console.WriteLine($"Square of 5: {square(5)}");
        Console.WriteLine($"5 + 3 = {add(5, 3)}");
        print("Hello from lambda!");
        
        // Using delegates
        MathOperation operation = (a, b) => a * b;
        Console.WriteLine($"Delegate result: {operation(4, 5)}");
        
        // Lambda with collections
        List<int> numbers = new List<int> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        
        var evenNumbers = numbers.Where(n => n % 2 == 0);
        var squares = numbers.Select(n => n * n);
        var sum = numbers.Where(n => n > 5).Sum();
        
        Console.Write("Even numbers: ");
        foreach (int num in evenNumbers)
        {
            Console.Write($"{num} ");
        }
        Console.WriteLine();
        
        Console.Write("Squares: ");
        foreach (int num in squares)
        {
            Console.Write($"{num} ");
        }
        Console.WriteLine();
        
        Console.WriteLine($"Sum of numbers > 5: {sum}");
        
        // Anonymous methods (older syntax)
        MathOperation subtract = delegate(int a, int b)
        {
            return a - b;
        };
        Console.WriteLine($"Anonymous method: {subtract(10, 3)}");
    }
}
```

## Object-Oriented Programming

### Classes and Objects
```csharp
using System;

public class Person
{
    // Fields (private by default)
    private string name;
    private int age;
    private string email;
    
    // Properties (C# way of getters/setters)
    public string Name 
    { 
        get { return name; }
        set { name = value; }
    }
    
    // Auto-implemented properties
    public int Age { get; set; }
    public string Email { get; set; }
    
    // Property with validation
    private double salary;
    public double Salary
    {
        get { return salary; }
        set 
        {
            if (value >= 0)
                salary = value;
            else
                throw new ArgumentException("Salary cannot be negative");
        }
    }
    
    // Constructors
    public Person()
    {
        name = "Unknown";
        Age = 0;
        Email = "";
        Console.WriteLine("Default constructor called");
    }
    
    public Person(string name, int age) : this()
    {
        this.name = name;
        this.Age = age;
        Console.WriteLine("Parameterized constructor called");
    }
    
    public Person(string name, int age, string email) : this(name, age)
    {
        this.Email = email;
    }
    
    // Methods
    public void Introduce()
    {
        Console.WriteLine($"Hi, I'm {name} and I'm {Age} years old.");
    }
    
    public virtual void Work()
    {
        Console.WriteLine($"{name} is working.");
    }
    
    // Static method
    public static void PrintSpecies()
    {
        Console.WriteLine("Homo sapiens");
    }
    
    // Override ToString
    public override string ToString()
    {
        return $"Person: {name}, Age: {Age}, Email: {Email}";
    }
}

class Program
{
    static void Main()
    {
        // Creating objects
        Person person1 = new Person("Alice", 25, "alice@email.com");
        Person person2 = new Person("Bob", 30);
        Person person3 = new Person();
        
        person1.Introduce();
        person2.Introduce();
        
        // Using properties
        person3.Name = "Charlie";
        person3.Age = 35;
        person3.Email = "charlie@email.com";
        person3.Salary = 50000;
        
        Console.WriteLine(person3);
        Console.WriteLine($"Salary: ${person3.Salary:N2}");
        
        // Static method call
        Person.PrintSpecies();
    }
}
```

### Inheritance and Polymorphism
```csharp
using System;
using System.Collections.Generic;

// Base class
public abstract class Animal
{
    protected string name;
    protected int age;
    
    public string Name 
    { 
        get { return name; }
        protected set { name = value; }
    }
    
    public int Age { get; protected set; }
    
    protected Animal(string name, int age)
    {
        this.name = name;
        this.Age = age;
    }
    
    // Virtual method - can be overridden
    public virtual void MakeSound()
    {
        Console.WriteLine($"{name} makes a generic sound");
    }
    
    public virtual void Move()
    {
        Console.WriteLine($"{name} moves around");
    }
    
    // Abstract method - must be implemented by derived classes
    public abstract string GetSpecies();
    
    public override string ToString()
    {
        return $"{GetType().Name}: {name}, Age: {Age}";
    }
}

// Derived classes
public class Dog : Animal
{
    public string Breed { get; set; }
    
    public Dog(string name, int age, string breed) : base(name, age)
    {
        Breed = breed;
    }
    
    // Override virtual method
    public override void MakeSound()
    {
        Console.WriteLine($"{name} barks: Woof! Woof!");
    }
    
    public override void Move()
    {
        Console.WriteLine($"{name} runs on four legs");
    }
    
    // Implement abstract method
    public override string GetSpecies()
    {
        return "Canine";
    }
    
    // Specific method for Dog
    public void Fetch()
    {
        Console.WriteLine($"{name} fetches the ball!");
    }
}

public class Cat : Animal
{
    public Cat(string name, int age) : base(name, age)
    {
    }
    
    public override void MakeSound()
    {
        Console.WriteLine($"{name} meows: Meow! Meow!");
    }
    
    public override void Move()
    {
        Console.WriteLine($"{name} prowls silently");
    }
    
    public override string GetSpecies()
    {
        return "Feline";
    }
    
    public void Climb()
    {
        Console.WriteLine($"{name} climbs the tree!");
    }
}

// Interface
public interface IFlyable
{
    void Fly();
    double MaxAltitude { get; }
}

public class Bird : Animal, IFlyable
{
    public double MaxAltitude { get; private set; }
    
    public Bird(string name, int age, double maxAltitude) : base(name, age)
    {
        MaxAltitude = maxAltitude;
    }
    
    public override void MakeSound()
    {
        Console.WriteLine($"{name} chirps: Tweet! Tweet!");
    }
    
    public override string GetSpecies()
    {
        return "Avian";
    }
    
    public void Fly()
    {
        Console.WriteLine($"{name} flies up to {MaxAltitude} feet!");
    }
}

class InheritanceExample
{
    static void Main()
    {
        // Polymorphism with arrays/lists
        List<Animal> animals = new List<Animal>
        {
            new Dog("Buddy", 3, "Golden Retriever"),
            new Cat("Whiskers", 2),
            new Bird("Tweety", 1, 500)
        };
        
        // Polymorphic behavior
        foreach (Animal animal in animals)
        {
            Console.WriteLine($"{animal.Name} is a {animal.GetSpecies()}");
            animal.MakeSound();
            animal.Move();
            
            // Type checking and casting
            if (animal is Dog dog)
            {
                dog.Fetch();
                Console.WriteLine($"Breed: {dog.Breed}");
            }
            else if (animal is Cat cat)
            {
                cat.Climb();
            }
            else if (animal is IFlyable flyable)
            {
                flyable.Fly();
            }
            
            Console.WriteLine("---");
        }
        
        // Pattern matching (C# 7.0+)
        foreach (Animal animal in animals)
        {
            string action = animal switch
            {
                Dog d => $"{d.Name} can fetch and has breed {d.Breed}",
                Cat c => $"{c.Name} can climb trees",
                Bird b => $"{b.Name} can fly up to {b.MaxAltitude} feet",
                _ => "Unknown animal type"
            };
            Console.WriteLine(action);
        }
    }
}
```

## Collections

### Generic Collections
```csharp
using System;
using System.Collections.Generic;
using System.Linq;

class CollectionExample
{
    static void Main()
    {
        // List<T> - dynamic array
        List<string> fruits = new List<string> {"apple", "banana", "cherry"};
        fruits.Add("date");
        fruits.Insert(1, "blueberry");
        fruits.Remove("banana");
        
        Console.Write("Fruits: ");
        foreach (string fruit in fruits)
        {
            Console.Write($"{fruit} ");
        }
        Console.WriteLine($"(Count: {fruits.Count})");
        
        // Dictionary<TKey, TValue> - key-value pairs
        Dictionary<string, int> ages = new Dictionary<string, int>
        {
            {"Alice", 25},
            {"Bob", 30},
            {"Charlie", 35}
        };
        
        ages["David"] = 40;  // Add new entry
        ages["Alice"] = 26;  // Update existing
        
        Console.WriteLine("Ages:");
        foreach (KeyValuePair<string, int> kvp in ages)
        {
            Console.WriteLine($"  {kvp.Key}: {kvp.Value}");
        }
        
        // HashSet<T> - unique elements
        HashSet<int> uniqueNumbers = new HashSet<int> {1, 2, 3, 2, 4, 3, 5};
        uniqueNumbers.Add(6);
        uniqueNumbers.Add(2); // Won't be added (duplicate)
        
        Console.Write("Unique numbers: ");
        foreach (int num in uniqueNumbers)
        {
            Console.Write($"{num} ");
        }
        Console.WriteLine();
        
        // Queue<T> - FIFO
        Queue<string> queue = new Queue<string>();
        queue.Enqueue("first");
        queue.Enqueue("second");
        queue.Enqueue("third");
        
        Console.Write("Queue: ");
        while (queue.Count > 0)
        {
            Console.Write($"{queue.Dequeue()} ");
        }
        Console.WriteLine();
        
        // Stack<T> - LIFO
        Stack<int> stack = new Stack<int>();
        stack.Push(10);
        stack.Push(20);
        stack.Push(30);
        
        Console.Write("Stack: ");
        while (stack.Count > 0)
        {
            Console.Write($"{stack.Pop()} ");
        }
        Console.WriteLine();
        
        // LINQ operations
        List<int> numbers = new List<int> {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        
        var evenNumbers = numbers.Where(n => n % 2 == 0);
        var squares = numbers.Select(n => n * n);
        var sum = numbers.Where(n => n > 5).Sum();
        var average = numbers.Average();
        var max = numbers.Max();
        var min = numbers.Min();
        
        Console.WriteLine($"Even numbers: [{string.Join(", ", evenNumbers)}]");
        Console.WriteLine($"Squares: [{string.Join(", ", squares)}]");
        Console.WriteLine($"Sum of numbers > 5: {sum}");
        Console.WriteLine($"Average: {average:F2}, Max: {max}, Min: {min}");
        
        // Group by example
        var people = new[]
        {
            new { Name = "Alice", Age = 25, City = "New York" },
            new { Name = "Bob", Age = 30, City = "London" },
            new { Name = "Charlie", Age = 25, City = "New York" },
            new { Name = "David", Age = 30, City = "Tokyo" }
        };
        
        var groupedByAge = people.GroupBy(p => p.Age);
        Console.WriteLine("Grouped by age:");
        foreach (var group in groupedByAge)
        {
            Console.WriteLine($"  Age {group.Key}: {string.Join(", ", group.Select(p => p.Name))}");
        }
    }
}
```

## Exception Handling

### Try-Catch-Finally
```csharp
using System;
using System.IO;

class ExceptionHandling
{
    static void Main()
    {
        // Basic exception handling
        try
        {
            int result = Divide(10, 0);
            Console.WriteLine($"Result: {result}");
        }
        catch (DivideByZeroException ex)
        {
            Console.WriteLine($"Error: {ex.Message}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"General error: {ex.Message}");
        }
        finally
        {
            Console.WriteLine("This always executes");
        }
        
        // Multiple exception types
        try
        {
            string input = null;
            int length = input.Length; // NullReferenceException
            
            int[] array = {1, 2, 3};
            int value = array[10]; // IndexOutOfRangeException
        }
        catch (NullReferenceException ex)
        {
            Console.WriteLine($"Null reference: {ex.Message}");
        }
        catch (IndexOutOfRangeException ex)
        {
            Console.WriteLine($"Index out of range: {ex.Message}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Other exception: {ex.GetType().Name} - {ex.Message}");
        }
        
        // Using statement for automatic resource disposal
        try
        {
            using (StreamReader reader = new StreamReader("nonexistent.txt"))
            {
                string content = reader.ReadToEnd();
                Console.WriteLine(content);
            }
            // StreamReader is automatically disposed here
        }
        catch (FileNotFoundException)
        {
            Console.WriteLine("File not found");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"File error: {ex.Message}");
        }
        
        // Throwing custom exceptions
        try
        {
            CheckAge(-5);
        }
        catch (ArgumentException ex)
        {
            Console.WriteLine($"Validation error: {ex.Message}");
        }
        
        // Exception propagation
        try
        {
            MethodThatThrows();
        }
        catch (InvalidOperationException ex)
        {
            Console.WriteLine($"Caught propagated exception: {ex.Message}");
        }
    }
    
    static int Divide(int a, int b)
    {
        if (b == 0)
        {
            throw new DivideByZeroException("Cannot divide by zero");
        }
        return a / b;
    }
    
    static void CheckAge(int age)
    {
        if (age < 0)
        {
            throw new ArgumentException("Age cannot be negative", nameof(age));
        }
    }
    
    static void MethodThatThrows()
    {
        throw new InvalidOperationException("Something went wrong in this method");
    }
}

// Custom exception class
public class CustomBusinessException : Exception
{
    public string ErrorCode { get; }
    
    public CustomBusinessException(string errorCode, string message) : base(message)
    {
        ErrorCode = errorCode;
    }
    
    public CustomBusinessException(string errorCode, string message, Exception innerException) 
        : base(message, innerException)
    {
        ErrorCode = errorCode;
    }
}
```

---

*C# is a versatile, modern programming language that combines the power of C++ with the simplicity of Visual Basic, making it ideal for Windows development and .NET applications.*

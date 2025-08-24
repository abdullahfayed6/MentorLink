# Go Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Functions](#functions)
- [Structs and Methods](#structs-and-methods)
- [Interfaces](#interfaces)
- [Concurrency](#concurrency)

## Introduction

Go (often referred to as Golang) is a statically typed, compiled programming language developed by Google. It's designed for simplicity, efficiency, and excellent support for concurrent programming.

## Syntax Basics

### Hello World
```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

### Variables and Constants
```go
package main

import "fmt"

func main() {
    // Variable declarations
    var name string = "Alice"
    var age int = 25
    var height float64 = 5.9
    var isStudent bool = true
    
    // Type inference
    var city = "New York"        // string
    var temperature = 72.5       // float64
    var count = 10               // int
    
    // Short variable declaration (only inside functions)
    score := 95
    grade := 'A'
    
    // Multiple variable declarations
    var (
        x int    = 10
        y string = "hello"
        z bool   = false
    )
    
    // Multiple assignments
    a, b := 5, 10
    firstName, lastName := "John", "Doe"
    
    // Constants
    const PI = 3.14159
    const MAX_SIZE = 100
    
    // Constant block
    const (
        MONDAY    = 1
        TUESDAY   = 2
        WEDNESDAY = 3
    )
    
    // iota for enumerated constants
    const (
        RED = iota    // 0
        GREEN         // 1
        BLUE          // 2
    )
    
    fmt.Printf("Name: %s, Age: %d\n", name, age)
    fmt.Printf("City: %s, Temperature: %.1f\n", city, temperature)
    fmt.Printf("Score: %d, Grade: %c\n", score, grade)
    fmt.Printf("Multiple: a=%d, b=%d\n", a, b)
    fmt.Printf("Constants: PI=%.5f, RED=%d\n", PI, RED)
}
```

### Comments and Formatting
```go
package main

import "fmt"

// Single-line comment

/*
Multi-line comment
Can span multiple lines
*/

// Package-level comment
// This function demonstrates Go formatting
func main() {
    // Go automatically formats code with gofmt
    x := 10
    y := 20
    
    // Formatted string output
    fmt.Printf("x = %d, y = %d\n", x, y)
    fmt.Sprintf("Formatted string: %d + %d = %d", x, y, x+y)
    
    // Various format specifiers
    fmt.Printf("Integer: %d\n", 42)
    fmt.Printf("Float: %.2f\n", 3.14159)
    fmt.Printf("String: %s\n", "hello")
    fmt.Printf("Boolean: %t\n", true)
    fmt.Printf("Binary: %b\n", 42)
    fmt.Printf("Hexadecimal: %x\n", 255)
}
```

## Data Types

### Basic Types
```go
package main

import "fmt"

func main() {
    // Integer types
    var int8Var int8 = -128        // 8-bit signed
    var uint8Var uint8 = 255       // 8-bit unsigned
    var int16Var int16 = -32768    // 16-bit signed
    var uint16Var uint16 = 65535   // 16-bit unsigned
    var int32Var int32 = -2147483648    // 32-bit signed
    var uint32Var uint32 = 4294967295  // 32-bit unsigned
    var int64Var int64 = -9223372036854775808 // 64-bit signed
    var uint64Var uint64 = 18446744073709551615 // 64-bit unsigned
    
    var intVar int = 42      // Platform-dependent size
    var uintVar uint = 100   // Platform-dependent size
    
    // Floating-point types
    var float32Var float32 = 3.14      // 32-bit
    var float64Var float64 = 3.141592  // 64-bit
    
    // Complex types
    var complex64Var complex64 = complex(3, 4)     // 3+4i
    var complex128Var complex128 = 5 + 6i          // 5+6i
    
    // Other types
    var byteVar byte = 255        // alias for uint8
    var runeVar rune = 'A'        // alias for int32 (Unicode code point)
    var boolVar bool = true
    var stringVar string = "Hello, Go!"
    
    // Zero values
    var zeroInt int          // 0
    var zeroFloat float64    // 0.0
    var zeroBool bool        // false
    var zeroString string    // ""
    
    fmt.Printf("Integers: int8=%d, uint16=%d, int=%d\n", int8Var, uint16Var, intVar)
    fmt.Printf("Floats: float32=%.2f, float64=%.6f\n", float32Var, float64Var)
    fmt.Printf("Complex: complex64=%g, complex128=%g\n", complex64Var, complex128Var)
    fmt.Printf("Others: byte=%d, rune=%c, bool=%t\n", byteVar, runeVar, boolVar)
    fmt.Printf("String: %s\n", stringVar)
    fmt.Printf("Zero values: int=%d, float=%.1f, bool=%t, string='%s'\n", 
               zeroInt, zeroFloat, zeroBool, zeroString)
}
```

### Strings and Runes
```go
package main

import (
    "fmt"
    "strings"
    "unicode/utf8"
)

func main() {
    // String creation
    str1 := "Hello"
    str2 := "World"
    str3 := ""
    
    // String concatenation
    combined := str1 + " " + str2
    formatted := fmt.Sprintf("Hello %s, you are %d years old", "Alice", 25)
    
    // Raw string literals (no escape sequences)
    rawString := `This is a raw string.
It can contain newlines
and "quotes" without escaping.`
    
    // String operations
    fmt.Printf("Length: %d\n", len(str1))
    fmt.Printf("Upper: %s\n", strings.ToUpper(str1))
    fmt.Printf("Lower: %s\n", strings.ToLower(str1))
    fmt.Printf("Contains 'Hello': %t\n", strings.Contains(combined, "Hello"))
    fmt.Printf("Index of 'World': %d\n", strings.Index(combined, "World"))
    
    // String splitting and joining
    sentence := "apple,banana,cherry,date"
    fruits := strings.Split(sentence, ",")
    rejoined := strings.Join(fruits, " | ")
    
    fmt.Printf("Split: %v\n", fruits)
    fmt.Printf("Rejoined: %s\n", rejoined)
    
    // Working with runes (Unicode)
    unicodeString := "Hello, 世界"
    fmt.Printf("String: %s\n", unicodeString)
    fmt.Printf("Byte length: %d\n", len(unicodeString))
    fmt.Printf("Rune length: %d\n", utf8.RuneCountInString(unicodeString))
    
    // Iterate over runes
    fmt.Print("Runes: ")
    for i, r := range unicodeString {
        fmt.Printf("%d:%c ", i, r)
    }
    fmt.Println()
    
    // String to byte slice and back
    bytes := []byte(str1)
    backToString := string(bytes)
    fmt.Printf("Bytes: %v, Back to string: %s\n", bytes, backToString)
}
```

### Arrays and Slices
```go
package main

import "fmt"

func main() {
    // Arrays (fixed size)
    var numbers [5]int = [5]int{1, 2, 3, 4, 5}
    fruits := [3]string{"apple", "banana", "cherry"}
    auto := [...]int{10, 20, 30, 40} // Size inferred from elements
    
    fmt.Printf("Numbers array: %v, length: %d\n", numbers, len(numbers))
    fmt.Printf("First fruit: %s\n", fruits[0])
    
    // Array iteration
    fmt.Print("Fruits: ")
    for i := 0; i < len(fruits); i++ {
        fmt.Printf("%s ", fruits[i])
    }
    fmt.Println()
    
    // Range-based iteration
    fmt.Print("Numbers with index: ")
    for index, value := range numbers {
        fmt.Printf("%d:%d ", index, value)
    }
    fmt.Println()
    
    // Slices (dynamic arrays)
    var slice []int
    slice = append(slice, 1, 2, 3)
    
    colors := []string{"red", "green", "blue"}
    colors = append(colors, "yellow", "purple")
    
    // Slice operations
    fmt.Printf("Slice: %v, length: %d, capacity: %d\n", 
               slice, len(slice), cap(slice))
    
    // Slice of slice
    subset := colors[1:4] // Elements from index 1 to 3
    fmt.Printf("Subset [1:4]: %v\n", subset)
    
    // Make function for slices
    madeSlice := make([]int, 5)      // Length 5, capacity 5
    madeSlice2 := make([]int, 3, 10) // Length 3, capacity 10
    
    fmt.Printf("Made slice: %v, len: %d, cap: %d\n", 
               madeSlice, len(madeSlice), cap(madeSlice))
    fmt.Printf("Made slice2: %v, len: %d, cap: %d\n", 
               madeSlice2, len(madeSlice2), cap(madeSlice2))
    
    // Copy slices
    source := []int{1, 2, 3, 4, 5}
    dest := make([]int, len(source))
    copy(dest, source)
    fmt.Printf("Copied slice: %v\n", dest)
    
    // Two-dimensional slices
    matrix := [][]int{
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9},
    }
    fmt.Printf("Matrix: %v\n", matrix)
    fmt.Printf("Element [1][2]: %d\n", matrix[1][2])
}
```

### Maps
```go
package main

import "fmt"

func main() {
    // Map creation
    var ages map[string]int
    ages = make(map[string]int)
    
    // Map literal
    scores := map[string]int{
        "Alice":   95,
        "Bob":     87,
        "Charlie": 92,
    }
    
    // Adding/updating elements
    ages["Alice"] = 25
    ages["Bob"] = 30
    ages["Charlie"] = 35
    
    scores["David"] = 88    // Add new
    scores["Alice"] = 96    // Update existing
    
    // Accessing elements
    fmt.Printf("Alice's age: %d\n", ages["Alice"])
    fmt.Printf("Bob's score: %d\n", scores["Bob"])
    
    // Check if key exists
    score, exists := scores["Eve"]
    if exists {
        fmt.Printf("Eve's score: %d\n", score)
    } else {
        fmt.Println("Eve not found in scores")
    }
    
    // Delete element
    delete(scores, "Bob")
    
    // Iterate over map
    fmt.Println("Ages:")
    for name, age := range ages {
        fmt.Printf("  %s: %d\n", name, age)
    }
    
    fmt.Println("Scores:")
    for name, score := range scores {
        fmt.Printf("  %s: %d\n", name, score)
    }
    
    // Map length
    fmt.Printf("Number of ages: %d\n", len(ages))
    fmt.Printf("Number of scores: %d\n", len(scores))
    
    // Map of slices
    groups := map[string][]string{
        "fruits":     {"apple", "banana", "cherry"},
        "vegetables": {"carrot", "broccoli", "spinach"},
        "colors":     {"red", "green", "blue"},
    }
    
    fmt.Println("Groups:")
    for category, items := range groups {
        fmt.Printf("  %s: %v\n", category, items)
    }
}
```

## Control Structures

### Conditional Statements
```go
package main

import "fmt"

func main() {
    score := 85
    
    // if-else statement
    if score >= 90 {
        fmt.Println("Grade: A")
    } else if score >= 80 {
        fmt.Println("Grade: B")
    } else if score >= 70 {
        fmt.Println("Grade: C")
    } else {
        fmt.Println("Grade: F")
    }
    
    // if with initialization
    if grade := getGrade(score); grade == 'A' {
        fmt.Println("Excellent!")
    } else {
        fmt.Printf("Grade is %c\n", grade)
    }
    
    // Switch statement
    day := "Tuesday"
    switch day {
    case "Monday":
        fmt.Println("Start of work week")
    case "Tuesday", "Wednesday", "Thursday":
        fmt.Println("Midweek")
    case "Friday":
        fmt.Println("TGIF!")
    case "Saturday", "Sunday":
        fmt.Println("Weekend!")
    default:
        fmt.Println("Invalid day")
    }
    
    // Switch with no condition (like if-else chain)
    temperature := 75
    switch {
    case temperature < 32:
        fmt.Println("Freezing")
    case temperature < 60:
        fmt.Println("Cool")
    case temperature < 80:
        fmt.Println("Comfortable")
    default:
        fmt.Println("Hot")
    }
    
    // Switch with initialization
    switch hour := getHour(); {
    case hour < 12:
        fmt.Println("Good morning")
    case hour < 18:
        fmt.Println("Good afternoon")
    default:
        fmt.Println("Good evening")
    }
    
    // Type switch
    var value interface{} = 42
    switch v := value.(type) {
    case int:
        fmt.Printf("Integer: %d\n", v)
    case string:
        fmt.Printf("String: %s\n", v)
    case bool:
        fmt.Printf("Boolean: %t\n", v)
    default:
        fmt.Printf("Unknown type: %T\n", v)
    }
}

func getGrade(score int) rune {
    if score >= 90 {
        return 'A'
    } else if score >= 80 {
        return 'B'
    } else if score >= 70 {
        return 'C'
    }
    return 'F'
}

func getHour() int {
    return 14 // 2 PM
}
```

### Loops
```go
package main

import "fmt"

func main() {
    // For loop (only loop in Go)
    fmt.Print("Basic for loop: ")
    for i := 0; i < 5; i++ {
        fmt.Printf("%d ", i)
    }
    fmt.Println()
    
    // While-like loop
    fmt.Print("While-like loop: ")
    count := 0
    for count < 5 {
        fmt.Printf("%d ", count)
        count++
    }
    fmt.Println()
    
    // Infinite loop (would run forever)
    // for {
    //     // This would run forever
    //     break // Exit immediately for demo
    // }
    
    // Range over slice
    numbers := []int{10, 20, 30, 40, 50}
    fmt.Print("Range over slice: ")
    for index, value := range numbers {
        fmt.Printf("%d:%d ", index, value)
    }
    fmt.Println()
    
    // Range over slice (value only)
    fmt.Print("Values only: ")
    for _, value := range numbers {
        fmt.Printf("%d ", value)
    }
    fmt.Println()
    
    // Range over string
    text := "Hello"
    fmt.Print("Range over string: ")
    for i, r := range text {
        fmt.Printf("%d:%c ", i, r)
    }
    fmt.Println()
    
    // Range over map
    scores := map[string]int{
        "Alice": 95,
        "Bob":   87,
        "Charlie": 92,
    }
    fmt.Println("Range over map:")
    for name, score := range scores {
        fmt.Printf("  %s: %d\n", name, score)
    }
    
    // Loop control statements
    fmt.Print("Break and continue: ")
    for i := 0; i < 10; i++ {
        if i == 3 {
            continue // Skip 3
        }
        if i == 7 {
            break // Exit at 7
        }
        fmt.Printf("%d ", i)
    }
    fmt.Println()
    
    // Nested loops with labels
    fmt.Println("Nested loops:")
    outer:
    for i := 1; i <= 3; i++ {
        for j := 1; j <= 3; j++ {
            if i == 2 && j == 2 {
                break outer // Break out of both loops
            }
            fmt.Printf("(%d,%d) ", i, j)
        }
        fmt.Println()
    }
}
```

## Functions

### Function Definition and Parameters
```go
package main

import "fmt"

// Function with no parameters and no return value
func greet() {
    fmt.Println("Hello!")
}

// Function with parameters and return value
func add(a, b int) int {
    return a + b
}

// Function with multiple return values
func divide(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("division by zero")
    }
    return a / b, nil
}

// Function with named return values
func calculate(a, b int) (sum, product int) {
    sum = a + b
    product = a * b
    return // naked return
}

// Variadic function (variable number of parameters)
func sum(numbers ...int) int {
    total := 0
    for _, num := range numbers {
        total += num
    }
    return total
}

// Function that takes a function as parameter
func operate(a, b int, operation func(int, int) int) int {
    return operation(a, b)
}

// Higher-order function that returns a function
func multiplier(factor int) func(int) int {
    return func(x int) int {
        return x * factor
    }
}

func main() {
    greet()
    
    result := add(5, 3)
    fmt.Printf("5 + 3 = %d\n", result)
    
    quotient, err := divide(10, 3)
    if err != nil {
        fmt.Printf("Error: %v\n", err)
    } else {
        fmt.Printf("10 / 3 = %.2f\n", quotient)
    }
    
    s, p := calculate(4, 6)
    fmt.Printf("4 and 6: sum = %d, product = %d\n", s, p)
    
    total := sum(1, 2, 3, 4, 5)
    fmt.Printf("Sum of 1,2,3,4,5 = %d\n", total)
    
    // Slice as variadic argument
    nums := []int{10, 20, 30}
    total2 := sum(nums...)
    fmt.Printf("Sum of slice = %d\n", total2)
    
    // Function as parameter
    multiply := func(x, y int) int { return x * y }
    result2 := operate(4, 5, multiply)
    fmt.Printf("Operate result = %d\n", result2)
    
    // Anonymous function
    result3 := operate(8, 2, func(x, y int) int { return x - y })
    fmt.Printf("Anonymous function result = %d\n", result3)
    
    // Function returned from function
    double := multiplier(2)
    triple := multiplier(3)
    
    fmt.Printf("Double 7 = %d\n", double(7))
    fmt.Printf("Triple 7 = %d\n", triple(7))
}
```

### Closures and Deferred Calls
```go
package main

import "fmt"

func main() {
    // Closure example
    counter := makeCounter()
    fmt.Printf("Counter: %d\n", counter()) // 1
    fmt.Printf("Counter: %d\n", counter()) // 2
    fmt.Printf("Counter: %d\n", counter()) // 3
    
    // Another counter instance
    counter2 := makeCounter()
    fmt.Printf("Counter2: %d\n", counter2()) // 1
    
    // Defer statements
    fmt.Println("Starting deferred calls demo")
    deferExample()
    fmt.Println("Finished deferred calls demo")
    
    // Defer with parameters evaluated immediately
    x := 10
    defer fmt.Printf("Deferred: x = %d\n", x)
    x = 20
    fmt.Printf("Current: x = %d\n", x)
    
    // Defer for cleanup
    cleanupExample()
}

func makeCounter() func() int {
    count := 0
    return func() int {
        count++
        return count
    }
}

func deferExample() {
    defer fmt.Println("First defer")
    defer fmt.Println("Second defer")
    defer fmt.Println("Third defer")
    
    fmt.Println("Function body")
    
    // Defers execute in LIFO order
    // Output will be:
    // Function body
    // Third defer
    // Second defer
    // First defer
}

func cleanupExample() {
    fmt.Println("Starting cleanup example")
    
    // Simulate resource allocation
    resource := "Important Resource"
    defer func() {
        fmt.Printf("Cleaning up: %s\n", resource)
    }()
    
    // Simulate some work
    fmt.Println("Doing work with resource")
    
    // Even if we return early, defer will still execute
    if true {
        fmt.Println("Early return")
        return
    }
    
    fmt.Println("This won't execute")
}
```

## Structs and Methods

### Struct Definition and Usage
```go
package main

import "fmt"

// Struct definition
type Person struct {
    Name    string
    Age     int
    Email   string
    Address Address
}

// Nested struct
type Address struct {
    Street  string
    City    string
    ZipCode string
}

// Struct with anonymous fields
type Employee struct {
    Person          // Embedded struct
    ID       int
    Salary   float64
    Department string
}

// Method with value receiver
func (p Person) Introduce() {
    fmt.Printf("Hi, I'm %s and I'm %d years old.\n", p.Name, p.Age)
}

// Method with pointer receiver (can modify the struct)
func (p *Person) Birthday() {
    p.Age++
    fmt.Printf("Happy birthday %s! Now %d years old.\n", p.Name, p.Age)
}

// Method for nested struct
func (a Address) FullAddress() string {
    return fmt.Sprintf("%s, %s %s", a.Street, a.City, a.ZipCode)
}

// Method for Employee (using embedded Person)
func (e Employee) GetInfo() string {
    return fmt.Sprintf("Employee ID: %d, Name: %s, Department: %s, Salary: $%.2f", 
                       e.ID, e.Name, e.Department, e.Salary)
}

func main() {
    // Creating structs
    person1 := Person{
        Name:  "Alice",
        Age:   25,
        Email: "alice@email.com",
        Address: Address{
            Street:  "123 Main St",
            City:    "New York",
            ZipCode: "10001",
        },
    }
    
    // Creating struct with partial initialization
    person2 := Person{
        Name: "Bob",
        Age:  30,
        // Email and Address will be zero values
    }
    
    // Creating struct with new
    person3 := new(Person)
    person3.Name = "Charlie"
    person3.Age = 35
    
    // Anonymous struct
    config := struct {
        Host string
        Port int
    }{
        Host: "localhost",
        Port: 8080,
    }
    
    // Accessing fields
    fmt.Printf("Person1: %s, %d years old\n", person1.Name, person1.Age)
    fmt.Printf("Address: %s\n", person1.Address.FullAddress())
    
    // Calling methods
    person1.Introduce()
    person1.Birthday() // This modifies person1.Age
    
    // Working with pointers
    personPtr := &person2
    personPtr.Introduce() // Go automatically dereferences
    
    // Embedded struct (Employee)
    employee := Employee{
        Person: Person{
            Name:  "David",
            Age:   28,
            Email: "david@company.com",
        },
        ID:         1001,
        Salary:     75000.00,
        Department: "Engineering",
    }
    
    // Access embedded fields directly
    fmt.Printf("Employee name: %s\n", employee.Name) // Direct access to Person.Name
    employee.Introduce() // Call Person's method
    fmt.Println(employee.GetInfo())
    
    // Struct comparison
    addr1 := Address{Street: "123 Main St", City: "NYC", ZipCode: "10001"}
    addr2 := Address{Street: "123 Main St", City: "NYC", ZipCode: "10001"}
    addr3 := Address{Street: "456 Oak Ave", City: "LA", ZipCode: "90210"}
    
    fmt.Printf("addr1 == addr2: %t\n", addr1 == addr2) // true
    fmt.Printf("addr1 == addr3: %t\n", addr1 == addr3) // false
    
    // Anonymous struct usage
    fmt.Printf("Config: %s:%d\n", config.Host, config.Port)
}
```

## Interfaces

### Interface Definition and Implementation
```go
package main

import (
    "fmt"
    "math"
)

// Interface definition
type Shape interface {
    Area() float64
    Perimeter() float64
}

// Another interface
type Drawable interface {
    Draw()
}

// Interface composition
type DrawableShape interface {
    Shape
    Drawable
}

// Struct types that implement interfaces
type Circle struct {
    Radius float64
}

type Rectangle struct {
    Width  float64
    Height float64
}

type Triangle struct {
    Base   float64
    Height float64
    SideA  float64
    SideB  float64
    SideC  float64
}

// Circle implements Shape interface
func (c Circle) Area() float64 {
    return math.Pi * c.Radius * c.Radius
}

func (c Circle) Perimeter() float64 {
    return 2 * math.Pi * c.Radius
}

func (c Circle) Draw() {
    fmt.Printf("Drawing a circle with radius %.2f\n", c.Radius)
}

// Rectangle implements Shape interface
func (r Rectangle) Area() float64 {
    return r.Width * r.Height
}

func (r Rectangle) Perimeter() float64 {
    return 2 * (r.Width + r.Height)
}

func (r Rectangle) Draw() {
    fmt.Printf("Drawing a rectangle %.2fx%.2f\n", r.Width, r.Height)
}

// Triangle implements Shape interface
func (t Triangle) Area() float64 {
    return 0.5 * t.Base * t.Height
}

func (t Triangle) Perimeter() float64 {
    return t.SideA + t.SideB + t.SideC
}

// Function that works with any Shape
func printShapeInfo(s Shape) {
    fmt.Printf("Area: %.2f, Perimeter: %.2f\n", s.Area(), s.Perimeter())
}

// Function that works with DrawableShape
func drawShape(ds DrawableShape) {
    ds.Draw()
    printShapeInfo(ds)
}

// Empty interface (interface{}) can hold any type
func printAnything(value interface{}) {
    fmt.Printf("Value: %v, Type: %T\n", value, value)
}

// Type assertion and type switches
func processValue(value interface{}) {
    // Type assertion
    if str, ok := value.(string); ok {
        fmt.Printf("String value: %s (length: %d)\n", str, len(str))
        return
    }
    
    // Type switch
    switch v := value.(type) {
    case int:
        fmt.Printf("Integer: %d\n", v)
    case float64:
        fmt.Printf("Float: %.2f\n", v)
    case bool:
        fmt.Printf("Boolean: %t\n", v)
    case Shape:
        fmt.Printf("Shape - Area: %.2f\n", v.Area())
    default:
        fmt.Printf("Unknown type: %T\n", v)
    }
}

func main() {
    // Create shapes
    circle := Circle{Radius: 5}
    rectangle := Rectangle{Width: 4, Height: 6}
    triangle := Triangle{Base: 6, Height: 8, SideA: 6, SideB: 8, SideC: 10}
    
    // Use shapes polymorphically
    shapes := []Shape{circle, rectangle, triangle}
    
    fmt.Println("Shape information:")
    for i, shape := range shapes {
        fmt.Printf("Shape %d: ", i+1)
        printShapeInfo(shape)
    }
    
    // Use DrawableShape interface
    fmt.Println("\nDrawable shapes:")
    drawShape(circle)
    drawShape(rectangle)
    
    // Empty interface examples
    fmt.Println("\nEmpty interface examples:")
    printAnything(42)
    printAnything("Hello")
    printAnything(true)
    printAnything(circle)
    
    // Type assertion and type switch examples
    fmt.Println("\nType processing:")
    values := []interface{}{42, "Hello", 3.14, true, circle}
    for _, value := range values {
        processValue(value)
    }
    
    // Interface nil check
    var shape Shape
    if shape == nil {
        fmt.Println("Shape interface is nil")
    }
    
    // Assign concrete type to interface
    shape = circle
    fmt.Printf("Assigned circle to shape interface: %.2f\n", shape.Area())
}
```

## Concurrency

### Goroutines and Channels
```go
package main

import (
    "fmt"
    "sync"
    "time"
)

func main() {
    // Simple goroutine
    go sayHello()
    
    // Goroutine with parameters
    go greetPerson("Alice")
    go greetPerson("Bob")
    
    // Anonymous goroutine
    go func() {
        fmt.Println("Anonymous goroutine")
    }()
    
    // Wait a bit for goroutines to complete
    time.Sleep(time.Second)
    
    // Channels for communication
    fmt.Println("\n--- Channel Examples ---")
    channelExamples()
    
    // Buffered channels
    fmt.Println("\n--- Buffered Channel Examples ---")
    bufferedChannelExamples()
    
    // Channel direction (send/receive only)
    fmt.Println("\n--- Channel Direction Examples ---")
    channelDirectionExamples()
    
    // Select statement
    fmt.Println("\n--- Select Statement Examples ---")
    selectExamples()
    
    // Worker pool pattern
    fmt.Println("\n--- Worker Pool Examples ---")
    workerPoolExample()
}

func sayHello() {
    fmt.Println("Hello from goroutine!")
}

func greetPerson(name string) {
    fmt.Printf("Hello, %s!\n", name)
}

func channelExamples() {
    // Create a channel
    ch := make(chan string)
    
    // Send data to channel in a goroutine
    go func() {
        ch <- "Hello from channel"
    }()
    
    // Receive data from channel
    message := <-ch
    fmt.Println(message)
    
    // Multiple goroutines with channels
    numbers := make(chan int)
    results := make(chan int)
    
    // Producer
    go func() {
        for i := 1; i <= 5; i++ {
            numbers <- i
        }
        close(numbers)
    }()
    
    // Consumer
    go func() {
        for num := range numbers {
            results <- num * num
        }
        close(results)
    }()
    
    // Collect results
    fmt.Print("Squares: ")
    for result := range results {
        fmt.Printf("%d ", result)
    }
    fmt.Println()
}

func bufferedChannelExamples() {
    // Buffered channel
    ch := make(chan int, 3)
    
    // Send without blocking (buffer has capacity)
    ch <- 1
    ch <- 2
    ch <- 3
    
    // Receive values
    fmt.Printf("Buffered channel values: %d %d %d\n", <-ch, <-ch, <-ch)
    
    // Producer-consumer with buffered channel
    jobs := make(chan int, 5)
    results := make(chan int, 5)
    
    // Send jobs
    go func() {
        for i := 1; i <= 5; i++ {
            jobs <- i
        }
        close(jobs)
    }()
    
    // Process jobs
    go func() {
        for job := range jobs {
            results <- job * 2
        }
        close(results)
    }()
    
    // Collect results
    fmt.Print("Job results: ")
    for result := range results {
        fmt.Printf("%d ", result)
    }
    fmt.Println()
}

func channelDirectionExamples() {
    ch := make(chan string, 1)
    
    // Function that only sends to channel
    sendOnly := func(ch chan<- string) {
        ch <- "Hello"
    }
    
    // Function that only receives from channel
    receiveOnly := func(ch <-chan string) string {
        return <-ch
    }
    
    sendOnly(ch)
    message := receiveOnly(ch)
    fmt.Printf("Channel direction message: %s\n", message)
}

func selectExamples() {
    ch1 := make(chan string)
    ch2 := make(chan string)
    
    go func() {
        time.Sleep(100 * time.Millisecond)
        ch1 <- "Message from ch1"
    }()
    
    go func() {
        time.Sleep(200 * time.Millisecond)
        ch2 <- "Message from ch2"
    }()
    
    // Select statement (like switch for channels)
    for i := 0; i < 2; i++ {
        select {
        case msg1 := <-ch1:
            fmt.Println("Received:", msg1)
        case msg2 := <-ch2:
            fmt.Println("Received:", msg2)
        case <-time.After(300 * time.Millisecond):
            fmt.Println("Timeout")
        }
    }
    
    // Non-blocking select with default
    select {
    case <-ch1:
        fmt.Println("Received from ch1")
    default:
        fmt.Println("No data available")
    }
}

func workerPoolExample() {
    const numWorkers = 3
    const numJobs = 9
    
    jobs := make(chan int, numJobs)
    results := make(chan int, numJobs)
    
    // Start workers
    var wg sync.WaitGroup
    for w := 1; w <= numWorkers; w++ {
        wg.Add(1)
        go worker(w, jobs, results, &wg)
    }
    
    // Send jobs
    for j := 1; j <= numJobs; j++ {
        jobs <- j
    }
    close(jobs)
    
    // Wait for all workers to finish
    wg.Wait()
    close(results)
    
    // Collect results
    fmt.Print("Worker results: ")
    for result := range results {
        fmt.Printf("%d ", result)
    }
    fmt.Println()
}

func worker(id int, jobs <-chan int, results chan<- int, wg *sync.WaitGroup) {
    defer wg.Done()
    for job := range jobs {
        fmt.Printf("Worker %d processing job %d\n", id, job)
        time.Sleep(100 * time.Millisecond) // Simulate work
        results <- job * 2
    }
}
```

---

*Go is designed for building reliable, efficient software at scale with excellent concurrency support and a focus on simplicity and readability.*

# C++ Programming Language

## Table of Contents
- [Introduction](#introduction)
- [Syntax Basics](#syntax-basics)
- [Data Types](#data-types)
- [Control Structures](#control-structures)
- [Functions](#functions)
- [Object-Oriented Programming](#object-oriented-programming)
- [Memory Management](#memory-management)
- [Standard Template Library (STL)](#standard-template-library-stl)

## Introduction

C++ is a powerful, general-purpose programming language that supports both procedural and object-oriented programming. It's widely used for system programming, game development, and performance-critical applications.

## Syntax Basics

### Hello World
```cpp
#include <iostream>
using namespace std;

int main() {
    cout << "Hello, World!" << endl;
    return 0;
}
```

### Variables and Constants
```cpp
#include <iostream>
using namespace std;

int main() {
    // Variable declarations
    int age = 25;
    double height = 5.9;
    char grade = 'A';
    bool isStudent = true;
    string name = "Alice";
    
    // Constants
    const double PI = 3.14159;
    const int MAX_SIZE = 100;
    
    // Auto keyword (C++11)
    auto number = 42;        // int
    auto decimal = 3.14;     // double
    auto text = "Hello";     // const char*
    
    cout << "Name: " << name << ", Age: " << age << endl;
    
    return 0;
}
```

### Comments
```cpp
// Single-line comment

/*
Multi-line comment
Can span multiple lines
*/

/**
 * Documentation comment
 * @param x The input value
 * @return The processed result
 */
int processValue(int x) {
    return x * 2;
}
```

## Data Types

### Fundamental Types
```cpp
#include <iostream>
#include <climits>
using namespace std;

int main() {
    // Integer types
    short shortInt = 32767;              // 16-bit
    int regularInt = 2147483647;         // 32-bit
    long longInt = 2147483647L;          // 32-bit or 64-bit
    long long longLongInt = 9223372036854775807LL; // 64-bit
    
    // Unsigned integers
    unsigned int positiveInt = 4294967295U;
    
    // Floating-point types
    float singlePrecision = 3.14f;       // 32-bit
    double doublePrecision = 3.14159265; // 64-bit
    long double extendedPrecision = 3.141592653589793L; // 80-bit or more
    
    // Character types
    char character = 'A';                // 8-bit
    wchar_t wideChar = L'Ω';            // Wide character
    
    // Boolean
    bool flag = true;
    
    // Size information
    cout << "Size of int: " << sizeof(int) << " bytes" << endl;
    cout << "Size of double: " << sizeof(double) << " bytes" << endl;
    cout << "Int range: " << INT_MIN << " to " << INT_MAX << endl;
    
    return 0;
}
```

### Arrays
```cpp
#include <iostream>
using namespace std;

int main() {
    // Static arrays
    int numbers[5] = {1, 2, 3, 4, 5};
    char vowels[] = {'a', 'e', 'i', 'o', 'u'};
    string fruits[3] = {"apple", "banana", "cherry"};
    
    // Accessing array elements
    cout << "First number: " << numbers[0] << endl;
    cout << "Array size: " << sizeof(numbers) / sizeof(numbers[0]) << endl;
    
    // Iterating through arrays
    cout << "Numbers: ";
    for (int i = 0; i < 5; i++) {
        cout << numbers[i] << " ";
    }
    cout << endl;
    
    // Range-based for loop (C++11)
    cout << "Fruits: ";
    for (const string& fruit : fruits) {
        cout << fruit << " ";
    }
    cout << endl;
    
    // Multidimensional arrays
    int matrix[3][3] = {
        {1, 2, 3},
        {4, 5, 6},
        {7, 8, 9}
    };
    
    cout << "Matrix element [1][2]: " << matrix[1][2] << endl;
    
    return 0;
}
```

### Strings
```cpp
#include <iostream>
#include <string>
using namespace std;

int main() {
    // String creation
    string str1 = "Hello";
    string str2("World");
    string str3(10, 'A');  // "AAAAAAAAAA"
    
    // String operations
    string combined = str1 + " " + str2;
    cout << "Combined: " << combined << endl;
    
    // String methods
    cout << "Length: " << str1.length() << endl;
    cout << "Character at index 1: " << str1.at(1) << endl;
    cout << "Substring: " << combined.substr(0, 5) << endl;
    
    // String modification
    str1.append(" there");
    str1.insert(5, " beautiful");
    str1.replace(0, 5, "Hi");
    
    // String comparison
    if (str1 == str2) {
        cout << "Strings are equal" << endl;
    }
    
    // String searching
    size_t pos = combined.find("World");
    if (pos != string::npos) {
        cout << "Found 'World' at position: " << pos << endl;
    }
    
    return 0;
}
```

### Pointers and References
```cpp
#include <iostream>
using namespace std;

int main() {
    int value = 42;
    
    // Pointer
    int* ptr = &value;  // ptr points to the address of value
    cout << "Value: " << value << endl;
    cout << "Address of value: " << &value << endl;
    cout << "Pointer value: " << ptr << endl;
    cout << "Value pointed by ptr: " << *ptr << endl;
    
    // Modify value through pointer
    *ptr = 100;
    cout << "New value: " << value << endl;
    
    // Reference
    int& ref = value;   // ref is an alias for value
    cout << "Reference value: " << ref << endl;
    
    ref = 200;
    cout << "Value after modifying reference: " << value << endl;
    
    // Null pointer
    int* nullPtr = nullptr;  // C++11 nullptr
    if (nullPtr == nullptr) {
        cout << "Pointer is null" << endl;
    }
    
    return 0;
}
```

## Control Structures

### Conditional Statements
```cpp
#include <iostream>
using namespace std;

int main() {
    int score = 85;
    
    // if-else statement
    if (score >= 90) {
        cout << "Grade: A" << endl;
    } else if (score >= 80) {
        cout << "Grade: B" << endl;
    } else if (score >= 70) {
        cout << "Grade: C" << endl;
    } else {
        cout << "Grade: F" << endl;
    }
    
    // Ternary operator
    string result = (score >= 60) ? "Pass" : "Fail";
    cout << "Result: " << result << endl;
    
    // Switch statement
    char grade = 'B';
    switch (grade) {
        case 'A':
            cout << "Excellent!" << endl;
            break;
        case 'B':
            cout << "Good job!" << endl;
            break;
        case 'C':
            cout << "Average" << endl;
            break;
        default:
            cout << "Need improvement" << endl;
    }
    
    return 0;
}
```

### Loops
```cpp
#include <iostream>
using namespace std;

int main() {
    // For loop
    cout << "For loop: ";
    for (int i = 0; i < 5; i++) {
        cout << i << " ";
    }
    cout << endl;
    
    // While loop
    cout << "While loop: ";
    int count = 0;
    while (count < 5) {
        cout << count << " ";
        count++;
    }
    cout << endl;
    
    // Do-while loop
    cout << "Do-while loop: ";
    int num = 0;
    do {
        cout << num << " ";
        num++;
    } while (num < 3);
    cout << endl;
    
    // Range-based for loop (C++11)
    int numbers[] = {10, 20, 30, 40, 50};
    cout << "Range-based for: ";
    for (int n : numbers) {
        cout << n << " ";
    }
    cout << endl;
    
    // Loop control statements
    cout << "Break and continue: ";
    for (int i = 0; i < 10; i++) {
        if (i == 3) continue;  // Skip 3
        if (i == 7) break;     // Exit at 7
        cout << i << " ";
    }
    cout << endl;
    
    return 0;
}
```

## Functions

### Function Declaration and Definition
```cpp
#include <iostream>
using namespace std;

// Function declaration
int add(int a, int b);
void greet(string name = "World");  // Default parameter
int multiply(int a, int b = 1);     // Default parameter

// Function definition
int add(int a, int b) {
    return a + b;
}

void greet(string name) {
    cout << "Hello, " << name << "!" << endl;
}

int multiply(int a, int b) {
    return a * b;
}

// Function overloading
int max(int a, int b) {
    return (a > b) ? a : b;
}

double max(double a, double b) {
    return (a > b) ? a : b;
}

// Pass by reference
void swap(int& a, int& b) {
    int temp = a;
    a = b;
    b = temp;
}

// Pass by pointer
void modifyValue(int* ptr) {
    *ptr = 100;
}

int main() {
    cout << "5 + 3 = " << add(5, 3) << endl;
    
    greet();
    greet("Alice");
    
    cout << "7 * 2 = " << multiply(7, 2) << endl;
    cout << "5 * default = " << multiply(5) << endl;
    
    cout << "Max of 10 and 20: " << max(10, 20) << endl;
    cout << "Max of 3.14 and 2.71: " << max(3.14, 2.71) << endl;
    
    int x = 5, y = 10;
    cout << "Before swap: x=" << x << ", y=" << y << endl;
    swap(x, y);
    cout << "After swap: x=" << x << ", y=" << y << endl;
    
    int value = 42;
    modifyValue(&value);
    cout << "Modified value: " << value << endl;
    
    return 0;
}
```

### Lambda Functions (C++11)
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    // Simple lambda
    auto greet = []() {
        cout << "Hello from lambda!" << endl;
    };
    greet();
    
    // Lambda with parameters
    auto add = [](int a, int b) -> int {
        return a + b;
    };
    cout << "5 + 3 = " << add(5, 3) << endl;
    
    // Lambda with capture
    int multiplier = 3;
    auto multiply = [multiplier](int x) {
        return x * multiplier;
    };
    cout << "4 * 3 = " << multiply(4) << endl;
    
    // Lambda with capture by reference
    int counter = 0;
    auto increment = [&counter]() {
        counter++;
    };
    increment();
    increment();
    cout << "Counter: " << counter << endl;
    
    // Using lambda with STL algorithms
    vector<int> numbers = {1, 2, 3, 4, 5};
    
    // Transform using lambda
    transform(numbers.begin(), numbers.end(), numbers.begin(),
              [](int n) { return n * n; });
    
    cout << "Squared numbers: ";
    for (int n : numbers) {
        cout << n << " ";
    }
    cout << endl;
    
    return 0;
}
```

## Object-Oriented Programming

### Classes and Objects
```cpp
#include <iostream>
#include <string>
using namespace std;

class Person {
private:
    string name;
    int age;
    string email;
    
public:
    // Constructor
    Person(string n, int a, string e) : name(n), age(a), email(e) {
        cout << "Person constructor called" << endl;
    }
    
    // Default constructor
    Person() : name("Unknown"), age(0), email("") {}
    
    // Copy constructor
    Person(const Person& other) : name(other.name), age(other.age), email(other.email) {
        cout << "Copy constructor called" << endl;
    }
    
    // Destructor
    ~Person() {
        cout << "Destructor called for " << name << endl;
    }
    
    // Getter methods
    string getName() const { return name; }
    int getAge() const { return age; }
    string getEmail() const { return email; }
    
    // Setter methods
    void setName(const string& n) { name = n; }
    void setAge(int a) { 
        if (a >= 0) age = a; 
    }
    void setEmail(const string& e) { email = e; }
    
    // Member function
    void introduce() const {
        cout << "Hi, I'm " << name << " and I'm " << age << " years old." << endl;
    }
    
    // Static member
    static int getPersonCount() {
        return personCount;
    }
    
private:
    static int personCount;
};

// Initialize static member
int Person::personCount = 0;

int main() {
    // Creating objects
    Person person1("Alice", 25, "alice@email.com");
    Person person2;
    Person person3 = person1;  // Copy constructor
    
    person1.introduce();
    
    person2.setName("Bob");
    person2.setAge(30);
    person2.introduce();
    
    return 0;
}
```

### Inheritance and Polymorphism
```cpp
#include <iostream>
#include <string>
#include <vector>
#include <memory>
using namespace std;

// Base class
class Animal {
protected:
    string name;
    int age;
    
public:
    Animal(string n, int a) : name(n), age(a) {}
    
    // Virtual function for polymorphism
    virtual void makeSound() const {
        cout << name << " makes a generic animal sound" << endl;
    }
    
    virtual void move() const {
        cout << name << " moves around" << endl;
    }
    
    // Pure virtual function (makes this an abstract class)
    virtual string getSpecies() const = 0;
    
    // Virtual destructor
    virtual ~Animal() = default;
    
    string getName() const { return name; }
    int getAge() const { return age; }
};

// Derived class
class Dog : public Animal {
private:
    string breed;
    
public:
    Dog(string n, int a, string b) : Animal(n, a), breed(b) {}
    
    // Override virtual function
    void makeSound() const override {
        cout << name << " barks: Woof! Woof!" << endl;
    }
    
    void move() const override {
        cout << name << " runs on four legs" << endl;
    }
    
    string getSpecies() const override {
        return "Canine";
    }
    
    void fetch() const {
        cout << name << " fetches the ball!" << endl;
    }
    
    string getBreed() const { return breed; }
};

class Cat : public Animal {
public:
    Cat(string n, int a) : Animal(n, a) {}
    
    void makeSound() const override {
        cout << name << " meows: Meow! Meow!" << endl;
    }
    
    void move() const override {
        cout << name << " prowls silently" << endl;
    }
    
    string getSpecies() const override {
        return "Feline";
    }
    
    void climb() const {
        cout << name << " climbs the tree!" << endl;
    }
};

int main() {
    // Polymorphism with pointers
    vector<unique_ptr<Animal>> animals;
    
    animals.push_back(make_unique<Dog>("Buddy", 3, "Golden Retriever"));
    animals.push_back(make_unique<Cat>("Whiskers", 2));
    animals.push_back(make_unique<Dog>("Max", 5, "German Shepherd"));
    
    // Polymorphic behavior
    for (const auto& animal : animals) {
        cout << animal->getName() << " is a " << animal->getSpecies() << endl;
        animal->makeSound();
        animal->move();
        cout << "---" << endl;
    }
    
    // Direct object creation
    Dog myDog("Rex", 4, "Labrador");
    myDog.makeSound();
    myDog.fetch();
    
    Cat myCat("Luna", 1);
    myCat.makeSound();
    myCat.climb();
    
    return 0;
}
```

## Memory Management

### Dynamic Memory Allocation
```cpp
#include <iostream>
#include <memory>
using namespace std;

int main() {
    // Raw pointers (C-style)
    int* ptr = new int(42);
    cout << "Value: " << *ptr << endl;
    delete ptr;  // Don't forget to delete!
    ptr = nullptr;
    
    // Dynamic arrays
    int size = 5;
    int* array = new int[size];
    for (int i = 0; i < size; i++) {
        array[i] = i * 2;
    }
    
    cout << "Array: ";
    for (int i = 0; i < size; i++) {
        cout << array[i] << " ";
    }
    cout << endl;
    
    delete[] array;  // Use delete[] for arrays
    
    // Smart pointers (C++11) - Preferred approach
    
    // unique_ptr - exclusive ownership
    unique_ptr<int> uniquePtr = make_unique<int>(100);
    cout << "Unique ptr value: " << *uniquePtr << endl;
    // No need to explicitly delete - automatic cleanup
    
    // shared_ptr - shared ownership
    shared_ptr<int> sharedPtr1 = make_shared<int>(200);
    shared_ptr<int> sharedPtr2 = sharedPtr1;  // Share ownership
    
    cout << "Shared ptr value: " << *sharedPtr1 << endl;
    cout << "Reference count: " << sharedPtr1.use_count() << endl;
    
    // weak_ptr - non-owning observer
    weak_ptr<int> weakPtr = sharedPtr1;
    if (auto locked = weakPtr.lock()) {
        cout << "Weak ptr value: " << *locked << endl;
    }
    
    return 0;
}
```

## Standard Template Library (STL)

### Containers
```cpp
#include <iostream>
#include <vector>
#include <list>
#include <map>
#include <set>
#include <queue>
#include <stack>
using namespace std;

int main() {
    // Vector - dynamic array
    vector<int> vec = {1, 2, 3, 4, 5};
    vec.push_back(6);
    vec.insert(vec.begin() + 2, 10);  // Insert 10 at position 2
    
    cout << "Vector: ";
    for (int v : vec) {
        cout << v << " ";
    }
    cout << endl;
    
    // List - doubly linked list
    list<string> lst = {"apple", "banana", "cherry"};
    lst.push_front("grape");
    lst.push_back("orange");
    
    cout << "List: ";
    for (const string& item : lst) {
        cout << item << " ";
    }
    cout << endl;
    
    // Map - key-value pairs (sorted)
    map<string, int> ages;
    ages["Alice"] = 25;
    ages["Bob"] = 30;
    ages["Charlie"] = 35;
    
    cout << "Ages: ";
    for (const auto& pair : ages) {
        cout << pair.first << ":" << pair.second << " ";
    }
    cout << endl;
    
    // Set - unique elements (sorted)
    set<int> uniqueNumbers = {5, 2, 8, 2, 1, 8};  // Duplicates removed
    uniqueNumbers.insert(3);
    
    cout << "Set: ";
    for (int num : uniqueNumbers) {
        cout << num << " ";
    }
    cout << endl;
    
    // Queue - FIFO
    queue<string> q;
    q.push("first");
    q.push("second");
    q.push("third");
    
    cout << "Queue: ";
    while (!q.empty()) {
        cout << q.front() << " ";
        q.pop();
    }
    cout << endl;
    
    // Stack - LIFO
    stack<int> stk;
    stk.push(10);
    stk.push(20);
    stk.push(30);
    
    cout << "Stack: ";
    while (!stk.empty()) {
        cout << stk.top() << " ";
        stk.pop();
    }
    cout << endl;
    
    return 0;
}
```

### Algorithms
```cpp
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
using namespace std;

int main() {
    vector<int> numbers = {3, 1, 4, 1, 5, 9, 2, 6, 5};
    
    // Sort
    sort(numbers.begin(), numbers.end());
    cout << "Sorted: ";
    for (int n : numbers) {
        cout << n << " ";
    }
    cout << endl;
    
    // Find
    auto it = find(numbers.begin(), numbers.end(), 5);
    if (it != numbers.end()) {
        cout << "Found 5 at position: " << distance(numbers.begin(), it) << endl;
    }
    
    // Count
    int count = count_if(numbers.begin(), numbers.end(), [](int n) { return n > 3; });
    cout << "Numbers greater than 3: " << count << endl;
    
    // Transform
    vector<int> squares(numbers.size());
    transform(numbers.begin(), numbers.end(), squares.begin(), 
              [](int n) { return n * n; });
    
    cout << "Squares: ";
    for (int n : squares) {
        cout << n << " ";
    }
    cout << endl;
    
    // Accumulate (sum)
    int sum = accumulate(numbers.begin(), numbers.end(), 0);
    cout << "Sum: " << sum << endl;
    
    // Min and max elements
    auto minIt = min_element(numbers.begin(), numbers.end());
    auto maxIt = max_element(numbers.begin(), numbers.end());
    
    cout << "Min: " << *minIt << ", Max: " << *maxIt << endl;
    
    return 0;
}
```

---

*C++ is a powerful and versatile programming language that provides low-level control while supporting high-level programming paradigms, making it ideal for system programming and performance-critical applications.*

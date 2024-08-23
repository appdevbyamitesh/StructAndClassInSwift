import Foundation

/*:
 # Struct vs Class in Swift: A Deep Dive

 ## Introduction
 Understanding the differences between structs and classes in Swift is crucial not only for interviews but also for building efficient and optimized iOS applications. This guide will help you gain the knowledge needed to make informed decisions when designing your code.

 This below example note was written by Amitesh Mani Tiwari.
 If you need help or have questions, feel free to contact me at:
 amiteshmanitiwari1997@gmail.com
*/

//: # Mastering Swift Structs and Classes: Playground Example

//: ## 1. Structs and the Stack

// Structs are value types, stored on the stack. Each instance of a struct has its own memory space.
struct Point {
    var x: Double
    var y: Double
}

func createPoint() {
    let pointA = Point(x: 10.0, y: 20.0)
    var pointB = pointA // Deep copy, pointB is a separate instance on the stack

    pointB.x = 15.0 // Modifying pointB does not affect pointA
    
    print("Point A: (\(pointA.x), \(pointA.y))") // (10.0, 20.0)
    print("Point B: (\(pointB.x), \(pointB.y))") // (15.0, 20.0)
}

createPoint()

// Explanation: Each time you create a struct, it is stored on the stack.
// The stack is a region of memory that grows and shrinks as functions are called and return.
// When `pointA` is copied to `pointB`, they occupy separate memory locations on the stack.


//: ## 2. Classes and the Heap

// Classes are reference types, stored on the heap. Instances of a class share the same memory space.
class Rectangle {
    var width: Double
    var height: Double
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
}

func createRectangle() {
    let rectangleA = Rectangle(width: 10.0, height: 20.0)
    let rectangleB = rectangleA // Shallow copy, both references point to the same instance on the heap

    rectangleB.width = 15.0 // Modifying rectangleB affects rectangleA
    
    print("Rectangle A: \(rectangleA.width) x \(rectangleA.height)") // 15.0 x 20.0
    print("Rectangle B: \(rectangleB.width) x \(rectangleB.height)") // 15.0 x 20.0
}

createRectangle()

// Explanation: When you create an instance of a class, it is stored on the heap.
// The heap is a region of memory that is more dynamic and used for data that needs to persist beyond the function scope.
// Both `rectangleA` and `rectangleB` share the same memory location on the heap.


//: ## 3. Deep Copying a Class Instance

// To create a deep copy of a class, you need to manually implement a copying method.
class Document {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    // Custom method to perform a deep copy
    func deepCopy() -> Document {
        return Document(title: self.title, content: self.content)
    }
}

let originalDocument = Document(title: "Original", content: "This is the original content.")
let copiedDocument = originalDocument.deepCopy() // Create a deep copy of originalDocument

copiedDocument.title = "Copy"
copiedDocument.content = "This is the copied content."

print("Original Document Title: \(originalDocument.title)") // Original
print("Copied Document Title: \(copiedDocument.title)") // Copy

// Explanation: Unlike structs, classes do not automatically perform deep copies.
// You need to create a method that duplicates the object and returns a new instance with the same data.


//: ## 4. Structs vs. Classes: Choosing the Right Tool

// Use Structs for simple, independent data.
struct PlayerScore {
    var points: Int
    
    mutating func addPoints(_ pointsToAdd: Int) {
        points += pointsToAdd
    }
}

var player1Score = PlayerScore(points: 0)
var player2Score = player1Score // Deep copy

player2Score.addPoints(10)

print("Player 1 Score: \(player1Score.points)") // 0
print("Player 2 Score: \(player2Score.points)") // 10

// Explanation: Structs are ideal when you need independent copies of data, as each instance is separate on the stack.


// Use Classes for shared, mutable state.
class GameState {
    var level: Int
    var isPaused: Bool
    
    init(level: Int, isPaused: Bool) {
        self.level = level
        self.isPaused = isPaused
    }
    
    func pauseGame() {
        isPaused = true
    }
}

let gameState = GameState(level: 1, isPaused: false)
let sharedGameState = gameState // Shallow copy (shared reference)

sharedGameState.pauseGame()

print("Is the game paused? \(gameState.isPaused)") // true

// Explanation: Classes are perfect when you need shared state. Multiple references point to the same instance on the heap.




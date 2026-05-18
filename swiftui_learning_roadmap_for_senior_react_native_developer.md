# SwiftUI Learning Roadmap for a Senior React Native Developer

> Purpose: This file is designed to be imported into Claude Code or another AI coding agent as a learning/context document.
>
> Learner profile: Senior React Native Developer transitioning to SwiftUI.
>
> Goal: Learn Swift + SwiftUI through practical mapping from React Native / TypeScript concepts, then build production-like SwiftUI apps.

---

## 1. Learner Background

The learner is already experienced with:

- React Native
- TypeScript / JavaScript
- Component-based UI
- Props and state
- Hooks
- React Navigation
- Async API calls
- State management such as Redux, Zustand, MobX, or similar
- Mobile app architecture
- Design system thinking
- Production-level app development

The learner should not be treated as a beginner programmer.

When explaining Swift or SwiftUI, always include mappings from React Native / TypeScript where useful.

---

## 2. Learning Strategy

The learner should learn in this order:

1. Swift foundation
2. SwiftUI view and layout
3. SwiftUI state and data flow
4. Navigation
5. Architecture
6. Networking
7. Persistence
8. Design system
9. Testing
10. Performance and production readiness

The learning style should be:

- Practical
- Mapping-based
- Production-oriented
- Code-heavy
- Focused on real mobile app concepts

Avoid over-explaining general programming basics.

---

## 3. Core Mental Model Mapping

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| Component | View |
| Function component | `struct SomeView: View` |
| JSX | `var body: some View` |
| Props | Stored properties, usually `let` |
| State | `@State` |
| Controlled prop | `@Binding` |
| Context | `@Environment` / `@EnvironmentObject` |
| Redux / Zustand / MobX store | `@Observable` class / Store / ViewModel |
| Hook | Property wrapper / modifier / store method |
| `useEffect` on mount | `.task` / `.onAppear` |
| `useEffect` with dependency | `.onChange(of:)` |
| React Navigation | `NavigationStack` |
| `navigation.navigate()` | `path.append(route)` / `NavigationLink` |
| Modal | `sheet` / `fullScreenCover` |
| FlatList | `List` / `ScrollView + LazyVStack` |
| StyleSheet | View modifiers / custom `ViewModifier` |
| TouchableOpacity | `Button` / `.onTapGesture` |
| Animated / Reanimated | `withAnimation`, transitions, gestures |
| AsyncStorage | `UserDefaults`, file storage, SwiftData |
| Fetch / Axios | `URLSession` |
| TypeScript interface | Swift `protocol` or `struct` |
| Generic `<T>` | Generic `<T>` |
| Jest | XCTest / Swift Testing |
| Detox | XCUITest |
| Flipper / React DevTools | Xcode debugger / Instruments |

---

# 4. Full Roadmap Overview

## Phase 1: Swift Foundation

Goal: Be able to read and write basic Swift code needed for SwiftUI.

Topics:

- `let`, `var`
- Basic types
- Functions
- Structs
- Classes
- Value type vs reference type
- Optionals
- Arrays
- Dictionaries
- Enums
- Closures
- Protocols
- Extensions
- Generics
- Error handling
- Async/await

Main project:

- Transaction Manager module

---

## Phase 2: SwiftUI Basics

Goal: Understand SwiftUI declarative UI.

Topics:

- `View`
- `body`
- `Text`
- `Image`
- `Button`
- `TextField`
- `VStack`
- `HStack`
- `ZStack`
- `Spacer`
- `ScrollView`
- `List`
- View modifiers
- Preview
- Conditional rendering
- `ForEach`

Main project:

- E-wallet home screen clone

---

## Phase 3: SwiftUI State and Data Flow

Goal: Understand how data moves in SwiftUI.

Topics:

- `@State`
- `@Binding`
- `@Observable`
- `@Environment`
- `@EnvironmentObject`
- Callback closures
- Parent-child data flow
- Form input
- Controlled component equivalent
- `.task`
- `.onAppear`
- `.onChange`

Main project:

- Add Transaction form

---

## Phase 4: Navigation and App Structure

Goal: Build multi-screen apps.

Topics:

- `NavigationStack`
- `NavigationLink`
- `navigationDestination`
- Enum-based routing
- Route parameters
- `sheet`
- `fullScreenCover`
- Feature-based folder structure
- App-level router

Main project:

- Transaction list, detail, add/edit flow

---

## Phase 5: Architecture

Goal: Build app structure suitable for production.

Topics:

- Feature folder structure
- Store / ViewModel
- Repository pattern
- Service layer
- Dependency injection
- Protocol-based abstraction
- Mock service
- Loading / error / empty state
- `@MainActor`

Main project:

- Refactor Transaction app into features, stores, services, and shared components

---

## Phase 6: Networking

Goal: Call real or mock APIs using Swift concurrency.

Topics:

- `URLSession`
- `Codable`
- async/await
- `throws`
- `do/try/catch`
- Request / response models
- Repository layer
- Cancellation
- Retry
- Debounced search

Main project:

- GitHub Repo Search or Movie Search app

---

## Phase 7: Persistence

Goal: Store local data.

Topics:

- `UserDefaults`
- File storage
- SwiftData
- `@Model`
- Local CRUD
- Offline-first thinking
- Cache layer
- Migration basics

Main project:

- Offline Transaction Manager

---

## Phase 8: Design System and Advanced UI

Goal: Build reusable UI components.

Topics:

- Custom components
- Custom `ViewModifier`
- Button styles
- Text field styles
- Design tokens
- Theme
- Dark mode
- Dynamic type
- Accessibility
- Localization
- Animation
- Gesture
- `matchedGeometryEffect`

Main project:

- Mini design system for e-wallet app

---

## Phase 9: Testing

Goal: Test business logic and app behavior.

Topics:

- XCTest
- Swift Testing
- Store tests
- Service tests
- Mock repository
- UI testing with XCUITest
- Snapshot testing if needed

Main project:

- Unit tests for Transaction Store and Transaction Service

---

## Phase 10: Production Readiness

Goal: Prepare apps for real-world usage.

Topics:

- App lifecycle
- Deep links
- Push notification basics
- Permission flow
- Instruments
- Performance debugging
- Memory management
- CI/CD
- App Store readiness

Main project:

- Complete Mini E-wallet SwiftUI app

---

# 5. Week 1: Swift Foundation

## Week 1 Goal

After week 1, the learner should understand:

- Swift syntax
- Swift data types
- `struct` vs `class`
- Optional handling
- Array and dictionary operations
- Enum modeling
- Closure syntax
- Protocols
- Extensions
- Generics
- Basic async/await
- How these map to React Native / TypeScript concepts

By the end of the week, the learner should build a pure Swift mini module:

- `TransactionCategory`
- `Transaction`
- `TransactionManager`
- Amount formatter
- Filter by category
- Sort by newest
- Calculate total amount
- Mock async service

---

## Day 1: Variables, Functions, Structs, Classes

### Concepts

- `let`
- `var`
- Type inference
- Explicit types
- Functions
- Structs
- Classes
- Value type vs reference type

### Mapping

| TypeScript / React Native | Swift |
|---|---|
| `const` | `let` |
| `let` | `var` |
| Object type / model | `struct` |
| Service / store object | `class` |
| Readonly immutable model | `struct` with `let` |
| Mutable feature state object | `class` |

### Swift Examples

```swift
let name = "Phu"
var age = 30

let balance: Double = 100000.5
let isActive: Bool = true
```

```swift
func formatAmount(amount: Double) -> String {
    return "\(amount) VND"
}
```

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String
}
```

```swift
final class TransactionStore {
    var transactions: [Transaction] = []

    func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }
}
```

### Key Notes

Use `struct` for data models.

Use `class` for stores, services, repositories, and objects that need shared mutable reference.

In SwiftUI:

```text
View = struct
Model = usually struct
Store/ViewModel/Service = usually class
```

### Day 1 Exercise

Create:

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String
}

func formatAmount(_ amount: Double) -> String {
    return "\(amount) VND"
}
```

Test:

```swift
let transaction = Transaction(
    id: "1",
    amount: 50000,
    note: "Coffee"
)

print(transaction.note)
print(formatAmount(transaction.amount))
```

---

## Day 2: Optionals

### Concepts

- `nil`
- Optional type `T?`
- `if let`
- `guard let`
- Nil coalescing `??`
- Optional chaining

### Mapping

| TypeScript | Swift |
|---|---|
| `undefined` / `null` | `nil` |
| `string | undefined` | `String?` |
| `value ?? fallback` | `value ?? fallback` |
| `user?.profile?.avatar` | `user?.profile?.avatar` |

### Swift Examples

```swift
var note: String? = "Coffee"
var emptyNote: String? = nil
```

```swift
if let note {
    print(note)
} else {
    print("No note")
}
```

```swift
func printNote(_ note: String?) {
    guard let note else {
        print("No note")
        return
    }

    print(note)
}
```

```swift
let displayNote = note ?? "No note"
```

### Key Notes

Swift forces null-safety at compile time.

You cannot use an Optional as a normal value until it is unwrapped.

### Day 2 Exercise

Update:

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String?
}
```

Create:

```swift
func displayNote(_ note: String?) -> String {
    return note ?? "No note"
}
```

Test with both non-nil and nil notes.

---

## Day 3: Arrays, Dictionaries, Enums

### Concepts

- Array
- Dictionary
- `map`
- `filter`
- `sorted`
- `reduce`
- Enum
- Enum raw value
- Enum computed property
- `Equatable`

### Mapping

| TypeScript | Swift |
|---|---|
| `number[]` | `[Int]` / `[Double]` |
| `Record<string, T>` | `[String: T]` |
| `array.map(item => item.x)` | `array.map { $0.x }` |
| `array.filter(...)` | `array.filter { ... }` |
| Union string literal | `enum` |
| `type Category = "food" \| "shopping"` | `enum Category { case food, shopping }` |

### Swift Examples

```swift
let numbers: [Int] = [1, 2, 3]
```

```swift
var transactions: [Transaction] = []
```

```swift
let amounts = transactions.map { $0.amount }
let largeTransactions = transactions.filter { $0.amount > 100000 }
let sorted = transactions.sorted { $0.amount > $1.amount }
```

```swift
enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transfer = "Transfer"
    case bill = "Bill"
}
```

```swift
extension TransactionCategory {
    var title: String {
        rawValue
    }
}
```

### Day 3 Exercise

Create:

```swift
enum TransactionCategory: Equatable {
    case food
    case shopping
    case transfer
    case bill
}
```

Update model:

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String?
    let category: TransactionCategory
}
```

Create:

```swift
func filterTransactions(
    _ transactions: [Transaction],
    by category: TransactionCategory
) -> [Transaction] {
    return transactions.filter { $0.category == category }
}
```

---

## Day 4: Closures

### Concepts

- Closure syntax
- Callback functions
- Trailing closure syntax
- Closure with parameters
- Closure return values
- Shorthand arguments `$0`, `$1`

### Mapping

| TypeScript / React Native | Swift |
|---|---|
| Callback function | Closure |
| `() => void` | `() -> Void` |
| `(value: number) => void` | `(Double) -> Void` |
| `array.filter(tx => tx.amount > 0)` | `array.filter { $0.amount > 0 }` |
| `onPress={() => onSelect(item)}` | `Button { onSelect(item) } label: { ... }` |

### Swift Examples

```swift
func onPress(callback: () -> Void) {
    callback()
}

onPress {
    print("Pressed")
}
```

```swift
func handleAmount(callback: (Double) -> Void) {
    callback(100000)
}

handleAmount { amount in
    print(amount)
}
```

```swift
let result = transactions.filter { transaction in
    transaction.amount > 100000
}
```

```swift
let result = transactions.filter { $0.amount > 100000 }
```

### Day 4 Exercise

Create:

```swift
func performTransaction(
    amount: Double,
    onSuccess: (String) -> Void,
    onFailure: (String) -> Void
) {
    if amount > 0 {
        onSuccess("Success: \(amount)")
    } else {
        onFailure("Invalid amount")
    }
}
```

Call:

```swift
performTransaction(
    amount: 100000,
    onSuccess: { message in
        print(message)
    },
    onFailure: { error in
        print(error)
    }
)
```

---

## Day 5: Protocols, Extensions, Generics

### Concepts

- Protocol
- Protocol conformance
- Extension
- Generic type
- Dependency abstraction

### Mapping

| TypeScript | Swift |
|---|---|
| Interface | Protocol |
| Implements interface | Conforms to protocol |
| Utility/helper extension | `extension` |
| Generic `<T>` | Generic `<T>` |
| Mock service | Class conforming to protocol |

### Swift Examples

```swift
protocol TransactionRepository {
    func getTransactions() -> [Transaction]
}
```

```swift
final class MockTransactionRepository: TransactionRepository {
    func getTransactions() -> [Transaction] {
        return []
    }
}
```

```swift
extension Double {
    func asVND() -> String {
        return "\(self) VND"
    }
}
```

```swift
struct ApiResponse<T> {
    let data: T
}
```

### Day 5 Exercise

Create:

```swift
protocol TransactionRepository {
    func getTransactions() -> [Transaction]
}
```

Create:

```swift
final class MockTransactionRepository: TransactionRepository {
    func getTransactions() -> [Transaction] {
        return [
            Transaction(
                id: "1",
                amount: 50000,
                note: "Coffee",
                category: .food
            )
        ]
    }
}
```

---

## Day 6: Async/Await and Error Handling

### Concepts

- `async`
- `await`
- `throws`
- `do/try/catch`
- `Task`
- Error enum
- Async service

### Mapping

| TypeScript | Swift |
|---|---|
| `async function` | `func ... async` |
| `await` | `await` |
| Promise rejection | thrown error |
| `throw new Error()` | `throw SomeError.case` |
| `try/catch` | `do/try/catch` |
| fire async block | `Task { }` |

### Swift Examples

```swift
enum TransactionError: Error {
    case invalidAmount
}
```

```swift
func validateAmount(_ amount: Double) throws {
    if amount <= 0 {
        throw TransactionError.invalidAmount
    }
}
```

```swift
do {
    try validateAmount(0)
} catch {
    print(error)
}
```

```swift
protocol TransactionService {
    func fetchTransactions() async throws -> [Transaction]
}
```

```swift
final class MockTransactionService: TransactionService {
    func fetchTransactions() async throws -> [Transaction] {
        return [
            Transaction(
                id: "1",
                amount: 50000,
                note: "Coffee",
                category: .food
            )
        ]
    }
}
```

```swift
let service = MockTransactionService()

Task {
    do {
        let transactions = try await service.fetchTransactions()
        print(transactions)
    } catch {
        print(error)
    }
}
```

---

## Day 7: Mini Project — Transaction Manager

### Goal

Build a pure Swift module that can later be connected to SwiftUI.

### Requirements

Create:

- `TransactionCategory`
- `Transaction`
- `TransactionManager`
- `Double.asVND()`
- `Transaction.displayNote`
- `Transaction.displayAmount`
- Add transaction
- Delete transaction
- Update transaction
- Filter by category
- Sort by newest
- Calculate total amount

### Reference Implementation

```swift
import Foundation

enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transfer = "Transfer"
    case bill = "Bill"
}

struct Transaction: Identifiable, Equatable {
    let id: String
    var amount: Double
    var note: String?
    var category: TransactionCategory
    var createdAt: Date
}

final class TransactionManager {
    private(set) var transactions: [Transaction] = []

    func add(_ transaction: Transaction) {
        transactions.append(transaction)
    }

    func delete(id: String) {
        transactions.removeAll { $0.id == id }
    }

    func update(_ transaction: Transaction) {
        guard let index = transactions.firstIndex(where: { $0.id == transaction.id }) else {
            return
        }

        transactions[index] = transaction
    }

    func filter(by category: TransactionCategory) -> [Transaction] {
        transactions.filter { $0.category == category }
    }

    func sortedByNewest() -> [Transaction] {
        transactions.sorted { $0.createdAt > $1.createdAt }
    }

    func totalAmount() -> Double {
        transactions.reduce(0) { partialResult, transaction in
            partialResult + transaction.amount
        }
    }
}

extension Double {
    func asVND() -> String {
        "\(self) VND"
    }
}

extension Transaction {
    var displayNote: String {
        note ?? "No note"
    }

    var displayAmount: String {
        amount.asVND()
    }
}
```

### Test Code

```swift
let manager = TransactionManager()

let tx1 = Transaction(
    id: "1",
    amount: 50000,
    note: "Coffee",
    category: .food,
    createdAt: Date()
)

let tx2 = Transaction(
    id: "2",
    amount: 120000,
    note: "Lunch",
    category: .food,
    createdAt: Date()
)

manager.add(tx1)
manager.add(tx2)

print(manager.transactions)
print(manager.filter(by: .food))
print(manager.totalAmount().asVND())
```

---

# 6. Week 1 Checklist

The learner should be able to answer:

1. What is the difference between `let` and `var`?
2. What is the difference between `struct` and `class`?
3. When should a Swift data model be a `struct`?
4. When should a Swift service/store be a `class`?
5. What is an Optional?
6. What is the difference between `if let` and `guard let`?
7. What is a closure?
8. How does a Swift closure map to a React Native callback?
9. What is a protocol?
10. How does a protocol map to a TypeScript interface?
11. What is an extension?
12. What does `async throws` mean?
13. How do `map`, `filter`, `sorted`, and `reduce` work in Swift?
14. Why is `Dictionary` access optional in Swift?
15. Why is enum modeling useful for SwiftUI?

---

# 7. Guidance for the AI Agent

When helping the learner:

- Assume the learner understands advanced React Native concepts.
- Explain Swift through React Native / TypeScript mappings.
- Do not spend too much time explaining universal programming concepts.
- Focus on syntax differences and mental model differences.
- Prefer practical examples.
- Prefer mobile app examples.
- Use e-wallet, transaction, payment, profile, and list/form flows as examples.
- Point out when the learner is translating React Native patterns too directly into SwiftUI.
- Encourage Swift conventions instead of JavaScript-style code.
- Keep code production-oriented.

---

# 8. Common Translation Mistakes to Watch For

## Mistake 1: Treating SwiftUI `body` like a place for side effects

Wrong:

```swift
var body: some View {
    fetchData()
    return Text("Hello")
}
```

Better:

```swift
var body: some View {
    Text("Hello")
        .task {
            await store.load()
        }
}
```

## Mistake 2: Trying to force Flexbox into SwiftUI

React Native uses Flexbox heavily.

SwiftUI prefers:

- `VStack`
- `HStack`
- `ZStack`
- `Spacer`
- `frame`
- `overlay`
- `background`
- alignment

## Mistake 3: Overusing global stores

In SwiftUI:

- Use `@State` for local view state.
- Use `@Binding` for parent-child controlled state.
- Use `@Observable` store for feature state.
- Use `@Environment` for dependencies or global app context.

## Mistake 4: Mapping hooks one-to-one

There is no perfect one-to-one mapping for all hooks.

| React Hook | SwiftUI Equivalent |
|---|---|
| `useState` | `@State` |
| `useEffect(() => {}, [])` | `.task` / `.onAppear` |
| `useEffect(..., [value])` | `.onChange(of:)` |
| `useMemo` | Computed property / cached state if needed |
| `useCallback` | Usually unnecessary |
| Custom hook | Store / service / helper object |

## Mistake 5: Customizing `List` too deeply

For highly custom feeds, prefer:

```swift
ScrollView {
    LazyVStack {
        ForEach(items) { item in
            TransactionRow(item: item)
        }
    }
}
```

instead of forcing `List` to behave like a fully custom RN `FlatList`.

---

# 9. Suggested Final Project

## Mini E-wallet SwiftUI App

### Screens

- Home
- Transaction List
- Transaction Detail
- Add Transaction
- Edit Transaction
- Filter Sheet
- Profile / Settings

### Features

- Balance card
- Transaction list
- Category filter
- Add/edit transaction form
- Local persistence
- Mock API service
- Loading state
- Empty state
- Error state
- Dark mode
- Accessibility labels
- Unit tests
- Basic UI tests

### Concepts Covered

| Feature | SwiftUI Concept |
|---|---|
| Balance card | Custom View |
| Transaction row | Reusable component |
| Transaction list | `ScrollView + LazyVStack` |
| Add form | `@State`, `@Binding`, validation |
| Filter modal | `sheet` |
| Detail screen | `NavigationStack` |
| API mock | async/await service |
| Feature state | `@Observable` store |
| Theme | Design system |
| Local data | SwiftData / UserDefaults / repository |
| Tests | XCTest / Swift Testing |

---

# 10. Next Step After Week 1

After the learner completes Week 1, continue with:

# Week 2: SwiftUI Views and Layout

Topics:

- `struct SomeView: View`
- `var body: some View`
- `Text`
- `Image`
- `Button`
- `TextField`
- `VStack`
- `HStack`
- `ZStack`
- `Spacer`
- `.padding`
- `.background`
- `.foregroundStyle`
- `.font`
- `.frame`
- `ScrollView`
- `LazyVStack`
- `List`
- `ForEach`
- `Preview`

Main exercise:

- Build e-wallet home screen with:
  - Header
  - Balance card
  - Quick action buttons
  - Promotion banner
  - Transaction list
  - Empty state

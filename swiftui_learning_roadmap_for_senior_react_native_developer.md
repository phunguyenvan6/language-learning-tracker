# Full SwiftUI Learning Roadmap for Senior React Native Developer

> File này dùng để import vào Claude Code / Agent AI khác làm context học SwiftUI.
>
> Người học: Senior React Native Developer muốn chuyển sang SwiftUI.
>
> Cách học: mapping React Native / TypeScript sang Swift / SwiftUI, thực chiến, production-oriented.

---

## 0. Learner Context

Người học đã có kinh nghiệm với:

- React Native
- TypeScript / JavaScript
- Component-based UI
- Props / State
- Hooks
- React Navigation
- Async API calls
- Redux / Zustand / MobX hoặc pattern tương tự
- Mobile app architecture
- Design system
- Production-level mobile development

Không cần giải thích programming từ đầu. Khi dạy Swift/SwiftUI, hãy luôn mapping sang React Native/TypeScript nếu phù hợp.

---

## 1. Core Goal

Mục tiêu không chỉ là học syntax SwiftUI.

Mục tiêu là có thể build app SwiftUI production bằng cách chuyển mental model từ React Native sang native Apple platform.

```text
React Native mental model
        ↓
Swift language foundation
        ↓
SwiftUI declarative UI
        ↓
SwiftUI data flow
        ↓
Navigation and architecture
        ↓
Networking and persistence
        ↓
Design system and production readiness
```

---

## 2. Global Mapping: React Native ↔ SwiftUI

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| Component | View |
| Function component | `struct SomeView: View` |
| JSX | `var body: some View` |
| Props | Stored properties, usually `let` |
| Optional prop | Optional property, e.g. `String?` |
| Children | `@ViewBuilder content` |
| State | `@State` |
| Controlled prop | `@Binding` |
| Context | `@Environment` / `@EnvironmentObject` |
| Redux / Zustand / MobX store | `@Observable` class / Store / ViewModel |
| Hook | Property wrapper / modifier / store method |
| `useEffect` on mount | `.task` / `.onAppear` |
| `useEffect` with dependency | `.onChange(of:)` |
| React Navigation | `NavigationStack` |
| `navigation.navigate()` | `path.append(route)` / `NavigationLink` |
| Route params | Enum associated value / model property |
| Modal | `sheet` / `fullScreenCover` |
| FlatList | `List` / `ScrollView + LazyVStack` |
| ScrollView | `ScrollView` |
| StyleSheet | View modifiers / custom `ViewModifier` |
| TouchableOpacity | `Button` / `.onTapGesture` |
| Animated / Reanimated | `withAnimation`, transitions, gestures |
| AsyncStorage | `UserDefaults`, file storage, SwiftData |
| Fetch / Axios | `URLSession` |
| TypeScript interface | Swift `protocol` or `struct` |
| TypeScript type model | Swift `struct` |
| Generic `<T>` | Generic `<T>` |
| Jest | XCTest / Swift Testing |
| Detox | XCUITest |
| Flipper / React DevTools | Xcode debugger / Instruments |

---

## 3. Recommended Timeline

### Fast Track: 6 weeks

| Week | Focus |
|---|---|
| Week 1 | Swift foundation |
| Week 2 | SwiftUI view, layout, and styling |
| Week 3 | State, binding, forms, and data flow |
| Week 4 | Navigation and architecture |
| Week 5 | Networking, async/await, persistence |
| Week 6 | Design system, testing, production readiness |

### Deeper Track: 8 weeks

| Week | Focus |
|---|---|
| Week 1 | Swift foundation |
| Week 2 | SwiftUI basics |
| Week 3 | Layout and component composition |
| Week 4 | State management and Observation |
| Week 5 | Navigation and architecture |
| Week 6 | Networking and persistence |
| Week 7 | Design system, animation, accessibility |
| Week 8 | Testing, performance, production readiness |

---

# 4. Phase Overview

## Phase 1 — Swift Foundation

Goal: đọc và viết được Swift code cơ bản để chuẩn bị học SwiftUI.

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

## Phase 2 — SwiftUI Basics

Goal: hiểu declarative UI trong SwiftUI.

Topics:

- `View`
- `body`
- `Text`
- `Image`
- `Button`
- `TextField`
- `Toggle`
- `Picker`
- `VStack`
- `HStack`
- `ZStack`
- `Spacer`
- `Group`
- `ScrollView`
- `List`
- `ForEach`
- Preview
- View modifiers
- Conditional rendering

Main project:

- E-wallet home screen clone

---

## Phase 3 — SwiftUI State and Data Flow

Goal: hiểu data flow trong SwiftUI.

Topics:

- `@State`
- `@Binding`
- `@Observable`
- `@Environment`
- `@EnvironmentObject`
- Parent-child data flow
- Callback closure
- Form state
- Validation state
- `.task`
- `.onAppear`
- `.onChange`

Main project:

- Add Transaction form

---

## Phase 4 — Navigation and App Structure

Goal: build app nhiều màn hình.

Topics:

- `NavigationStack`
- `NavigationLink`
- `navigationDestination`
- Enum-based routing
- Route parameters
- `sheet`
- `fullScreenCover`
- App-level router
- Feature-based folder structure

Main project:

- Transaction list, detail, add/edit flow

---

## Phase 5 — Architecture

Goal: cấu trúc app theo hướng production.

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

- Refactor Transaction app into features, stores, services, shared components

---

## Phase 6 — Networking

Goal: gọi API thật hoặc mock bằng Swift concurrency.

Topics:

- `URLSession`
- `Codable`
- `async/await`
- `throws`
- `do/try/catch`
- Request / response models
- Repository layer
- Cancellation
- Retry
- Debounced search

Main project:

- GitHub Repo Search app hoặc Movie Search app

---

## Phase 7 — Persistence

Goal: lưu data local.

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

## Phase 8 — Design System and Advanced UI

Goal: build reusable UI components.

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

## Phase 9 — Testing

Goal: test business logic và app behavior.

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

## Phase 10 — Production Readiness

Goal: chuẩn bị app cho production.

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

# 5. Week 1 — Swift Foundation

## Goal

Sau tuần 1, người học cần hiểu:

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
- Mapping với React Native / TypeScript

Cuối tuần, build được pure Swift mini module:

- `TransactionCategory`
- `Transaction`
- `TransactionManager`
- Amount formatter
- Filter by category
- Sort by newest
- Calculate total amount
- Mock async service

---

## Day 1 — Variables, Functions, Structs, Classes

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

### Exercise

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

## Day 2 — Optionals

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

### Exercise

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

---

## Day 3 — Arrays, Dictionaries, Enums

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
| `type Category = "food" | "shopping"` | `enum Category { case food, shopping }` |

### Swift Examples

```swift
let numbers: [Int] = [1, 2, 3]
var transactions: [Transaction] = []

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

### Exercise

```swift
enum TransactionCategory: Equatable {
    case food
    case shopping
    case transfer
    case bill
}

struct Transaction {
    let id: String
    let amount: Double
    let note: String?
    let category: TransactionCategory
}

func filterTransactions(
    _ transactions: [Transaction],
    by category: TransactionCategory
) -> [Transaction] {
    return transactions.filter { $0.category == category }
}
```

---

## Day 4 — Closures

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
let result = transactions.filter { $0.amount > 100000 }
```

### Exercise

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

---

## Day 5 — Protocols, Extensions, Generics

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

---

## Day 6 — Async/Await and Error Handling

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

func validateAmount(_ amount: Double) throws {
    if amount <= 0 {
        throw TransactionError.invalidAmount
    }
}
```

```swift
protocol TransactionService {
    func fetchTransactions() async throws -> [Transaction]
}

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

---

## Day 7 — Mini Project: Transaction Manager

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

---

# 6. Week 2 — SwiftUI Views and Layout

## Goal

Hiểu SwiftUI declarative UI và layout.

Build static screens trước khi thêm state phức tạp.

---

## Concepts

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
- `Group`
- `ScrollView`
- `LazyVStack`
- `List`
- `ForEach`
- `.padding`
- `.background`
- `.foregroundStyle`
- `.font`
- `.frame`
- `.clipShape`
- Preview

---

## React Native ↔ SwiftUI Layout Mapping

| React Native | SwiftUI |
|---|---|
| `<View />` | `VStack`, `HStack`, `ZStack`, `Group` |
| `<Text />` | `Text` |
| `<Image />` | `Image` |
| `<Button />` | `Button` |
| `<TextInput />` | `TextField` |
| `ScrollView` | `ScrollView` |
| `FlatList` | `List` or `ScrollView + LazyVStack` |
| `flexDirection: 'row'` | `HStack` |
| `flexDirection: 'column'` | `VStack` |
| `position: absolute` | `ZStack`, `.overlay`, `.background` |
| `padding: 16` | `.padding(16)` |
| `borderRadius` | `.clipShape(RoundedRectangle(cornerRadius:))` |
| `backgroundColor` | `.background(...)` |

---

## Key Mental Model

React Native layout is Flexbox-first.

SwiftUI layout is Stack-first.

React Native:

```tsx
<View style={{ flexDirection: 'row', alignItems: 'center' }}>
  <Icon />
  <Text>Payment</Text>
</View>
```

SwiftUI:

```swift
HStack(alignment: .center, spacing: 8) {
    Image(systemName: "creditcard")
    Text("Payment")
}
```

---

## Modifier Order Matters

These are different:

```swift
Text("Hello")
    .padding()
    .background(.blue)
```

```swift
Text("Hello")
    .background(.blue)
    .padding()
```

The first applies background after padding. The second applies padding after background.

---

## Exercises

### Exercise 1: Balance Card

Create:

- balance title
- amount
- subtitle
- rounded card
- padding
- background

### Exercise 2: Transaction Row

Create:

- icon
- title
- note
- amount
- date

### Exercise 3: E-wallet Home Screen

Build:

- header
- balance card
- quick actions
- promotion banner
- transaction list
- empty state

---

## Suggested Folder Structure

```text
Features/
  Home/
    HomeView.swift
    Components/
      BalanceCardView.swift
      QuickActionButton.swift
      TransactionRowView.swift

Shared/
  DesignSystem/
    AppSpacing.swift
    AppRadius.swift
```

---

## Checklist

The learner should be able to:

- Create SwiftUI views
- Compose child views
- Use Stack layout
- Use modifiers correctly
- Understand why modifier order matters
- Build list-like UI
- Choose between `List` and `LazyVStack`
- Build reusable components

---

# 7. Week 3 — State, Binding, Form, Data Flow

## Goal

Hiểu cách data di chuyển trong SwiftUI.

Build forms và interactive screens.

---

## Concepts

- `@State`
- `@Binding`
- Callback closures
- `@Observable`
- `@Environment`
- `.task`
- `.onAppear`
- `.onChange`
- Form input
- Validation state
- Parent-child data flow

---

## React Native ↔ SwiftUI State Mapping

| React Native | SwiftUI |
|---|---|
| `useState` | `@State` |
| `setState` | Direct assignment to state |
| Props | `let` stored property |
| Callback prop | Closure property |
| Controlled component | `@Binding` |
| Context | `@Environment` |
| Zustand/Redux store | `@Observable` Store |
| `useEffect(() => {}, [])` | `.task` / `.onAppear` |
| `useEffect(..., [value])` | `.onChange(of:)` |

---

## Local State Example

React Native:

```tsx
const [name, setName] = useState("");

<TextInput value={name} onChangeText={setName} />
```

SwiftUI:

```swift
@State private var name = ""

TextField("Name", text: $name)
```

`$name` passes a Binding.

---

## Parent-Child Binding Example

```swift
struct ParentView: View {
    @State private var isOn = false

    var body: some View {
        ChildView(isOn: $isOn)
    }
}

struct ChildView: View {
    @Binding var isOn: Bool

    var body: some View {
        Toggle("Enabled", isOn: $isOn)
    }
}
```

---

## Callback Closure Example

```swift
struct TransactionRowView: View {
    let transaction: Transaction
    let onSelect: (Transaction) -> Void

    var body: some View {
        Button {
            onSelect(transaction)
        } label: {
            Text(transaction.displayNote)
        }
    }
}
```

---

## Exercises

### Exercise 1: Add Transaction Form

Fields:

- amount
- note
- category
- date
- submit button

State:

- local form state
- validation error
- submit success

### Exercise 2: Extract Form Components

Create:

- `AmountTextField`
- `CategoryPicker`
- `DatePickerRow`
- `SubmitButton`

### Exercise 3: Parent-Child Binding

Parent owns form state. Child components edit values using `@Binding`.

---

## Checklist

The learner should be able to:

- Use `@State`
- Use `@Binding`
- Pass callbacks to child views
- Build controlled input forms
- Validate input
- Use `.task`, `.onAppear`, `.onChange`
- Avoid side effects inside `body`

---

# 8. Week 4 — Navigation and Architecture

## Goal

Build multi-screen SwiftUI app with clean structure.

---

## Concepts

- `NavigationStack`
- `NavigationLink`
- `navigationDestination`
- Enum route
- Route parameters
- `sheet`
- `fullScreenCover`
- Feature folder structure
- Store / ViewModel
- Service
- Repository
- Dependency injection

---

## React Navigation ↔ SwiftUI Navigation Mapping

| React Navigation | SwiftUI |
|---|---|
| Stack Navigator | `NavigationStack` |
| `navigation.navigate("Profile")` | `path.append(.profile)` |
| Route params | Enum associated value |
| Modal screen | `sheet` / `fullScreenCover` |
| Screen component | SwiftUI View |
| Navigation container | App-level `NavigationStack` |

---

## Enum Route Example

```swift
enum AppRoute: Hashable {
    case transactionDetail(id: String)
    case addTransaction
    case profile
}
```

```swift
struct AppRouterView: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { id in
                    path.append(.transactionDetail(id: id))
                },
                onAddTransaction: {
                    path.append(.addTransaction)
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .transactionDetail(let id):
                    TransactionDetailView(id: id)
                case .addTransaction:
                    AddTransactionView()
                case .profile:
                    ProfileView()
                }
            }
        }
    }
}
```

---

## Suggested Architecture

```text
App/
  MainApp.swift
  AppRouterView.swift
  AppRoute.swift

Features/
  Home/
    HomeView.swift
    HomeStore.swift
    Components/
  Transaction/
    TransactionListView.swift
    TransactionDetailView.swift
    TransactionFormView.swift
    TransactionStore.swift

Shared/
  Components/
  DesignSystem/
  Models/
  Networking/
  Persistence/
  Extensions/
```

---

## Architecture Mapping

| React Native Architecture | SwiftUI Equivalent |
|---|---|
| Screen + hooks + service | View + Store + Service |
| Zustand store | `@Observable final class Store` |
| Redux reducer | Store methods / action enum |
| React Query | Repository + Loadable state |
| Context Provider | Environment |
| API client | Service / Repository |
| Feature folder | Feature folder |

---

## Exercises

### Exercise 1: Build App Routes

Create:

- `AppRoute`
- `AppRouterView`
- home route
- transaction detail route
- add transaction route

### Exercise 2: Sheet Flow

Create filter sheet:

- category filter
- date filter
- apply button
- clear button

### Exercise 3: Feature Store

Create `TransactionStore`.

Responsibilities:

- load transactions
- add transaction
- update transaction
- delete transaction
- filter transactions

---

## Checklist

The learner should be able to:

- Use `NavigationStack`
- Use enum-based routes
- Pass route params safely
- Use `sheet`
- Organize feature folders
- Separate View from business logic
- Create basic Store and Service

---

# 9. Week 5 — Networking, Async/Await, Persistence

## Goal

Build app data layer with async APIs and local storage.

---

## Concepts

- `URLSession`
- `Codable`
- `async/await`
- `throws`
- `do/try/catch`
- Request model
- Response model
- Repository
- `Loadable` state
- Retry
- Cancellation
- Debounced search
- UserDefaults
- File storage
- SwiftData intro

---

## Networking Mapping

| React Native / TypeScript | Swift |
|---|---|
| Fetch / Axios | `URLSession` |
| TypeScript interface | `Codable struct` |
| Promise | async function |
| Promise rejection | thrown error |
| `try/catch` | `do/try/catch` |
| AbortController | Task cancellation |
| React Query state | `Loadable` enum |

---

## Loadable State

```swift
enum Loadable<Value> {
    case idle
    case loading
    case loaded(Value)
    case failed(String)
}
```

---

## Service Example

```swift
protocol TransactionService {
    func fetchTransactions() async throws -> [Transaction]
}
```

```swift
final class RemoteTransactionService: TransactionService {
    func fetchTransactions() async throws -> [Transaction] {
        let url = URL(string: "https://example.com/transactions")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Transaction].self, from: data)
    }
}
```

---

## Store Example

```swift
@Observable
@MainActor
final class TransactionStore {
    var state: Loadable<[Transaction]> = .idle

    private let service: TransactionService

    init(service: TransactionService) {
        self.service = service
    }

    func load() async {
        state = .loading

        do {
            let transactions = try await service.fetchTransactions()
            state = .loaded(transactions)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
}
```

---

## Persistence Mapping

| React Native | Swift |
|---|---|
| AsyncStorage | `UserDefaults` / file storage |
| MMKV | UserDefaults / custom storage / third-party |
| SQLite | SQLite / GRDB |
| Realm | Realm Swift |
| WatermelonDB | SQLite / custom offline architecture |
| Local DB abstraction | Repository |
| Offline cache | Repository + local data source |

---

## Exercises

### Exercise 1: Mock API Service

Create async service returning fake transactions after delay.

### Exercise 2: Loadable State

Create screen rendering:

- idle
- loading
- loaded
- empty
- failed

### Exercise 3: Persistence Layer

Create local repository that saves transactions to local storage.

### Exercise 4: Search App

Build GitHub Repo Search or Movie Search:

- search input
- debounce
- result list
- loading
- error retry
- detail screen

---

## Checklist

The learner should be able to:

- Create Codable models
- Call API with `URLSession`
- Use async/await
- Handle errors
- Model loading state
- Create repository abstraction
- Create mock services
- Persist simple data locally
- Understand when to use SwiftData vs custom repository

---

# 10. Week 6 — Design System, Testing, Production Readiness

## Goal

Build polished, testable SwiftUI mini app.

---

## Concepts

- Custom components
- Custom `ViewModifier`
- Design tokens
- Button style
- Text field style
- Theme
- Dark mode
- Dynamic type
- Accessibility
- Localization
- Animation
- Gestures
- Unit tests
- UI tests
- Instruments
- Performance debugging
- CI/CD basics

---

## Design System Mapping

| React Native | SwiftUI |
|---|---|
| StyleSheet | View modifiers |
| Styled components | Custom SwiftUI views |
| NativeWind / Tailwind | Design tokens + modifiers |
| Theme provider | Environment / static design system |
| Reusable component | Reusable View |
| Button variants | `ButtonStyle` |
| Text input variants | Custom View / modifier |

---

## Example Design Tokens

```swift
enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
}

enum AppRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
}
```

---

## Custom Card Modifier

```swift
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(AppSpacing.md)
            .background(.background)
            .clipShape(RoundedRectangle(cornerRadius: AppRadius.md))
            .shadow(radius: 4)
    }
}

extension View {
    func appCard() -> some View {
        modifier(CardModifier())
    }
}
```

Usage:

```swift
VStack {
    Text("Balance")
    Text("1,000,000 VND")
}
.appCard()
```

---

## Accessibility Mapping

| React Native | SwiftUI |
|---|---|
| `accessibilityLabel` | `.accessibilityLabel()` |
| `accessibilityHint` | `.accessibilityHint()` |
| `accessibilityRole` | native control semantics / traits |
| Dynamic font scaling | Dynamic Type |
| Screen reader support | VoiceOver |

---

## Testing Mapping

| React Native | Swift |
|---|---|
| Jest | XCTest / Swift Testing |
| Unit test hook/store | Unit test Store |
| Mock API | Mock Service / Repository |
| Detox | XCUITest |
| Snapshot test | SnapshotTesting library if needed |

---

## Final Project: Mini E-wallet SwiftUI App

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

# 11. Common Mistakes When Moving from React Native to SwiftUI

## Mistake 1: Treating SwiftUI `body` like a side-effect zone

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

---

## Mistake 2: Forcing Flexbox into SwiftUI

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

---

## Mistake 3: Overusing global stores

In SwiftUI:

- Use `@State` for local view state.
- Use `@Binding` for parent-child controlled state.
- Use `@Observable` store for feature state.
- Use `@Environment` for dependencies or global app context.

Not every state needs to be global.

---

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

---

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

instead of forcing `List` to behave like a fully custom React Native `FlatList`.

---

# 12. Final Roadmap Checklist

## Swift Foundation

- [ ] Understand `let` and `var`
- [ ] Understand basic types
- [ ] Write functions
- [ ] Create structs
- [ ] Create classes
- [ ] Understand value type vs reference type
- [ ] Use Optional
- [ ] Use `if let`
- [ ] Use `guard let`
- [ ] Use arrays
- [ ] Use dictionaries
- [ ] Use map/filter/sorted/reduce
- [ ] Use enums
- [ ] Use closures
- [ ] Use protocols
- [ ] Use extensions
- [ ] Use generics
- [ ] Use async/await
- [ ] Handle errors with `do/try/catch`

## SwiftUI Basics

- [ ] Create `struct SomeView: View`
- [ ] Use `body`
- [ ] Use `Text`
- [ ] Use `Image`
- [ ] Use `Button`
- [ ] Use `TextField`
- [ ] Use `VStack`
- [ ] Use `HStack`
- [ ] Use `ZStack`
- [ ] Use `Spacer`
- [ ] Use `ScrollView`
- [ ] Use `LazyVStack`
- [ ] Use `List`
- [ ] Use `ForEach`
- [ ] Use view modifiers
- [ ] Understand modifier order

## Data Flow

- [ ] Use `@State`
- [ ] Use `@Binding`
- [ ] Pass callback closures
- [ ] Use `@Observable`
- [ ] Use `@Environment`
- [ ] Use `.task`
- [ ] Use `.onAppear`
- [ ] Use `.onChange`
- [ ] Build controlled forms
- [ ] Validate form input

## Navigation

- [ ] Use `NavigationStack`
- [ ] Use `NavigationLink`
- [ ] Use `navigationDestination`
- [ ] Use enum-based routing
- [ ] Pass route parameters
- [ ] Use `sheet`
- [ ] Use `fullScreenCover`

## Architecture

- [ ] Create feature folder structure
- [ ] Separate View and Store
- [ ] Create Service layer
- [ ] Create Repository layer
- [ ] Use Protocol for abstraction
- [ ] Use Mock Service
- [ ] Use `Loadable` state
- [ ] Use `@MainActor` correctly

## Networking and Persistence

- [ ] Create Codable models
- [ ] Use `URLSession`
- [ ] Decode JSON
- [ ] Handle API errors
- [ ] Use async service
- [ ] Use repository
- [ ] Persist local data
- [ ] Understand SwiftData basics

## Production

- [ ] Create design tokens
- [ ] Create reusable components
- [ ] Create custom modifiers
- [ ] Support dark mode
- [ ] Add accessibility labels
- [ ] Add localization
- [ ] Write unit tests
- [ ] Write basic UI tests
- [ ] Use Instruments
- [ ] Understand app lifecycle
- [ ] Understand CI/CD basics

---

# 13. Agent Instruction

When this file is used as context for Claude Code or another AI agent:

- Teach the learner by mapping React Native / TypeScript to Swift / SwiftUI.
- Assume the learner is senior in React Native.
- Avoid beginner-level explanations unless they are Swift-specific.
- Provide practical code examples.
- Prefer e-wallet / transaction / mobile production examples.
- When reviewing code, focus on:
  - Swift syntax
  - Swift conventions
  - Correct use of value/reference types
  - Correct SwiftUI data flow
  - Avoiding React Native patterns that do not translate well
  - Production-readiness
- For every new SwiftUI concept, explain:
  1. What it is
  2. React Native equivalent if any
  3. Key difference
  4. Small code example
  5. Exercise

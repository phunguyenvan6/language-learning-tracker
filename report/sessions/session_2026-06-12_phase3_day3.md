# Session Report — 2026-06-12 — @Environment, Lifecycle & Transaction List

## Thông tin buổi học

- **Ngày:** 2026-06-12
- **Phase:** Phase 3 — SwiftUI State & Data Flow
- **Day:** Day 3 — @Environment, .task / .onAppear / .onChange, TransactionListSection
- **Thời lượng:** ~2.5 giờ (ước tính)

---

## Mục tiêu buổi học

- [x] Inject `TransactionManager` qua `@Environment` từ app entry
- [x] Consume `@Environment` trong `ContentView` và `TransactionListSection`
- [x] Dùng `.task` cho async lifecycle (debug seed)
- [x] Dùng `.onAppear` và `.onChange(of:)` đúng chỗ
- [x] Build `TransactionListSection` với empty state + swipe-to-delete
- [x] REVIEW Pass

---

## Những gì đã học

### Concept chính

**`@Environment` injection pattern:**
- App owner dùng `@State private var manager = TransactionManager()` — giống `useState` nhưng ở App level
- `.environment(manager)` truyền vào `WindowGroup` — giống `<Context.Provider value={manager}>`
- Child views consume bằng `@Environment(TransactionManager.self) private var manager` — không cần prop drilling

**`.task` vs `.onAppear`:**
- `.task { }` — async, structured concurrency, tự cancel khi view disappear. Dùng cho async work (API call, seed có sleep)
- `.onAppear { }` — sync, không tự cancel. Dùng cho logging, analytics, non-async setup
- Tương đương `useEffect(() => { /* cleanup */ }, [])` nhưng cleanup là automatic với `.task`

**`.onChange(of:)`** — 3 use cases trong Day 3:
- `didSubmitSuccessfully` → spawn `Task { sleep 2s → set false }` để auto-dismiss banner
- `amountText` → clear `errorMessage` khi user bắt đầu type lại
- `manager.transactions.count` → log count (observability)

**`VStack(spacing: 0) { List; Button }` layout:**
- `Group` không phải layout container — modifier áp trên `Group` áp cho tất cả children, gây double-fire
- `VStack(spacing: 0)` stack rõ ràng `List` (fill) trên, `Button` dưới

**Static formatter cache:**
- `private static let vndFormatter: NumberFormatter = { ... }()` — tạo một lần, reuse mãi
- Tương tự singleton pattern trong TypeScript: `const formatter = new Intl.NumberFormat(...)`

### Code đã viết

```swift
// App entry — owner + injection
@main
struct AddTransactionFormApp: App {
    @State private var manager = TransactionManager()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(manager)
        }
    }
}

// Consumer — không cần prop
struct ContentView: View {
    @Environment(TransactionManager.self) private var manager

    var body: some View {
        VStack(spacing: 0) {
            List { ... }
                .task {
                    #if DEBUG
                    guard !didSeedDemo, manager.transactions.isEmpty else { return }
                    didSeedDemo = true
                    try? await Task.sleep(for: .milliseconds(300))
                    try? manager.add(amount: 25_000, note: "Demo seed", ...)
                    #endif
                }
                .onAppear {
                    print("ContentView appeared, count:", manager.transactions.count)
                }
                .onChange(of: didSubmitSuccessfully) { _, newValue in
                    guard newValue else { return }
                    Task {
                        try await Task.sleep(for: .seconds(2))
                        withAnimation { didSubmitSuccessfully = false }
                    }
                }

            Button { submit() } label: { ... }
                .disabled(!isFormValid || submitting)
        }
    }
}
```

```swift
// TransactionListSection — swipe delete qua @Environment
struct TransactionListSection: View {
    let transactions: [Transaction]
    let onRefresh: () -> Void
    let onTransactionTap: (String) -> Void

    @Environment(TransactionManager.self) private var manager

    var body: some View {
        Section {
            if transactions.isEmpty {
                EmptyTransactionsView { onRefresh() }
            } else {
                ForEach(transactions) { tx in
                    TransactionRowView(transaction: tx, action: onTransactionTap)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                withAnimation { manager.delete(id: tx.id) }
                            } label: { Label("Xóa", systemImage: "trash") }
                        }
                }
            }
        }
    }
}
```

### Mapping React Native → SwiftUI

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| `React.createContext` + `Context.Provider` | `@State` ở App + `.environment()` |
| `useContext(MyContext)` | `@Environment(MyType.self)` |
| `useEffect(() => {}, [])` | `.task { }` (async) / `.onAppear { }` (sync) |
| `useEffect` cleanup `return () => {}` | Automatic với `.task` (structured concurrency) |
| `const formatter = new Intl.NumberFormat(...)` | `private static let formatter: NumberFormatter = { ... }()` |
| `<FlatList ListEmptyComponent={<Empty />} />` | `if isEmpty { EmptyView }` trong `ForEach` hoặc `Section` |

---

## Điểm đã hiểu rõ

- `@Environment` ownership: App `@State` owns → child consumes, không phải child owns
- Tại sao `.task` ưu tiên hơn `.onAppear` cho async: auto-cancel khi view disappear tránh memory leak / race condition
- `Group` vs `VStack` — `Group` transparent, modifier áp lên tất cả children; `VStack` là layout container
- `private static let` pattern để cache formatter — tạo một lần per type, không per instance
- `.onChange` phải attach vào view có trong hierarchy — không attach vào `Group` để tránh double-fire

---

## Điểm còn chưa chắc / cần ôn lại

- **Khi nào dùng `@Environment` vs callback prop?** — Hiện tại `TransactionListSection` dùng cả hai (callback `onTransactionTap` + env `manager.delete`). Khi Phase 4 có detail screen, sẽ refactor `onDelete` callback để component pure hơn. Chưa có rule of thumb rõ ràng.
- **`@Environment` (Observation) vs `@EnvironmentObject` (cũ)?** — Biết `@Environment` dùng với `@Observable`, `@EnvironmentObject` dùng với `ObservableObject`. Nhưng chưa thực sự gặp tình huống cần `@EnvironmentObject` nên chưa rõ trade-off thực tế.

---

## Exercise đã hoàn thành

- [x] Inject `TransactionManager` qua `@Environment` từ App entry
- [x] Consume trong `ContentView` — không prop drilling
- [x] `.task` với async seed + `#if DEBUG` guard
- [x] `.onAppear` logging
- [x] `.onChange` 3 nơi (banner, error clear, count log)
- [x] `TransactionListSection` với `EmptyTransactionsView` + swipe-to-delete
- [x] `VStack(spacing: 0) { List; Button }` layout
- [x] Formatter cache (`vndFormatter` static let)
- [x] REVIEW Pass (2 iterations)

### Fixes qua REVIEW

| Issue | Kết quả |
|---|---|
| `validate` free function → private method | ✅ Fixed |
| `onTransactionTap` vừa print vừa delete | ✅ Fixed (print only) |
| `.onChange`/`.sensoryFeedback` trên `Group` | ✅ Fixed → chuyển vào `List` |
| `Group { List; Button }` không có layout | ✅ Fixed → `VStack(spacing: 0)` |
| `vndFormatter` tạo mới mỗi lần gọi | ✅ Fixed → `static let` |
| `submitting` sync no-op | ⏳ Defer → Phase 6 async |
| Dual data flow `TransactionListSection` | ⏳ Defer → Phase 4 detail screen |

---

## Ghi chú thêm

- `contentTransition(.numericText(value:))` trên count label — nice SwiftUI-native touch, roll animation khi count thay đổi trong `withAnimation`
- `sensoryFeedback(.success, trigger:)` — iOS 17+ API, haptic khi submit thành công
- `#if DEBUG` block cho seed + `didSeedDemo` flag — pattern production-ready để tránh auto-seed trong release build
- `try withAnimation(.snappy) { try manager.add(...) }` — wrapping throwing call trong `withAnimation` hợp lệ trong Swift

---

## Next session

**Chủ đề tiếp theo:** Phase 3 Wrap-up / Phase 4 Day 1 — NavigationStack

Phase 3 checklist hoàn thành:
- [x] `@State`, `@Binding`, `@Observable`, `@Environment`
- [x] Callback closures, parent-child data flow
- [x] Form state + validation
- [x] `.task`, `.onAppear`, `.onChange`
- [x] Avoid side effects inside `body`

Sang Phase 4: `NavigationStack`, `NavigationLink`, `navigationDestination`, enum route, `sheet`.
Project: TransactionFlow — app nhiều màn hình với navigation.

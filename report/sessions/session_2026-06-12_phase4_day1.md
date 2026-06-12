# Session Report — 2026-06-12 — NavigationStack & Enum Routes

## Thông tin buổi học

- **Ngày:** 2026-06-12
- **Phase:** Phase 4 — Navigation & App Structure
- **Day:** Day 1 — NavigationStack, AppRoute, navigationDestination, programmatic routing
- **Thời lượng:** ~2.5 giờ (ước tính)

---

## Mục tiêu buổi học

- [x] Tạo project `TransactionFlow` — app nhiều màn hình
- [x] `AppRoute` enum `Hashable` với associated values
- [x] `NavigationStack(path:)` + `.navigationDestination(for:)`
- [x] Home → Detail → Add flow với programmatic routing
- [x] Route params truyền `id: String`, lookup từ `@Environment` manager
- [x] `@Environment(\.dismiss)` cho pop programmatic
- [x] REVIEW Pass với góp ý (đã fix + stretch previews)

---

## Những gì đã học

### Concept chính

**NavigationStack + path binding:**
- `@State private var path: [AppRoute] = []` — navigation stack state, giống history stack trong React Navigation
- `NavigationStack(path: $path) { root }` — một stack duy nhất ở app router, không nested
- `path.append(.transactionDetail(id: id))` ≈ `navigation.navigate("Detail", { id })`
- `.navigationDestination(for: AppRoute.self) { route in ... }` ≈ `<Stack.Screen>` registry — đặt trên root view bên trong stack

**Enum-based routing:**
```swift
enum AppRoute: Hashable {
    case home
    case transactionDetail(id: String)
    case addTransaction
}
```
- Associated value = route params type-safe (union type TypeScript)
- Chỉ truyền primitive `id`, không pass cả `Transaction` — tránh stale data khi manager mutate

**Callback vs @Environment (rule of thumb rõ hơn):**
- **Navigate intent** → callback từ child lên router (`onOpenTransaction`, `onAddTransaction`)
- **Shared state mutate** → `@Environment(TransactionManager.self)` (swipe delete, detail delete)
- Giải quyết defer Phase 3: dual data flow không còn mơ hồ — tách responsibility rõ

**`@Environment(\.dismiss)`:**
- Pop một level trong stack ≈ `navigation.goBack()`
- Dùng trong `AddTransactionView` placeholder và delete-then-pop trên detail

**Preview patterns:**
- `HomePreviewShell` — wrapper DRY: `NavigationStack` + path + destination + `.environment(manager)`
- `PreviewRuntime.isRunning` (`XCODE_RUNNING_FOR_PREVIEWS`) — tắt DEBUG seed trong Canvas, Empty preview thật sự empty
- 4 previews: Seeded interactive, Empty, Seeded Dark, Empty Dark

### Code đã viết

**App entry + router:**
```swift
// TransactionFlowApp.swift
@State private var manager = TransactionManager()
AppRouterView().environment(manager)

// AppRouterView.swift
NavigationStack(path: $path) {
    HomeView(
        onOpenTransaction: { path.append(.transactionDetail(id: $0)) },
        onAddTransaction: { path.append(.addTransaction) }
    )
    .navigationDestination(for: AppRoute.self) { route in ... }
}
```

**Detail lookup by id:**
```swift
private var transaction: Transaction? {
    manager.transactions.first { $0.id == transactionId }
}
```

**Home row tap — Button + callback (không mix NavigationLink):**
```swift
Button { onOpenTransaction(tx.id) } label: { ... }
    .buttonStyle(.plain)
```

### Mapping React Native → SwiftUI

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| Stack Navigator | `NavigationStack` |
| `navigation.navigate("Detail", { id })` | `path.append(.transactionDetail(id: id))` |
| Route params object | Enum associated value |
| `<Stack.Screen name="..." component={...} />` | `.navigationDestination(for: AppRoute.self)` |
| `navigation.goBack()` | `@Environment(\.dismiss)` / back chevron tự có |
| Screen component | SwiftUI `View` per route |
| Storybook wrap NavigationContainer | `HomePreviewShell` + `NavigationStack` |
| Mock empty vs seeded state | `TransactionManager()` vs `.previewSeeded()` |

---

## Điểm đã hiểu rõ

- Tại sao route chỉ truyền `id` — detail re-fetch từ shared manager, không giữ snapshot object
- Một `NavigationStack` ở router — child views không tạo stack riêng
- Router owns `path`, screens báo intent qua callback — separation giống navigation service trong RN
- Preview cần bọc `NavigationStack` mới thấy `.navigationTitle` / `.toolbar`
- DEBUG seed phải skip khi `XCODE_RUNNING_FOR_PREVIEWS` — nếu không Empty preview bị pollute

---

## Điểm còn chưa chắc / cần ôn lại

- **`AppRoute.home` dead case** — tồn tại nhưng không bao giờ push; có thể bỏ hoặc dùng cho deep link sau
- **`sheet` vs stack push** — chưa thực hành; add flow hiện push stack, Day 2 sẽ học khi nào dùng modal
- **Delete animation inconsistency** — home swipe có `withAnimation`, detail delete chưa — minor UX gap

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày (không copy solution)
- [x] Đã qua REVIEW (Pass với góp ý → đã fix stretch previews)

### Project structure
```text
projects/week4-navigation/TransactionFlow/TransactionFlow/
├── TransactionFlowApp.swift
├── navigation/
│   ├── AppRoute.swift
│   └── AppRouterView.swift
├── features/
│   ├── home/HomeView.swift
│   └── transaction/
│       ├── TransactionDetailView.swift
│       └── AddTransactionView.swift  (placeholder Day 2)
└── models/  (copy từ Week 3)
```

### Stretch đã làm
- Swipe-to-delete trên home
- Delete button trên detail + `dismiss()`
- `.navigationBarTitleDisplayMode(.inline)` trên detail
- `HomePreviewShell` + 4 previews (Seeded, Empty, Dark variants)
- `PreviewRuntime` guard cho DEBUG seed

### Review feedback (đã xử lý)
| Issue | Kết quả |
|---|---|
| `print(tx.id)` debug leftover | ✅ Fixed (trước SESSION) |
| `ContentView.swift` scaffold unused | ⏳ Defer cleanup |
| `AppRoute.home` dead case | ⏳ Defer — deep link Day sau |
| Preview Empty bị DEBUG seed | ✅ Fixed — `PreviewRuntime.isRunning` |
| Thiếu Empty + Dark previews | ✅ Fixed — 4 previews |

---

## Ghi chú thêm

- Ban đầu thử `NavigationLink(value:)` rồi chuyển sang `Button` + callback — nhất quán hơn với router pattern
- `ContentUnavailableView` cho empty state — API iOS 17+, gọn hơn custom empty view
- Phase 4 Day 1 không cần port form từ `AddTransactionForm` — placeholder add screen đủ scope

---

## Next session

**Chủ đề tiếp theo:** Phase 4 Day 2 — `sheet`, filter flow, port add transaction form

- Port form components từ `AddTransactionForm` vào `AddTransactionView`
- Học `sheet(isPresented:)` / `sheet(item:)` cho filter modal
- Quyết định: add flow giữ stack push hay chuyển sheet (roadmap Exercise 2: filter sheet)
- Optional: cleanup `ContentView.swift`, bỏ `AppRoute.home` nếu không dùng

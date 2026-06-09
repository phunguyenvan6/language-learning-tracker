# Session Report — 2026-06-09 — @Observable & Observation Data Flow

---

## Thông tin buổi học

- **Ngày:** 2026-06-09
- **Phase:** Phase 3 — SwiftUI State & Data Flow
- **Day:** Day 1 — `@Observable`, bỏ `listRevision`, scaffold Week 3
- **Thời lượng:** ~3 giờ (GUIDE + implement + REVIEW bắt buộc Pass với góp ý + Q&A sort/seed + stretch + REVIEW stretch **Pass**)

---

## Mục tiêu buổi học

- [x] Thêm `@Observable` trên `TransactionManager` — bỏ `ObservableObject` / `@Published`
- [x] Xóa workaround `listRevision` + `.id(listRevision)` trong `ContentView`
- [x] UI tự cập nhật khi seed / refresh / delete — không force remount
- [x] Comment giải thích `@State` (owner) + `@Observable` (property observation)
- [x] Stretch: scaffold `AddTransactionForm` Week 3 + verify delete qua tap row
- [x] Stretch: seed `createdAt` lệch nhau + `sortByNewest()` hiển thị đúng thứ tự

---

## Những gì đã học

### Concept chính

- **`@Observable` (Observation framework, iOS 17+):** SwiftUI track property được **đọc** trong `body` (ví dụ `transactions` qua `sortByNewest()`, `totalAmount()`). Khi property đổi → re-render — không cần bump `@State` reference.
- **`@State` vẫn giữ:** View **sở hữu** instance `TransactionManager` (tạo một lần, giữ lifecycle). Khác với `@ObservedObject` era — không cần `@Published` trên từng field.
- **Bỏ `listRevision`:** Workaround Phase 2 (`listRevision += 1` + `.id()`) tương đương RN `key={rev}` — không còn cần sau `@Observable`.
- **Seed + sort:** `add(amount:note:category:createdAt:)` với `Date().addingTimeInterval(...)` — `sortByNewest()` có ý nghĩa trên UI; seed loop `Date()` cùng lúc làm sort trông “không hoạt động”.
- **Delete verify observation:** Tap row → `manager.delete(id:)` → list + `BalanceCard` cập nhật không workaround.
- **Week 3 scaffold:** Project `AddTransactionForm` — copy models + `AppTheme` + Assets; `ContentView` placeholder (form → Day 2).

### Code đã viết

```swift
// TransactionManager.swift — @Observable store
import Observation

@Observable
final class TransactionManager {
    private(set) var transactions: [Transaction] = []
    // add/delete/sortByNewest/totalAmount...
}

// ContentView.swift — owner + observation, không listRevision
@State private var manager = TransactionManager()

private var sortedTransactions: [Transaction] {
    manager.sortByNewest()
}

private func onTransactionTap(id: String) {
    manager.delete(id: id)
}

// Seed với createdAt lệch nhau
try manager.add(amount: sample.0, note: sample.1, category: sample.2, createdAt: sample.3)
```

```swift
// TransactionRowView + TransactionListSection — callback delete test
TransactionRowView(transaction: tx, action: onTransactionTap)

Button { action(transaction.id) } label: { /* row UI */ }
```

### Mapping React Native → SwiftUI

| React Native | Swift/SwiftUI Day 1 |
|---|---|
| `useState(store)` + mutate object, UI stale | `@State` + plain `class` — cần `@Observable` |
| `setState({})` / bump `key` | ~~`listRevision`~~ → `@Observable` |
| Zustand/Redux subscribe | Observation tracks reads in `body` |
| Callback `onPress` → dispatch delete | `onTransactionTap: (String) -> Void` → `manager.delete(id:)` |
| Controlled re-render via selector | `sortByNewest()` reads `transactions` → observed |

---

## Điểm đã hiểu rõ

- Vì sao Phase 2 cần `listRevision` và vì sao `@Observable` thay thế được.
- `@State` = owner; `@Observable` = fine-grained property tracking — hai vai trò khác nhau.
- `sorted()` trả array mới; sort “không thấy” do seed cùng `Date()` — fix bằng `createdAt` lệch.
- Tap row delete → balance + list update chứng minh observation chain hoạt động.

---

## Điểm còn chưa chắc / cần ôn lại

- `@Bindable` vs `@State` khi child cần two-way binding — **Day 2**.
- `TextField`, `Picker`, form validation — **Day 2+**.
- Week 3 `TransactionManager` duplicate `add(amount:...)` — cần sync overload `createdAt` với Week 2 trước Day 2.
- Row toàn bộ là `Button` — tạm OK cho delete test; Phase 4 navigation sẽ tách tap target.

---

## Exercise / Project đã làm

- [x] Day 1 bài tập bắt buộc (REVIEW **Pass với góp ý** → đã polish)
- [x] Stretch 1–3 (REVIEW stretch **Pass với góp ý**)
- [x] Build succeeded: `EWalletHomeScreen` + `AddTransactionForm`

### Deliverables

**Week 2 — `EWalletHomeScreen`**
- `models/TransactionManager.swift` — `@Observable`, overload `add(..., createdAt:)`
- `ContentView.swift` — bỏ `listRevision`, seed staggered dates, `onTransactionTap` delete
- `TransactionListSection.swift` — `onTransactionTap` callback
- `TransactionRowView.swift` — `Button` + `action: (String) -> Void`

**Week 3 — `AddTransactionForm`**
- Scaffold: models, `TransactionError`, `AppTheme`, semantic color Assets
- `ContentView.swift` — placeholder (Hello world) — form Day 2

### Review feedback (tóm tắt)

- **Bắt buộc v1:** Pass với góp ý — `sortByAmount` vs title “gần đây”, `shouldSeedOnAppear` default.
- **Sau polish:** `sortByNewest()`, seed `createdAt`, default `shouldSeedOnAppear: false`.
- **Stretch:** Pass — scaffold Week 3 compile; delete via tap; góp ý sync manager Week 2/3, bỏ `print` debug.

---

## Ghi chú thêm

- Quyết định **không copy cả project** sang Week 3 — refactor `@Observable` trong Week 2; Week 3 chỉ scaffold form + shared models.
- Preview **Dark** dùng `shouldSeedOnAppear: true` — chủ đích xem dark mode có data.

---

## Next session

**Chủ đề tiếp theo:** Phase 3 Day 2 — `@Binding`, `TextField`, `Picker` / category, form local state + validation

**Gợi ý cụ thể:**

1. Mở `projects/week3-state-data-flow/AddTransactionForm/AddTransactionForm/ContentView.swift`
2. `@State private var manager = TransactionManager()` + form fields (`amount`, `note`, `category`)
3. Child components nhận `@Binding` — `AmountTextField`, `CategoryPicker` (roadmap Week 3 Exercise 2)
4. Submit → `try manager.add(...)` — hiển thị success/error state
5. Sync `TransactionManager` Week 3 với Week 2 (overload `createdAt`, xóa duplicate `add`)

**Project:** `AddTransactionForm` (Week 3)

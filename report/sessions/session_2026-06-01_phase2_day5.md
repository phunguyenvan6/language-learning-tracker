# Session Report — 2026-06-01 — TransactionManager, Dynamic List & Empty State

---

## Thông tin buổi học

- **Ngày:** 2026-06-01
- **Phase:** Phase 2 — SwiftUI Views & Layout
- **Day:** Day 5 — `TransactionManager` trong UI, list động, empty state + stretch
- **Thời lượng:** ~2 giờ (GUIDE + debug re-render + REVIEW + stretch nút Làm mới)

---

## Mục tiêu buổi học

- [x] Gắn `TransactionManager` (Week 1) vào `ContentView` qua `@State`
- [x] Seed giao dịch qua `add(amount:note:category:)` — bỏ mock `(0..<40).map`
- [x] List từ `manager.sortByNewest()` + `ForEach`
- [x] `EmptyTransactionsView` khi `transactions` rỗng
- [x] **Stretch:** `BalanceCard` = `manager.totalAmount()`, `shouldSeedOnAppear`, `do/catch` + `LocalizedError`
- [x] **Stretch:** Nút Làm mới (`Label` + `arrow.clockwise`), callback closure

---

## Những gì đã học

### Concept chính

- `@State private var manager = TransactionManager()` — view sở hữu store in-memory (tạm thời, chưa `@Observable`).
- **Re-render với `class`:** mutate `manager.transactions` không tự cập nhật UI — cần `@State` đổi (`listRevision`) hoặc Phase 3 dùng `@Observable` / `@Published`.
- `.onAppear` + `guard isEmpty` — seed một lần, không gọi trong `body`.
- Computed `sortedTransactions` ≈ selector Redux (`sortByNewest()`).
- Conditional UI: `if sortedTransactions.isEmpty { Empty... } else { ForEach }` ≈ ternary render RN.
- `EmptyTransactionsView(onRefresh:)` — callback closure (`@escaping` pattern ở component con).
- `Label("Làm mới", systemImage: "arrow.clockwise")` — icon + text chuẩn iOS.
- Preview variants: `shouldSeedOnAppear: false` cho màn empty.

### Code đã viết

```swift
@State private var manager = TransactionManager()
@State private var listRevision = 0

.onAppear {
    guard shouldSeedOnAppear, manager.transactions.isEmpty else { return }
    seedSampleTransactions()
    listRevision += 1
}

if sortedTransactions.isEmpty {
    EmptyTransactionsView { print("refresh tapped") }
} else {
    ForEach(sortedTransactions) { tx in
        TransactionRowView(transaction: tx)
    }
}
.id(listRevision)
```

```swift
// EmptyTransactionsView — stretch refresh
Button(action: onRefresh) {
    Label("Làm mới", systemImage: "arrow.clockwise")
        .font(AppTypography.body)
        .foregroundStyle(AppColor.brandPrimary)
}
.buttonStyle(.plain)
```

### Mapping React Native → SwiftUI

| React Native | Swift/SwiftUI |
|---|---|
| `useState(store)` (reference) | `@State private var manager` |
| `setState({})` sau mutate object | `listRevision += 1` (workaround Day 5) |
| `useMemo` sort list | `private var sortedTransactions` |
| `list.length === 0 ? <Empty /> : <List />` | `if sortedTransactions.isEmpty` |
| `onRefresh` prop | `EmptyTransactionsView { }` trailing closure |
| Redux `selectSortedTransactions` | `manager.sortByNewest()` |
| `useEffect` mount seed | `.onAppear { seed... }` |

---

## Điểm đã hiểu rõ

- Vì sao seed xong mà list vẫn trống — `@State` không track deep change của `class`.
- `listRevision` + `.id(listRevision)` buộc SwiftUI rebuild section list.
- Một nguồn data: balance + list cùng từ `manager`.
- Tách `EmptyTransactionsView` + inject `onRefresh` — giữ component thuần UI.

---

## Điểm còn chưa chắc / cần ôn lại

- `listRevision` là workaround — Phase 3 `@Observable` trên `TransactionManager` để bỏ.
- Nút Làm mới mới `print` — chưa gọi seed/fetch thật khi empty.
- `List` vs `ScrollView + LazyVStack` — chưa so sánh thực hành (Week 2 roadmap còn `List`).
- `BalanceCard` contrast trên gradient — cleanup nhỏ từ Day 2/3 chưa làm.

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày (không copy full solution)
- [x] Đã qua REVIEW — **Pass** (bắt buộc + stretch)

### Deliverables

- `ContentView.swift` — manager, seed, `sortedTransactions`, empty branch, `listRevision`, previews
- `EmptyTransactionsView.swift` — empty UI + refresh button + previews Light/Dark

### Review feedback (tóm tắt)

- **Vòng 1:** Pass với góp ý — thiếu stretch refresh; `listRevision` pattern đúng sau debug.
- **Vòng 2:** **Pass** đủ stretch — `arrow.clockwise`, `LocalizedError`, preview Empty; gợi ý nhỏ: đặt tên `#Preview` rõ, optional `ContentView` Empty + Dark.

---

## Ghi chú thêm

- Bug “có data không vẽ lại” là bài học state SwiftUI quan trọng — tương đương mutate Redux store không dispatch.
- Week 2 home screen gần đủ roadmap: header, balance, quick actions, banner, transaction list, empty state.

---

## Next session

**Chủ đề tiếp theo:** Phase 2 Day 6 hoặc mở Phase 3 — tùy lộ trình tuần

**Gợi ý cụ thể (ưu tiên):**

1. **Phase 3 Day 1 — `@Observable` + `@Bindable`:** refactor `TransactionManager` → UI tự cập nhật, bỏ `listRevision`; wiring refresh gọi `seed` hoặc fetch mock.
2. **Hoặc Phase 2 wrap-up:** thử `List` / `List` + swipe delete; polish `BalanceCard` contrast; `#Preview("Empty — Dark")` trên `ContentView`.

**Project:** tiếp tục `projects/week2-swiftui-basics/EWalletHomeScreen/` → Phase 3 project `AddTransactionForm`.

# Session Report — 2026-05-27 — Mini Project: Transaction Manager

---

## Thông tin buổi học

- **Ngày:** 2026-05-27
- **Phase:** Phase 1 — Swift Foundation (buổi cuối Week 1)
- **Day:** Day 7 — Mini Project: Transaction Manager
- **Thời lượng:** ~1 giờ 15 phút (GUIDE + capstone + REVIEW vòng 1 & 2)

---

## Mục tiêu buổi học

- [x] Gom Week 1 vào module `TransactionManager` — playground độc lập
- [x] `Transaction` + `Identifiable` + `createdAt` + `var` cho update
- [x] CRUD: `add`, `delete(id:)`, `update(_:)`
- [x] Query: `filter(by:)`, `sortByNewest()`, `totalAmount()`
- [x] `displayNote` / `displayAmount` + `Double.asVND()`
- [x] Stretch: `add(amount:note:category:)`, `throws` + `validateAmount`, `printSummary()`, `LocalizedError`
- [x] Demo `runDay7Demo()` — seed, reject amount âm, update, delete
- [x] REVIEW **Pass** (vòng 2)

---

## Những gì đã học

### Concept chính

- **Capstone Week 1** — một `final class` store + `struct` model thay vì code rải 7 playground
- **`private(set) var transactions`** — đọc ngoài, mutate trong manager (≈ encapsulated store)
- **`Identifiable` + `createdAt`** — chuẩn bị `ForEach` / sort newest trong SwiftUI
- **Hai overload `add`** — full `Transaction` vs convenience `amount/note/category`
- **`update`/`add` throws** — validation thống nhất qua `validateAmount` (nối Day 6)
- **`printSummary()`** — debug/UI preview trước khi có `List`

### Code đã viết

Path: `projects/week1-swift-foundation/Day7-TransactionManager.playground/Contents.swift`

```swift
struct Transaction: Identifiable, Equatable {
    let id: String
    var amount: Double
    var note: String?
    var category: TransactionCategory
    var createdAt: Date
}

final class TransactionManager {
    private(set) var transactions: [Transaction] = []

    func add(_ transaction: Transaction) throws { /* validate + append */ }
    func add(amount:note:category:) throws { /* UUID + Date() */ }
    func delete(id: String) { /* removeAll */ }
    func update(_ tx: Transaction) throws { /* index + validate */ }
    func filter(by:) -> [Transaction]
    func sortByNewest() -> [Transaction]
    func totalAmount() -> Double
    func printSummary()
}
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift Day 7 |
|---|---|
| In-memory store class | `final class TransactionManager` |
| `items.map` display helpers | `extension Transaction { displayNote, displayAmount }` |
| `filter` + `sort` selectors | `filter(by:)`, `sortByNewest()` |
| `FlatList` `keyExtractor` | `Identifiable.id` |
| Validate trước khi dispatch add | `throws` trên `add` / `update` |
| `console.log` store snapshot | `printSummary()` |

---

## Điểm đã hiểu rõ

- Gom pattern Day 1–6: enum category, optional note, formatter VND, filter/sort/reduce, throws
- `t4` amount âm bị reject — store không corrupt data
- `add(amount:note:category:)` + overload `add(_:)` — API layer rõ ràng
- Sau REVIEW v2: `update` validate, bỏ `throws -> Void`, bỏ `.self` trên `sorted`

---

## Điểm còn chưa chắc / cần ôn lại

- Gắn `TransactionManager` vào SwiftUI — `@State`, `@Observable`, hay inject (Phase 2–3)
- `update` khi `id` không tồn tại — silent `return` (có thể đổi sang `throws` sau)
- `TransactionError.emptyList` khai báo nhưng chưa dùng trong Day 7
- Tách file `.swift` shared giữa Playground và App project (khi build EWalletHomeScreen)

---

## Exercise / Project đã làm

- [x] Đã tự làm capstone Day 7 (không copy full solution roadmap)
- [x] Đã qua REVIEW (**Pass** vòng 2)

### Review feedback

- **Vòng 1:** Pass — góp ý `update` chưa validate, `throws -> Void`, demo trùng `printSummary`
- **Vòng 2:** **Pass** — đủ bắt buộc + stretch; polish `add(amount:...)`, `update` throws

---

## Ghi chú thêm

- **Phase 1 / Week 1 hoàn thành** — 7/7 ngày, 7 playground
- Milestone: sẵn sàng **Phase 2 — SwiftUI Views & Layout**, project `EWalletHomeScreen`
- Week 1 checklist (roadmap): có thể tự ôn 15 câu hỏi cuối Phase 1 trước khi mở SwiftUI app

---

## Next session

**Chủ đề tiếp theo:** Phase 2 — SwiftUI Views & Layout (Week 2)

- Tạo iOS App: `projects/week2-swiftui-basics/EWalletHomeScreen/`
- `struct …: View`, `body`, `VStack`/`HStack`, `Text`, `List`, `ForEach`
- Hiển thị transaction list từ `TransactionManager` — `displayAmount`, `sortByNewest()`
- Màn hình e-wallet: header, balance card, quick actions, empty state (theo roadmap Week 2)

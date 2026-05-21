# Session Report — 2026-05-19 — Arrays, Dictionaries, Enums

---

## Thông tin buổi học

- **Ngày:** 2026-05-19
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 3 — Arrays, Dictionaries, Enums
- **Thời lượng:** ~55 phút (GUIDE 18/05 + thực hành + REVIEW 19/05)

---

## Mục tiêu buổi học

- [x] Thao tác `[Transaction]` — `map`, `filter`, `sorted`, `reduce`
- [x] Nhóm dữ liệu với `[String: Double]` và `[TransactionCategory: Double]`
- [x] Thay union string bằng `enum TransactionCategory` + `Equatable`
- [x] Viết `filterTransactions(_:by:)` — hàm pure, truyền mảng vào thay vì đọc global `store`
- [x] Cập nhật model `Transaction` với `category` và test data ≥ 4 giao dịch

---

## Những gì đã học

### Concept chính

- `[T]` typed array — tương đương `T[]` trong TypeScript
- `map` / `filter` / `sorted` / `reduce` — closure `{ }`, shorthand `$0`
- `sorted` trả mảng mới, không mutate source (giống spread + sort trong JS)
- Dictionary `[Key: Value]` — `dict[key, default: 0]` khi key **chưa có** trong dict (không liên quan `note` nil)
- `enum` type-safe thay `"food" | "shopping"` — so sánh cần `Equatable`
- External parameter label `by` khi gọi hàm vs tên nội bộ `category`
- `enum` + `String` raw value + `extension` cho `title` hiển thị UI

### Code đã viết

Path: `projects/week1-swift-foundation/Day3-Collections.playground/Contents.swift`

```swift
enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transfer = "Transfer"
    case bill = "Bill"
}

struct Transaction {
    let id: String
    let amount: Double
    let note: String?
    let category: TransactionCategory
}

func filterTransactions(_ transactions: [Transaction], by category: TransactionCategory) -> [Transaction] {
    transactions.filter { $0.category == category }
}

var totalsByCategory: [TransactionCategory: Double] = [:]
for tx in store.transactions {
    totalsByCategory[tx.category, default: 0] += tx.amount
}
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift |
|---|---|
| `Transaction[]` | `[Transaction]` |
| `arr.map(x => x.amount)` | `arr.map { $0.amount }` |
| `arr.filter(x => x.amount > 100_000)` | `arr.filter { $0.amount > 100_000 }` |
| `[...arr].sort((a,b) => b - a)` | `arr.sorted { $0.amount > $1.amount }` |
| `Record<string, number>` | `[String: Double]` |
| `obj[key] ?? 0` khi cộng dồn | `dict[key, default: 0] += value` |
| `"food" \| "shopping"` | `enum TransactionCategory { case food, ... }` |
| `tx.category === category` | `$0.category == category` (cần `Equatable`) |
| Tham số gọi hàm một tên | Label ngoài `by:` + tên trong `category` |

---

## Điểm đã hiểu rõ

- Phân biệt `dict[key, default: 0]` (key chưa có trong dict) vs `note ?? "..."` (optional → key String)
- Trong `filter { $0.category == category }`: `$0.category` trên từng tx, `category` là tham số hàm
- `by` là argument label khi gọi — có thể bỏ hoặc đổi, không phải biến riêng
- Pattern pure function `filterTransactions(store.transactions, by: .food)` — giống selector Redux
- Tự thêm `t5` transfer để test filter nhiều item cùng category
- Sau REVIEW vòng 2: polish output, `totalsByCategory`, sort sau filter, `??` cho optional in print

---

## Điểm còn chưa chắc / cần ôn lại

- Optional chaining với method call (`user?.getName()`) — từ Day 2, chưa thực hành
- In `totalsByCategory` dùng `\(key)` in ra case enum (`food`) — nên dùng `key.title` khi hiển thị
- Case `.shopping` có trong enum nhưng chưa có transaction test — có thể thêm khi ôn

---

## Exercise đã hoàn thành

- [x] `enum TransactionCategory` 4 case + `Equatable`
- [x] `struct Transaction` có `category`
- [x] `filterTransactions(_:by:)` — in `.food` và `.transfer`
- [x] 5 giao dịch test (`t1`–`t5`), ≥ 3 category
- [x] Stretch: `String` raw value + `extension.title`
- [x] Stretch: `map`/`filter`/`sorted`, `totalsByLabel`, `totalsByCategory`, sort filter output
- [x] Đã qua REVIEW (**Pass** — vòng 2 sau polish)

### Review feedback

- Vòng 1: Pass với góp ý — bỏ in `$0`, đổi `TransTx`, thêm `totalsByCategory`, sort filter
- Vòng 2: **Pass** — đủ bắt buộc + stretch; góp ý nhỏ: sort giảm dần nếu muốn, `key.title` khi in category

---

## Ghi chú thêm

- User hỏi sâu trong buổi: `default:` dictionary vs optional interpolation — hiểu đúng sau giải thích
- Hỏi `by` vs `category` trong filter — nắm được trước khi nộp bài
- E-wallet mini đã có: model + store + format + optional note + category + filter + aggregate — sẵn sàng cho Day 4 callback pattern

---

## Next session

**Chủ đề tiếp theo:** Day 4 — Closures

- Callback `() -> Void` và `(String) -> Void`
- Trailing closure syntax
- Bài tập: `performTransaction(amount:onSuccess:onFailure:)` với closure success/failure
- Ôn nhẹ: `$0`/`$1` đã dùng trong Day 3 — Day 4 formalize closure như RN callback props

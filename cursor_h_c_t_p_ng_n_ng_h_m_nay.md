# Học tập ngôn ngữ hôm nay
_Exported on 5/18/2026 at 22:01:00 GMT+7 from Cursor (3.4.20)_

---

**User**

/language-learning-tracker tình hình học tập của tôi hôm nay đến đâu rồi? Tóm tắt bài cũ và giảng giải bài mới giúp tôi

---

**Cursor**

Đang kiểm tra tiến độ học và tài liệu trong repo để lập kế hoạch tóm tắt bài cũ và hướng dẫn bài mới.


Đã nắm tiến độ: 2 buổi hôm nay (Day 1–2 xong), sẵn sàng Day 3. Đang lập kế hoạch tóm tắt và hướng dẫn bài mới.


---

**User**

Implement the plan as specified, it is attached for your reference. Do NOT edit the plan file itself.

To-do's from the plan have already been created. Do not create them again. Mark them as in_progress as you work, starting with the first one. Don't stop until you have completed all the to-dos.

---

**Cursor**

Đang triển khai plan: tóm tắt tiến độ, recap Day 1–2, và GUIDE Day 3 đầy đủ.


# Tình hình học tập — 2026-05-18

**Bạn đang ở:** Phase 1 — Swift Foundation, **Day 3** (Day 1–2 đã xong)

| Mục | Chi tiết |
|-----|----------|
| Buổi hôm nay | 2 buổi (~1h45) |
| Đã hoàn thành | Day 1 + Day 2 — REVIEW **Pass** |
| Code | `Day1-SwiftFoundation.playground`, `Day2-Optionals.playground` |
| Tiếp theo | Arrays, Dictionaries, Enums → playground Day 3 mới |

Hôm nay bạn đã dựng được “xương sống” e-wallet mini: model `Transaction`, store `TransactionStore`, format VND, optional `note`. Day 3 gắn **phân loại giao dịch** (enum) và **lọc/nhóm** (array + dictionary) — bước tự nhiên trước khi sang SwiftUI list/filter.

---

## Tóm tắt bài cũ

### Day 1 — Variables, Functions, Structs, Classes (~1h)

- `let` / `var` — nhớ map **ngược** TypeScript: `const` → `let`, `let` → `var`.
- `struct Transaction` (data) + `final class TransactionStore` (mutable collection).
- `reduce` tính tổng; `NumberFormatter` với `groupingSeparator = ","` cho VND cố định.
- Pattern tốt: `formatAmount` (raw) vs `formatAmountWithSymbol` (hiển thị).

**Ôn nhẹ (không chặn Day 3):** copy `struct` vs reference `class`; `Locale(identifier: "vi_VN")` khi cần format theo locale thật.

### Day 2 — Optionals (~45 phút)

- `String?`, `??`, `if let` / `guard let`; `displayNote` tái dùng trong `printNotes()`.
- Model hiện tại là điểm xuất phát:

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String?
}
```

**Ôn trước khi code Day 3:** optional chaining `user?.profile?.name` (chưa thực hành); shorthand `if let note { }` (Swift 5.7+).

---

# GUIDE — Day 3: Arrays, Dictionaries, Enums

Làm **từng bước**, chạy playground sau mỗi bước, rồi mới sang bước tiếp.

---

## Chuẩn bị

1. Mở **Xcode** → **File → New → Playground...** (⌘⇧N)
2. Platform: **macOS**
3. Tên: `Day3-Collections`
4. Save tại:  
   `/Users/mac/Documents/Project/language-learning-tracker/projects/week1-swift-foundation/`  
   (không save Desktop)
5. Xóa code mẫu `//: A Swift Tour`
6. Copy từ Day 2 vào `Contents.swift`:
   - `formatAmount`, `formatAmountWithSymbol`, `displayNote`
   - `struct Transaction` (chưa có `category`)
   - `final class TransactionStore` + harness `t1`–`t4` + `printNotes()` cuối file

**Lưu ý:** `import Cocoa` giữ như Day 2 nếu playground đã chạy OK; nếu lỗi thử `import Foundation`.

Sau khi tạo xong, mở `Contents.swift` và chạy (▶) để xác nhận output giống Day 2.

---

## Bước 1 — Array cơ bản

**Mục tiêu:** Hiểu `[Transaction]` là mảng typed, giống `Transaction[]` trong TS.

**Mapping:**

| TypeScript | Swift |
|---|---|
| `number[]` | `[Double]` |
| `Transaction[]` | `[Transaction]` |

```swift
let amounts: [Double] = [50000, 120000, 2500000]
print(amounts.count)        // 3
print(amounts[0])            // 50000

// Từ store — cùng kiểu với property transactions
let list = store.transactions
print(list.count)
```

**Thử:** In `store.transactions.count` và phần tử đầu tiên (nếu có).

**Ghi nhớ:** Swift không có `Array<Transaction>` bắt buộc — `[Transaction]` là cú pháp thường dùng.

---

## Bước 2 — map, filter, sorted, reduce

**Mục tiêu:** Thao tác collection như `.map` / `.filter` trong JS — closure viết `{ }` thay vì `=>`.

**Mapping:**

| TypeScript | Swift |
|---|---|
| `arr.map(x => x.amount)` | `arr.map { $0.amount }` |
| `arr.filter(x => x.amount > 100000)` | `arr.filter { $0.amount > 100000 }` |
| `[...arr].sort((a,b) => b.amount - a.amount)` | `arr.sorted { $0.amount > $1.amount }` |

```swift
let txs = store.transactions

let amounts = txs.map { $0.amount }
let large = txs.filter { $0.amount > 100_000 }
let sortedByAmount = txs.sorted { $0.amount > $1.amount }

let total = txs.reduce(0) { $0 + $1.amount }  // đã dùng Day 1
print("Large count:", large.count)
print("Top amount:", sortedByAmount.first?.amount ?? 0)
```

**Thử:** In số giao dịch > 100_000; in amount của giao dịch lớn nhất sau `sorted`.

**Ghi nhớ:** `sorted` trả **mảng mới** — không mutate `transactions` (giống spread + sort trong TS).

---

## Bước 3 — Dictionary

**Mục tiêu:** Nhóm dữ liệu theo key — `Record<string, number>` trong TS.

**Mapping:**

| TypeScript | Swift |
|---|---|
| `Record<string, number>` | `[String: Double]` |
| `obj[key] = value` | `dict[key] = value` |

```swift
// Ví dụ tạm — key là String mô tả (sau Day 3 dùng enum)
var totalsByLabel: [String: Double] = [:]

for tx in store.transactions {
    let key = tx.note ?? "Không có ghi chú"
    totalsByLabel[key, default: 0] += tx.amount
}

for (key, total) in totalsByLabel {
    print("\(key): \(formatAmountWithSymbol(total))")
}
```

**Thử:** Chạy và xem tổng theo từng `note` (tạm thời; Bước 5–6 sẽ dùng `category`).

**Ghi nhớ:** `dict[key, default: 0]` tránh phải unwrap optional khi cộng dồn — tiện hơn `dict[key] ?? 0`.

---

## Bước 4 — Enum thay union string

**Mục tiêu:** Thay `type Category = "food" | "shopping"` bằng enum type-safe.

**Mapping:**

| TypeScript | Swift |
|---|---|
| `"food" \| "shopping"` | `enum TransactionCategory { case food, shopping }` |
| So sánh string | `tx.category == .food` |

Đặt enum **trước** `struct Transaction`:

```swift
enum TransactionCategory: Equatable {
    case food
    case shopping
    case transfer
    case bill
}
```

**Thử:** In thử (sẽ compile sau khi có property — hoặc tạm):

```swift
let cat: TransactionCategory = .food
print(cat == .food)   // true
```

**Ghi nhớ:** `.food` là shorthand khi Swift suy ra kiểu `TransactionCategory` — giống enum trong TS nhưng mạnh hơn string literal.

---

## Bước 5 — Enum raw value + extension (stretch trong GUIDE)

**Mục tiêu:** Gắn label hiển thị (UI sau này) mà vẫn giữ case gọn.

```swift
enum TransactionCategory: String, Equatable {
    case food = "Food"
    case shopping = "Shopping"
    case transfer = "Transfer"
    case bill = "Bill"
}

extension TransactionCategory {
    var title: String { rawValue }
}
```

**Thử:** `print(TransactionCategory.transfer.title)` → `Transfer`

**Ghi nhớ:** `Equatable` cho phép `filter { $0.category == category }` — bắt buộc cho bài tập.

*(Bài bắt buộc roadmap chỉ cần `Equatable` không bắt buộc `String` raw value — phần trên là stretch.)*

---

## Bước 6 — Cập nhật model + test data

**Mục tiêu:** Gắn category vào `Transaction` và sửa toàn bộ initializer.

```swift
struct Transaction {
    let id: String
    let amount: Double
    let note: String?
    let category: TransactionCategory
}
```

Cập nhật `t1`–`t4` (ví dụ gợi ý — bạn tự gán hợp domain):

| id | amount | note | category (gợi ý) |
|----|--------|------|------------------|
| 1 | 50_000 | Coffee | `.food` |
| 2 | 120_000 | Lunch | `.food` |
| 3 | 2_500_000 | Transfer | `.transfer` |
| 4 | -100_000 | nil | `.bill` |

```swift
let t1 = Transaction(id: "1", amount: 50000, note: "Coffee", category: .food)
// ... tương tự t2, t3, t4
```

**Thử:** `store.printNotes()` vẫn chạy; compile không lỗi.

**Ghi nhớ:** Thêm field `let` → **mọi** chỗ tạo `Transaction(...)` phải sửa — compiler bắt hết (an toàn hơn TS optional field).

---

## Bước 7 — filterTransactions (chuẩn bị bài tập)

**Mục tiêu:** Hàm pure filter theo category — pattern dùng lại cho SwiftUI list sau này.

```swift
func filterTransactions(
    _ transactions: [Transaction],
    by category: TransactionCategory
) -> [Transaction] {
    transactions.filter { $0.category == category }
}
```

**Thử:**

```swift
let foodOnly = filterTransactions(store.transactions, by: .food)
foodOnly.forEach { print(displayNote($0.note), $0.category, formatAmountWithSymbol($0.amount)) }
```

**Ghi nhớ:** Truyền `[Transaction]` vào hàm thay vì đọc global `store` — dễ test và giống “selector” trong Redux.

---

## Bài tập cuối ngày — tự làm

### Yêu cầu bắt buộc

- [ ] `enum TransactionCategory: Equatable` với 4 case: `food`, `shopping`, `transfer`, `bill`
- [ ] `struct Transaction` có `category: TransactionCategory`
- [ ] `filterTransactions(_:by:)` trả về `[Transaction]` đúng category
- [ ] ≥ 4 giao dịch test, ≥ 2 category khác nhau
- [ ] In kết quả filter ít nhất 2 category (ví dụ `.food` và `.transfer`)

### Stretch

- [ ] `TransactionCategory: String` raw value + `var title` trong `extension`
- [ ] Trước khi in, `sorted` theo `amount` giảm dần
- [ ] `[TransactionCategory: Double]` hoặc `[String: Double]` — tổng amount theo từng category

### Dữ liệu / output mong đợi

| Thao tác | Kỳ vọng |
|----------|---------|
| `filter(..., by: .food)` | Chỉ Coffee + Lunch (nếu dùng data gợi ý) |
| `filter(..., by: .transfer)` | Chỉ Transfer 2,500,000 |
| `printNotes()` | Vẫn in đủ 4 dòng + tổng cuối |

### Tiêu chí tự check

- [ ] Playground compile + chạy OK
- [ ] `filter` dùng `$0.category == category`
- [ ] Formatter + `displayNote` Day 1–2 vẫn hoạt động
- [ ] Không dùng `!` force unwrap trên optional

### Sau khi xong

Paste code hoặc `@projects/week1-swift-foundation/Day3-Collections.playground/Contents.swift` → gõ **REVIEW** (hoặc "chấm bài Day 3"). Pass → **SESSION** để ghi buổi học.

---

**Ước tính:** ~45–60 phút.

Khi bạn xong bài hoặc kẹt ở bước cụ thể, gửi code hoặc mô tả chỗ kẹt — mình sẽ REVIEW hoặc gợi ý hướng (không dump full solution trừ khi bạn yêu cầu rõ).


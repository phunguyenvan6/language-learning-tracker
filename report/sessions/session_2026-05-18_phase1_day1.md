# Session Report — 2026-05-18 — Variables, Functions, Structs, Classes

---

## Thông tin buổi học

- **Ngày:** 2026-05-18
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 1 — Variables, Functions, Structs, Classes
- **Thời lượng:** ~1 giờ

---

## Mục tiêu buổi học

- [x] Hiểu `let` / `var` và mapping với TS `const` / `let`
- [x] Tạo `struct Transaction` và `class TransactionStore`
- [x] Hoàn thành bài tập cuối ngày trong playground
- [x] Format số tiền VND có nhóm nghìn

---

## Những gì đã học

### Concept chính

- `let` vs `var`, type inference, function với return type
- `struct` cho data model (`Transaction`), `final class` cho store (`TransactionStore`)
- `add(_:)`, `totalAmount()` với `reduce`
- **Format số:** `NumberFormatter` — `numberStyle`, `groupingSeparator`, `maximumFractionDigits`, `string(from:)`
- Quy tắc SwiftUI sơ bộ: Model → `struct`, Store → `class`

### Code đã viết

Path: `projects/week1-swift-foundation/Day1-SwiftFoundation.playground/Contents.swift`

- `formatAmount` — chuỗi thô `\(amount) VND`
- `formatAmountWithSymbol` — `NumberFormatter` với `groupingSeparator = ","`
- `TransactionStore.printNotes()` — in `note: amount VND` từng dòng + tổng

### Mapping từ ngôn ngữ cũ → mới

| React Native / TypeScript | Swift |
|---|---|
| `const` | `let` |
| `let` | `var` |
| `interface` / object type | `struct` |
| Class service / store | `final class` |
| `array.reduce` | `transactions.reduce(0) { $0 + $1.amount }` |
| `` `${n.toLocaleString()} VND` `` / `Intl.NumberFormat` | `NumberFormatter` + `groupingSeparator` |

---

## Điểm đã hiểu rõ

- Phân tách model (`struct` + `let`) vs store (`class` + mutable array)
- Harness in danh sách giao dịch + tổng, không hard-code
- Cấu hình format: `.formatted()` phụ thuộc locale máy; muốn cố định dấu `,` thì set `NumberFormatter.groupingSeparator` (hoặc `Locale` sau này)

---

## Điểm còn chưa chắc / cần ôn lại

- **Value vs reference:** đã khai báo `transactionStretch` nhưng chưa chạy demo copy `struct` vs hai biến cùng `TransactionStore`
- Khi nào dùng `Locale(identifier: "vi_VN")` thay vì set separator tay
- `import Cocoa` có cần trong playground không

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày (không copy solution)
- [x] Đã qua REVIEW (**Pass**)

### Review feedback

- Lần 1: thiếu format từng dòng `note: amount`; đặt tên `store` trong `TransactionStore`
- Đã sửa: `printNotes()` + `transactions`, `NumberFormatter` với `,`
- Stretch value/reference: chưa hoàn thành (không chặn Pass)

---

## Ghi chú thêm

- Buổi có GUIDE từng bước + REVIEW hai vòng; user chủ động hỏi về format (`.` → `,`) — áp dụng tốt vào e-wallet domain.
- `formatAmount` giữ bản đơn giản; UI/list dùng `formatAmountWithSymbol` — pattern tách “raw” vs “display” giống formatter trong RN.

---

## Next session

**Chủ đề tiếp theo:** Day 2 — Optionals (`String?`, `if let`, `guard let`, `??`, optional chaining)

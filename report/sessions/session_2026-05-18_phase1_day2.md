# Session Report — 2026-05-18 — Optionals

---

## Thông tin buổi học

- **Ngày:** 2026-05-18
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 2 — Optionals
- **Thời lượng:** ~45 phút

---

## Mục tiêu buổi học

- [x] Hiểu `String?` vs `String` và tại sao Swift ép xử lý nil tại compile time
- [x] Dùng `??` để unwrap với fallback
- [x] Viết hàm nhận `String?` và trả về `String`
- [x] Cập nhật `printNotes()` tái sử dụng hàm `displayNote`

---

## Những gì đã học

### Concept chính

- `T?` là Optional — biến thông thường không bao giờ nil trong Swift
- `??` nil coalescing — giống TypeScript, syntax không đổi
- `if let` — unwrap và dùng trong block, biến bên trong là non-optional
- `guard let` — early exit khi nil, biến sau `guard` có scope toàn hàm
- Optional chaining `?.` — kết quả luôn là Optional dù property gốc không phải
- Force unwrap `!` — crash nếu nil; chỉ dùng trong test/fixture, không dùng production

### Code đã viết

Path: `projects/week1-swift-foundation/Day2-Optionals.playground/Contents.swift`

```swift
func displayNote(_ note: String?) -> String {
    note ?? "Không có ghi chú"
}

struct Transaction {
    let id: String
    let amount: Double
    let note: String?   // ← optional
}

// printNotes() tái sử dụng displayNote
transactions.forEach { print("\(displayNote($0.note)): \(formatAmountWithSymbol($0.amount))") }
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift |
|---|---|
| `string \| undefined` | `String?` |
| `value ?? fallback` | `value ?? fallback` |
| `if (!x) return` | `guard let x else { return }` |
| `user?.profile?.avatar` | `user?.profile?.avatar` |
| Không có compile-time null check | Compiler bắt Optional chưa unwrap |

---

## Điểm đã hiểu rõ

- Phân biệt khi nào dùng `if let` (cần cả hai nhánh) vs `guard let` (early exit)
- `displayNote` viết 1 dòng bằng `??` và được tái sử dụng trong `printNotes()`
- `!` chỉ hợp lệ trong test/fixture — không dùng production

---

## Điểm còn chưa chắc / cần ôn lại

- Optional chaining với method call (`user?.getName()`) — chưa thực hành
- `if let` shorthand Swift 5.7 (`if let note { }`) vs cú pháp cũ (`if let note = note { }`)

---

## Exercise đã hoàn thành

- [x] Đổi `note: String` → `note: String?` trong `struct Transaction`
- [x] Viết `displayNote(_ note: String?) -> String` (1 dòng, dùng `??`)
- [x] Cập nhật `printNotes()` gọi `displayNote($0.note)`
- [x] Test data có cả nil và non-nil, kể cả amount âm (`t4`)
- [x] Đã qua REVIEW (**Pass** — vòng 3)

### Review feedback

- Vòng 1: thiếu `displayNote`; fallback trong `printNotes()` là `""` thay vì `"Không có ghi chú"`
- Vòng 2: fallback đã đúng nhưng `displayNote` vẫn chưa có
- Vòng 3: đủ hết — Pass

---

## Ghi chú thêm

- User thêm `t4.amount = -100_000` (âm) vào test data — thể hiện tư duy về edge case trong domain tài chính.
- Pattern "viết hàm helper nhỏ (`displayNote`) rồi tái sử dụng trong method" — đây là style đúng, giống cách tổ chức formatter trong RN.

---

## Next session

**Chủ đề tiếp theo:** Day 3 — Arrays, Dictionaries, Enums

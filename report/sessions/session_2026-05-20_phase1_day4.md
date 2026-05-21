# Session Report — 2026-05-20 — Closures

---

## Thông tin buổi học

- **Ngày:** 2026-05-20
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 4 — Closures
- **Thời lượng:** ~60 phút (GUIDE + thực hành + REVIEW v1/v2 + tách playground)

---

## Mục tiêu buổi học

- [x] Hiểu closure như callback — `() -> Void`, `(String) -> Void`, `(Double) -> Void`
- [x] Dùng trailing closure (`handleAmount { }`, `simulatePayment(...) { }`)
- [x] Viết `performTransaction(amount:onSuccess:onError:)` — nhánh success / failure
- [x] Viết `simulatePayment(amount:note:onComplete:)` — callback sau payment, `store.add` trong closure
- [x] Tách code sang `Day4-Closures.playground` riêng

---

## Những gì đã học

### Concept chính

- Closure = hàm truyền như giá trị — map trực tiếp sang `onPress` / `onSuccess` trong RN
- Trailing closure: tham số closure cuối (hoặc multiple trailing có label như SwiftUI `Button { } label: { }`)
- `performTransaction` — pattern dual callback (success / error), tương tự API payment
- `simulatePayment` — single `onComplete` callback; side effect (`store.add`) gọi **trong** closure, không trong hàm sync
- `note: String?` + `displayNote(note)` — tránh `note ?? ""` làm mất fallback `"Không có ghi chú"`
- Shorthand `$0` trong closure một tham số (`simulatePayment(..., note: nil) { print($0) }`)
- Multiple trailing closure (Swift 5.3+) — đã thảo luận qua `Button { } label: { }` (chuẩn bị Week 2)

### Code đã viết

Path: `projects/week1-swift-foundation/Day4-Closures.playground/Contents.swift`

```swift
func performTransaction(
    amount: Double,
    onSuccess: (String) -> Void,
    onError: (String) -> Void
) {
    if amount > 0 {
        onSuccess("Success: \(formatAmountWithSymbol(amount))")
    } else {
        onError("Failed: Invalid amount")
    }
}

func simulatePayment(amount: Double, note: String?, onComplete: (String) -> Void) {
    onComplete("Payment completed: \(formatAmountWithSymbol(amount)) - \(displayNote(note))")
}

simulatePayment(amount: t6.amount, note: t6.note) {
    text in
    print(text)
    store.add(t6)
}

simulatePayment(amount: 10_000, note: nil) { print($0) }
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift |
|---|---|
| `onPress={() => ...}` | `onPress { ... }` / trailing closure |
| `(amount: number) => void` | `(Double) -> Void` |
| `onSuccess(msg => ...)` | `onSuccess: { msg in ... }` |
| `onError(err => ...)` | `onError: { error in ... }` |
| `onComplete?.()` sau payment | `onComplete("...")` trong `simulatePayment` |
| `dispatch(addTx(t6))` trong callback | `store.add(t6)` trong closure |

---

## Điểm đã hiểu rõ

- Trailing closure cho `handleAmount` và `simulatePayment`
- Gọi `performTransaction` với `t1` (success) và `t4` (error) — đúng I/O
- Sửa `simulatePayment` từ `String` + `note ?? ""` sang `String?` + `t6.note` sau REVIEW
- Tách `Day4-Closures.playground`; file gọn hơn (bỏ demo collection chạy lại, giữ model/store seed)
- Thêm test `note: nil` — xác nhận `displayNote` hoạt động trong closure message
- Hỏi sâu trailing closure vs multiple trailing (`Button` action/label) — nắm khác biệt

---

## Điểm còn chưa chắc / cần ôn lại

- `@escaping` — chưa thực hành trong playground; sẽ gặp khi callback async / SwiftUI `Button`
- Optional chaining gọi method (`user?.getName()`) — từ Day 2, vẫn chưa có bài riêng
- Style: `import Foundation`, spacing `(Double) -> Void`, `note:` label

---

## Exercise đã hoàn thành

- [x] `handleAmount` + trailing closure
- [x] `performTransaction` + 2 lần gọi (amount dương / âm)
- [x] `simulatePayment` + `onComplete` với `String?` note
- [x] Stretch: `store.add(t6)` trong `onComplete`
- [x] Stretch: `simulatePayment(amount: 10_000, note: nil) { print($0) }`
- [x] Đã qua REVIEW (**Pass** — vòng 2 sau tách file + sửa `String?`)

### Review feedback

- Vòng 1 (code trong Day3 file): Pass — góp ý tách Day4, `note: String?`, trailing `simulatePayment`
- Vòng 2 (`Day4-Closures.playground`): **Pass** — đủ bắt buộc + stretch; góp ý nhỏ: `import Foundation`, dọn closure cũ ở Day3 nếu còn

---

## Ghi chú thêm

- Buổi có thêm thảo luận lý thuyết: trailing closure cổ điển vs multiple trailing (`Button { } label: { }`)
- `onError` thay `onFailure` trong roadmap — chấp nhận, cùng pattern
- E-wallet flow: validate amount → callback message → payment complete → add transaction

---

## Next session

**Chủ đề tiếp theo:** Day 5 — Protocols, Extensions, Generics

- `protocol TransactionRepository { func getTransactions() -> [Transaction] }`
- `MockTransactionRepository: TransactionRepository` — mock data cho test/preview
- `extension Double { func asVND() -> String }` — thay/refactor helper format
- `struct ApiResponse<T> { let data: T }` — generic cơ bản
- Playground: `Day5-Protocols.playground` tại `projects/week1-swift-foundation/`
- Mental model: TypeScript `interface` + `implements` → Swift `protocol` + conformance

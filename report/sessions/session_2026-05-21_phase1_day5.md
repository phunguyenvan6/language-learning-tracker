# Session Report — 2026-05-21 — Protocols, Extensions, Generics

---

## Thông tin buổi học

- **Ngày:** 2026-05-21
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 5 — Protocols, Extensions, Generics
- **Thời lượng:** ~55 phút (GUIDE + thực hành + REVIEW + polish sau feedback)

---

## Mục tiêu buổi học

- [x] Khai báo `protocol TransactionRepository` — tách hợp đồng data khỏi implementation
- [x] `MockTransactionRepository` conform protocol, trả ≥ 3 transaction
- [x] `extension Double.asVND()` với `NumberFormatter`
- [x] `struct ApiResponse<T>` — generic wrapper
- [x] `printTransactionSummary(repository:)` — inject protocol, không phụ thuộc store cụ thể
- [x] Playground riêng `Day5-Protocols.playground`

---

## Những gì đã học

### Concept chính

- **Protocol** ≈ TypeScript `interface` — chỉ mô tả hành vi (`getTransactions()`)
- **Conformance** — `final class MockTransactionRepository: TransactionRepository`
- **Dependency injection** — hàm nhận `TransactionRepository`, truyền `MockTransactionRepository()` khi gọi
- **Extension** — thêm `asVND()` lên `Double`; `totalAmount` lên `[Transaction]` với `where Element == Transaction`
- **Generic** — `ApiResponse<T>` bọc `data` + `message?`; mock tạo `ApiResponse<[Transaction]>` trước khi return

### Code đã viết

Path: `projects/week1-swift-foundation/Day5-Protocols.playground/Contents.swift`

```swift
protocol TransactionRepository {
    func getTransactions() -> [Transaction]
}

final class MockTransactionRepository: TransactionRepository {
    func getTransactions() -> [Transaction] {
        let apiResponse = ApiResponse(data: [t1, t2, t3, t4, t5], message: "OK")
        print("API Items: \(apiResponse.data.count)")
        print(apiResponse.message ?? "")
        return apiResponse.data
    }
}

extension Double {
    func asVND() -> String { /* NumberFormatter */ }
}

extension Array where Element == Transaction {
    var totalAmount: Double { reduce(0) { $0 + $1.amount } }
}

func printTransactionSummary(repository: TransactionRepository) {
    let list = repository.getTransactions()
    print("Count: \(list.count)")
    list.forEach { tx in
        print("\(displayNote(tx.note)): \(tx.amount.asVND()) - \(tx.category.title)")
    }
    print("Total: \(list.totalAmount.asVND())")
}
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift |
|---|---|
| `interface TransactionRepository` | `protocol TransactionRepository` |
| `class MockRepo implements TransactionRepository` | `final class MockTransactionRepository: TransactionRepository` |
| Inject service qua props/context | Tham số `repository: TransactionRepository` |
| `type ApiResponse<T> = { data: T }` | `struct ApiResponse<T> { let data: T }` |
| Helper format tiền | `extension Double { func asVND() }` |

---

## Điểm đã hiểu rõ

- `printTransactionSummary(repository:)` — gọi qua protocol, sẵn sàng thay mock bằng API repo Day 6
- Mock bọc list qua `ApiResponse` — gần flow API thật (count + message + data)
- Dùng `asVND()` trong summary và `printNotes` — extension thay free function ở chỗ in UI
- Sau REVIEW: đổi `getTransactions()`, `import Foundation`, thêm `Array.totalAmount` + in Total
- Playground Day 5 tập trung protocol/extension — không kéo closure demo

---

## Điểm còn chưa chắc / cần ôn lại

- Protocol với `async throws` — Day 6 (`TransactionService.fetchTransactions()`)
- `TransactionStore` + global `t1`–`t5` vs mock data — hai nguồn; sau này mock nên self-contained
- Optional chaining method call — Day 2, chưa ôn riêng

---

## Exercise đã hoàn thành

- [x] `TransactionRepository` + `getTransactions()`
- [x] `MockTransactionRepository` — 5 tx, 3+ category
- [x] `extension Double.asVND()`
- [x] `ApiResponse<T>` + dùng trong mock
- [x] `printTransactionSummary(repository:)`
- [x] Stretch: `message`, `extension Array.totalAmount`, in Total
- [x] Đã qua REVIEW (**Pass**)

### Review feedback

- Vòng 1: Pass — góp ý `getTransactions` (plural), `import Foundation`, tách data mock/store
- Sau polish: **Pass** — đủ bắt buộc + stretch

---

## Ghi chú thêm

- `extension TransactionCategory.title` từ Day 3 — user nối tiếp tốt sang extension `Double` / `Array`
- Chuẩn bị Day 6: protocol sync → `async throws` trên service

---

## Next session

**Chủ đề tiếp theo:** Day 6 — Async/Await and Error Handling

- `enum TransactionError: Error` + `throws` validation (`validateAmount`)
- `do/try/catch`
- `protocol TransactionService { func fetchTransactions() async throws -> [Transaction] }`
- `MockTransactionService` + `Task { try await ... }`
- Playground: `Day6-AsyncAwait.playground` tại `projects/week1-swift-foundation/`
- Nối `TransactionRepository` (sync) sang service async — cùng domain e-wallet

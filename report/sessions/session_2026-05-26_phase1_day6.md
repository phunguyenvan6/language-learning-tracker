# Session Report — 2026-05-26 — Async/Await and Error Handling

---

## Thông tin buổi học

- **Ngày:** 2026-05-26
- **Phase:** Phase 1 — Swift Foundation
- **Day:** Day 6 — Async/Await and Error Handling
- **Thời lượng:** ~1 giờ (GUIDE + thực hành + REVIEW vòng 1 & 2)

---

## Mục tiêu buổi học

- [x] `enum TransactionError: Error` + `validateAmount(_:) throws`
- [x] `do/try/catch` xử lý lỗi đồng bộ và async
- [x] `protocol TransactionService` + `fetchTransaction` `async throws`
- [x] `MockTransactionService` — delay giả, validate từng amount, `store` nội bộ
- [x] `Task { try await ... }` — in Count + Total VND
- [x] Playground `Day6-AsyncAwait.playground`
- [x] Stretch: `LocalizedError`, `addTransaction(amount:note:category:)`, so sánh sync repo vs async service

---

## Những gì đã học

### Concept chính

- **`async` / `await`** ≈ `async function` / `await` trong TypeScript — suspend tại `fakeNetworkDelay()`
- **`throws` + `TransactionError`** ≈ Promise rejection / `throw new Error()` — enum type-safe hơn string
- **`do/try/catch`** — bắt `invalidAmount`, `emptyList`; dùng `errorDescription` qua `LocalizedError`
- **`Task { }`** — mở async context trong Playground (top-level không `await` trực tiếp)
- **Main Actor isolation** — tạo `service` trong `Task` để tránh warning data race
- **Hai tầng data:** sync `TransactionRepository.getTransactions()` vs async `TransactionService.fetchTransaction`

### Code đã viết

Path: `projects/week1-swift-foundation/Day6-AsyncAwait.playground/Contents.swift`

```swift
enum TransactionError: Error, LocalizedError {
    case invalidAmount, emptyList
    var errorDescription: String? { /* tiếng Việt */ }
}

protocol TransactionService {
    var store: [Transaction] { get }
    func fetchTransaction(_ hasError: Bool) async throws -> [Transaction]
    func addTransaction(amount:note:category:) async throws -> Transaction
}

final class MockTransactionService: TransactionService {
    func fetchTransaction(_ hasError: Bool) async throws -> [Transaction] {
        await fakeNetworkDelay()
        // emptyList hoặc validateAmount từng tx
        store = apiResponse.data
        return apiResponse.data
    }
    func addTransaction(...) async throws -> Transaction {
        try validateAmount(amount)
        // UUID + store.append
    }
}

Task {
    // SYNC vs ASYNC summary
    // do-catch 1: fetch OK, add OK, add(-1) → invalidAmount
    // do-catch 2: fetch(true) → emptyList
}
```

### Mapping React Native → Swift

| React Native / TypeScript | Swift |
|---|---|
| `async function fetch()` | `func fetchTransaction() async throws` |
| `await api.get()` | `try await service.fetchTransaction(false)` |
| `throw new Error('INVALID')` | `throw TransactionError.invalidAmount` |
| `catch (e) { e.message }` | `catch let error as TransactionError { error.errorDescription }` |
| Fire-and-forget | `Task { }` |
| Cache / local read sync | `repository.getTransactions()` |
| API layer async | `MockTransactionService` |

---

## Điểm đã hiểu rõ

- Tách **hai `do-catch`** cho `invalidAmount` và `emptyList` — tránh nhảy `catch` sớm làm test sau không chạy
- `try validateAmount(amount)` dùng chung trong fetch và add — một rule validation
- So sánh `--- SYNC ---` / `--- ASYNC ---` — thấy delay và khác count khi mock data khác nhau
- `LocalizedError` — message UI-ready, không hardcode string trong từng `catch`

---

## Điểm còn chưa chắc / cần ôn lại

- Đặt tên `fetchTransaction` vs `fetchTransactions` (plural convention)
- `Sendable` / `@MainActor` khi service dùng trong SwiftUI thật — Playground đã workaround bằng `Task` + tạo service trong block
- Gom code Day 1–6 rải rác vào một module — Day 7 `TransactionManager`

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày (không copy full solution)
- [x] Đã qua REVIEW (**Pass** — vòng 2 sau polish sync/async + tách `do-catch`)

### Review feedback

- **Vòng 1:** Pass với góp ý — `emptyList` không chạy trong cùng `do` với `add(-1)`; trùng `guard` vs `validateAmount`; chưa so sánh sync/async trong `Task`
- **Vòng 2:** **Pass** — đủ bắt buộc + toàn bộ stretch

---

## Ghi chú thêm

- Parameter `hasError` trên `fetchTransaction` — tiện demo Playground; production thường mock riêng hoặc stub network
- `t4` amount âm vẫn trong sync repo (5 tx) nhưng không nằm trong async fetch `[t1,t2,t3]` — cố ý để validate async path pass

---

## Next session

**Chủ đề tiếp theo:** Day 7 — Mini Project: Transaction Manager

- Gom `Transaction`, `TransactionCategory`, CRUD, filter, sort, `totalAmount`, `displayNote` / `displayAmount` / `asVND()`
- `Transaction` thêm `createdAt: Date`, `Identifiable` — chuẩn bị SwiftUI list
- Project/playground: `projects/week1-swift-foundation/` (module Swift thuần, có thể Playground hoặc file `.swift` gom)
- Hoàn thành Week 1 → Phase 2 SwiftUI Views & Layout

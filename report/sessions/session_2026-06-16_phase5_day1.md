# Session Report — 2026-06-16 — Repository, Store & Dependency Injection

## Thông tin buổi học

- **Ngày:** 2026-06-16
- **Phase:** Phase 5 — Architecture
- **Day:** Day 1 — Repository pattern, `TransactionStore`, tách business logic khỏi View, DI
- **Thời lượng:** ~3 giờ (ước tính, gồm stretch + REVIEW polish)

---

## Mục tiêu buổi học

- [x] Copy Week 4 → `projects/week5-architecture/TransactionFlow/`
- [x] `TransactionRepository` protocol + `InMemoryTransactionRepository`
- [x] `TransactionStore` với CRUD, filter/sort, `@MainActor`, repository inject
- [x] DI tại App root — `.environment(store)` thay `TransactionManager`
- [x] Refactor `HomeView`, `AddTransactionView`, `TransactionDetailView`, `AppRouterView`
- [x] Fix empty state 2 nhánh (chưa có data vs filter không match)
- [x] Stretch: `applyFilter()`, `clearFilter()`, `private(set) appliedFilter`, `previewSeeded()`
- [x] Xoá `TransactionManager` khỏi Week 5
- [x] REVIEW Pass

---

## Những gì đã học

### Concept chính

**3-layer architecture:**

```text
View (HomeView)        → UI + user action
Store (TransactionStore) → state + business logic (filter, sort, CRUD)
Repository             → data source (memory / API / DB sau này)
```

**Repository pattern:**
- `TransactionRepository` protocol định nghĩa contract: `fetchAll`, `save`, `update`, `delete`
- `InMemoryTransactionRepository` — impl đầu tiên, giữ array trong RAM
- View/Store không biết data lưu ở đâu — swap impl sau này không đổi UI

**Store pattern:**
- `@Observable @MainActor final class TransactionStore`
- Repository inject qua `init(repository:)` — không hardcode `InMemory...()` bên trong Store
- `private(set) var transactions` — View đọc, Store ghi
- Mỗi mutation (`add`, `delete`, `update`) gọi `load()` sync cache từ repository

**Filter ownership chuyển sang Store:**
- `displayedTransactions` computed — sort + filter logic rời khỏi `HomeView`
- `private(set) var appliedFilter` — mutation chỉ qua `applyFilter()` / `clearFilter()`
- `draftFilter` vẫn ở Router (`@State`) — UI draft trong sheet, không thuộc Store

**Dependency Injection:**
```swift
@State private var store = TransactionStore(repository: InMemoryTransactionRepository())
AppRouterView().environment(store)
```
≈ RN: Provider inject store xuống component tree.

### Code patterns quan trọng

**Store filter actions (encapsulation):**
```swift
func applyFilter(_ filter: TransactionFilter) {
    appliedFilter = filter
}

func clearFilter() {
    appliedFilter = .empty
}
```

**Router gọi action, không mutate trực tiếp:**
```swift
onApply: { store.applyFilter(draftFilter) }
onClear: { draftFilter = .empty; store.clearFilter() }
```

**Empty state 2 nhánh (fix bug Phase 4):**
```swift
if store.isEmpty { /* Chưa có giao dịch */ }
else if store.displayedTransactions.isEmpty { /* Không có kết quả */ }
else { ForEach(store.displayedTransactions) { ... } }
```

**Preview helper:**
```swift
extension TransactionStore {
    static func previewSeeded() -> TransactionStore { ... }
}
```

### Mapping ngôn ngữ cũ → mới

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| Zustand / Redux store | `@Observable TransactionStore` |
| `interface` Repository | `protocol TransactionRepository` |
| Mock API module | `InMemoryTransactionRepository` |
| `Context.Provider` + `useContext` | `.environment(store)` + `@Environment(TransactionStore.self)` |
| Store actions (`clearFilter`) | `func clearFilter()` trên Store |
| `useMemo` filter trong component | `displayedTransactions` computed trên Store |
| React Query cache refresh | `load()` sau mỗi repository write |

---

## Điểm đã hiểu rõ

- Phân vai View vs Store vs Repository — View không filter inline nữa
- `@State` ở App giữ owner Store — tránh tạo instance mới mỗi re-render
- `draftFilter` (Router) vs `appliedFilter` (Store) — draft/applied pattern giữ nguyên từ Phase 4, chỉ đổi owner applied
- `private(set)` + action methods — encapsulation filter state
- Migration path: copy Week 4 project, refactor từng View, xoá `TransactionManager` cuối cùng

---

## Điểm còn chưa chắc / cần ôn lại

- Khi nào nên tách thêm `HomeStore` riêng vs gom vào `TransactionStore` — chưa gặp case Store quá lớn
- `load()` sync sau mỗi write — pattern này đổi thế nào khi repository thành `async` (Phase 6)
- `seedSampleTransactions()` vẫn trong `HomeView` — chưa chuyển sang App bootstrap

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày (không copy solution)
- [x] Đã qua REVIEW (**Pass**)

### Code

Project: `projects/week5-architecture/TransactionFlow/`

| File | Thay đổi chính |
|---|---|
| `data/TransactionRepository.swift` | Protocol CRUD |
| `data/InMemoryTransactionRepository.swift` | In-memory impl + validate |
| `stores/TransactionStore.swift` | Store mới — CRUD, filter, actions |
| `TransactionFlowApp.swift` | Inject Store + Repository |
| `navigation/AppRouterView.swift` | `applyFilter` / `clearFilter`, bỏ local `appliedFilter` |
| `features/home/HomeView.swift` | View mỏng, 2 empty state, `isFilterActive` |
| `features/transaction/AddTransactionView.swift` | `store.add(...)` |
| `features/transaction/TransactionDetailView.swift` | `store.transaction(id:)` |
| `models/TransactionManager.swift` | **Đã xoá** |

### Review feedback

| Issue | Kết quả |
|---|---|
| `appliedFilter` public writable | ✅ Fixed — `private(set)` |
| `displayedTransaction` naming | ✅ Fixed — `displayedTransactions` |
| `isFilterActive` unused | ✅ Fixed — dùng trong Badge |
| Build compile | ✅ BUILD SUCCEEDED |

---

## Ghi chú thêm

- Filter sheet logic duplicate giữa `AppRouterView` và `HomePreviewShell` — chấp nhận tạm cho previews
- Week 5 project path thực tế: `projects/week5-architecture/TransactionFlow/` (không nested `TransactionAppRefactor/`)

---

## Next session

**Chủ đề tiếp theo:** Phase 5 Day 2 — `Loadable` state, pure filter function (testable), chuẩn bị async repository

- Intro `enum Loadable<Value> { idle, loading, loaded, failed }` trên Store
- Extract filter logic thành pure function (vd. `TransactionFiltering.apply(_:to:)`)
- Optional: `filterBadgeCount` trên Store để View không đọc `appliedFilter` trực tiếp
- Bridge sang Phase 6: repository method `async throws` + `load()` async

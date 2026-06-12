# Session Report — 2026-06-12 — Sheet, Filter Flow & Add Form Port

## Thông tin buổi học

- **Ngày:** 2026-06-12
- **Phase:** Phase 4 — Navigation & App Structure
- **Day:** Day 2 — `sheet`, filter sheet, port add form, `sheet(item:)`, `fullScreenCover`
- **Thời lượng:** ~3 giờ (ước tính, gồm stretch)

---

## Mục tiêu buổi học

- [x] `sheet(isPresented:)` → refactor sang `sheet(item:)` với `HomeSheet`
- [x] Filter sheet: category, from/to date, Áp dụng / Xoá lọc / Huỷ
- [x] Home list filter theo `appliedFilter` + empty state
- [x] Port form từ `AddTransactionForm` vào `AddTransactionView`
- [x] Add flow chuyển từ stack push sang sheet
- [x] REVIEW Pass (sau fix `toDate` + layout form)

---

## Những gì đã học

### Concept chính

**Sheet vs stack push:**
- Detail = stack push (`path.append`) — flow đi sâu, có back stack
- Filter / Add = sheet — task tạm thời, dismiss bằng swipe hoặc nút
- Add không còn `AppRoute.addTransaction` — chỉ còn `.transactionDetail` trên stack

**`sheet(item:)` — discriminated union modal state:**
```swift
enum HomeSheet: Identifiable {
    case filter
    case add
    var id: String { ... }
}

@State private var activeSheet: HomeSheet? = nil

.sheet(item: $activeSheet) { sheet in
    switch sheet {
    case .filter: FilterSheetView(...)
    case .add: NavigationStack { AddTransactionView() }
    }
}
```
≈ RN: `type Modal = null | 'filter' | 'add'` thay vì nhiều `useState<boolean>`.

**Filter draft vs applied:**
- `draftFilter` — chỉnh trong sheet
- `appliedFilter` — áp lên Home list
- `.onChange(of: activeSheet)` copy `appliedFilter → draftFilter` khi mở filter
- Router owns filter state; HomeView nhận `applyFilter` read-only

**`fullScreenCover(item:)` — layer presentation thứ hai:**
- `AppCover.onboarding` tách khỏi `HomeSheet` — không mix modifier
- Full screen, không swipe dismiss — cần nút "Bắt đầu"
- DEBUG toolbar button `#if DEBUG` only

**Port form Week 3:**
- Copy `AppTheme`, `AmountTextField`, `CategoryPicker`, `DatePickerCustom`, color assets
- `submit()` → `manager.add` → `dismiss()` trong sheet context

### Code patterns quan trọng

**Router owns presentation + filter state (`AppRouterView`):**
```swift
@State private var activeSheet: HomeSheet? = nil
@State private var activeCover: AppCover? = nil
@State private var draftFilter = TransactionFilter.empty
@State private var appliedFilter = TransactionFilter.empty
```

**Filter logic trên HomeView (computed):**
```swift
private var displayedTransaction: [Transaction] {
    var result = manager.sortByNewest()
    // category, fromDate (>=), toDate (<=)
    return result
}
```

**FilterSheetView `bindingDate` helper** — bridge `Date?` ↔ `Date` cho DatePicker.

### Mapping React Native → SwiftUI

| React Native / TypeScript | Swift / SwiftUI |
|---|---|
| `Modal visible={showFilter}` | `.sheet(isPresented:)` / `sheet(item:)` |
| `modal: 'filter' \| 'add' \| null` | `HomeSheet?` + `switch` |
| `presentation: 'fullScreenModal'` | `.fullScreenCover(item:)` |
| Filter draft state vs applied | `draftFilter` / `appliedFilter` |
| Form modal submit + close | `manager.add` + `@Environment(\.dismiss)` |
| Bottom sheet task flow | `.sheet` + optional `.presentationDetents` |

---

## Điểm đã hiểu rõ

- Sheet và stack là **hai layer độc lập** — filter không push route lên `path`
- `sheet(item:)` scale tốt hơn nhiều Bool khi có ≥2 modal
- `AppCover` tách enum riêng vì modifier khác (`fullScreenCover` vs `sheet`)
- Router owns modal state; screens báo intent qua callback — nhất quán Day 1
- Filter date: `from` dùng `>=`, `to` dùng `<=` (đã fix sau review v1)
- `@Environment` flow vào sheet vì sheet attach dưới view có `.environment(manager)`

---

## Điểm còn chưa chắc / cần ôn lại

- **Empty state 2 nhánh** — đã thử thêm "Không có kết quả" nhưng cả hai nhánh đều check `displayedTransaction.isEmpty` → nhánh thứ 2 dead code; cần `manager.transactions.isEmpty` vs `displayedTransaction.isEmpty && !manager.transactions.isEmpty`
- **Filter logic trong View** — OK cho Day 2; Phase 5 sẽ tách vào `TransactionStore`
- **`bindingDate` set optional** — chọn ngày luôn set non-nil; chưa có cách "clear date" riêng trong sheet

---

## Exercise / Project đã làm

- [x] Đã tự làm bài tập cuối ngày
- [x] REVIEW Pass (vòng 2 sau fix `toDate` + VStack form layout)

### Project structure (cập nhật)
```text
projects/week4-navigation/TransactionFlow/TransactionFlow/
├── TransactionFlowApp.swift
├── navigation/
│   ├── AppRoute.swift              (chỉ .transactionDetail)
│   └── AppRouterView.swift         (sheet + fullScreenCover + filter state)
├── features/
│   ├── home/
│   │   ├── HomeView.swift
│   │   ├── HomeSheet.swift
│   │   ├── FilterSheetView.swift
│   │   └── TransactionFilter.swift
│   ├── transaction/
│   │   ├── AddTransactionView.swift
│   │   ├── TransactionDetailView.swift
│   │   └── components/             (AmountTextField, CategoryPicker, DatePickerCustom)
│   └── onboarding/
│       ├── AppCover.swift
│       └── OnboardingView.swift
├── components/Badge.swift
├── themes/AppTheme.swift
└── models/
```

### Stretch đã làm
- `Badge(count:)` trên filter icon khi active
- Previews: FilterSheetView (3), AddTransactionView (2), HomePreviewShell (4)
- `withAnimation(.snappy)` khi apply/clear filter
- `sheet(item:)` refactor (gộp filter + add)
- `fullScreenCover(item:)` + Onboarding DEBUG flow
- `Badge` reusable component
- Cleanup: `AppRoute.home` removed, `ContentView` scaffold gone

### Review feedback
| Issue | Kết quả |
|---|---|
| `toDate` filter dùng `>=` thay vì `<=` | ✅ Fixed |
| Thiếu empty state khi filter không match | ⚠️ Partial — dead code branch, cần fix nhánh |
| AddTransactionView layout TupleView | ✅ Fixed — VStack wrapper |
| Dead code `isAddPresented`, `didSeedDemo` | ✅ Removed |

---

## Ghi chú thêm

- Swift argument order: param có default (`onOpenOnboarding`) phải đứng trước param bắt buộc (`applyFilter`) khi khai báo struct — gọi site phải label đúng thứ tự
- Micro-step 4 fullScreenCover giúp cảm nhận rõ UX khác sheet (no swipe dismiss)
- Phase 4 navigation topics core đã cover; Exercise 3 roadmap (`TransactionStore`) thuộc Phase 5

---

## Next session

**Chủ đề tiếp theo:** Phase 5 Day 1 — Architecture: `TransactionStore`, tách filter/business logic khỏi View, feature folder refinement

- Extract `TransactionStore` / ViewModel từ `TransactionManager` usage trong views
- Move filter logic từ `HomeView` computed → store method
- Repository pattern intro, dependency injection cơ bản
- Fix empty state 2 nhánh trước hoặc trong refactor

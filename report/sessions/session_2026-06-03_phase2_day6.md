# Session Report — 2026-06-03 — Week 2 Wrap-up: List, Row Polish & Layout Comparison

---

## Thông tin buổi học

- **Ngày:** 2026-06-03
- **Phase:** Phase 2 — SwiftUI Views & Layout
- **Day:** Day 6 — Wrap-up roadmap Week 2 (phần còn thiếu)
- **Thời lượng:** ~2.5 giờ (GUIDE + implement + REVIEW vòng 1 Pass với góp ý + polish + REVIEW vòng 2 **Pass**)

---

## Mục tiêu buổi học

- [x] Polish `BalanceCard` — contrast text/badge trên gradient (Light/Dark)
- [x] `TransactionRowView` đủ field Exercise 2: icon, title, note, amount, date
- [x] `TransactionCategory.systemImage` — SF Symbol theo category
- [x] Rename `createAt` → `createdAt` đồng bộ model/manager/previews
- [x] `displayDate` + stretch `displayRelativeDate` (`RelativeDateTimeFormatter`, `vi_VN`)
- [x] Tách `TransactionListSection` — dùng chung LazyVStack và List
- [x] So sánh `ScrollView + LazyVStack` vs `List` (`scrollLayout` / `nativeListLayout`)
- [x] `onRefresh` gọi seed thật khi list empty + `listRevision`
- [x] Previews: Có giao dịch / Empty / Dark / Native List + previews section riêng

---

## Những gì đã học

### Concept chính

- **Exercise 2 row layout:** `HStack` 3 cột (icon | title+note | amount+date) — tương đương RN list item custom, không dùng default `List` cell.
- **`embedInList`:** Cùng `Section` nhưng title ở `header:` (LazyVStack) vs row đầu (List) — vì `List` render `Section` header kiểu UITableView (font/inset khác design tự define).
- **`ewalletPlainListRow()`:** `.listRowInsets`, `.listRowSeparator(.hidden)`, `.listRowBackground(.clear)` — làm List giống spacing LazyVStack.
- **Hai root scroll:** Không lồng `List` trong `ScrollView`; toggle `useNativeList` chọn `scrollLayout` hoặc `nativeListLayout`.
- **Bảng so sánh trong code:** Khi nào home dùng ScrollView+LazyVStack (UI custom, banner, card) vs List (swipe, edit, refreshable sau này).
- **`useNativeList` qua init:** Preview-driven (`#Preview("Native List")`) thay vì `@State` kẹt false.
- **`Group`:** Switch layout + gom `homeTopContent` không thêm spacing.

### Code đã viết

```swift
// ContentView — hai layout + ghi chú so sánh
struct ContentView: View {
    var shouldSeedOnAppear: Bool = false
    var useNativeList: Bool = false
    // scrollLayout: ScrollView + LazyVStack + TransactionListSection(embedInList: false)
    // nativeListLayout: List { homeTopContent row; TransactionListSection(embedInList: true) }
}

// TransactionListSection — embedInList
Section {
    if embedInList { sectionTitle.ewalletPlainListRow() }
    // empty / ForEach rows...
} header: {
    if !embedInList { sectionTitle }
}

// Transaction — relative date (stretch)
var displayRelativeDate: String {
    Self.relativeDateFormatter.localizedString(for: createdAt, relativeTo: Date())
}
```

### Mapping React Native → SwiftUI

| React Native | Swift/SwiftUI Day 6 |
|---|---|
| Custom list row component | `TransactionRowView` + category `systemImage` |
| `FlatList` vs `SectionList` | `LazyVStack+ForEach` vs `List+Section` |
| `moment().fromNow()` | `RelativeDateTimeFormatter` → `displayRelativeDate` |
| Fragment wrapper | `Group { if useNativeList { ... } }` |
| `key` force list remount | `.id(listRevision)` (giữ đến Phase 3) |
| Pull-to-refresh placeholder | `onRefresh` → `seedSampleTransactions()` khi empty |

---

## Điểm đã hiểu rõ

- Vì sao `List` section header khác `Text` trong `LazyVStack` — và cách workaround `embedInList`.
- Một `TransactionListSection` tái sử dụng cho cả hai layout — tránh duplicate ForEach/empty logic.
- Preview phải khớp tên: `shouldSeedOnAppear: true` cho “Có giao dịch”, `useNativeList: true` cho Native List.
- `listRevision` vẫn cần với `@State` + `class` manager — Phase 3 sẽ thay bằng `@Observable`.

---

## Điểm còn chưa chắc / cần ôn lại

- `listRevision` — workaround, bỏ ở Phase 3 Day 1.
- `TextField` / `Toggle` / `Picker` — chưa học (đúng roadmap → Phase 3 form).
- Swipe delete / `.refreshable` trên `List` — chưa làm (Phase 3–4).

---

## Exercise / Project đã làm

- [x] Day 6 bài tập cuối ngày (yêu cầu + stretch)
- [x] REVIEW vòng 1: Pass với góp ý (preview seed, ghi chú List vs LazyVStack, Native List preview)
- [x] REVIEW vòng 2: **Pass** sau polish

### Deliverables

- `ContentView.swift` — dual layout, MARK comparison table, previews, `onRefresh` seed
- `TransactionListSection.swift` — `embedInList`, `ewalletPlainListRow()`, 5 previews
- `TransactionRowView.swift` — full row + `displayRelativeDate`
- `TransactionCategory.swift` — `systemImage`
- `Transaction.swift` — `createdAt`, `displayDate`, `displayRelativeDate`
- `BalanceCard.swift` — contrast polish

### Review feedback (tóm tắt)

- **Vòng 1:** Pass với góp ý — preview “Có giao dịch” default không seed; thiếu bảng so sánh; `useNativeList` không bật từ preview.
- **Vòng 2:** **Pass** — bảng MARK đầy đủ, previews Native List + section, `displayRelativeDate`; nitpick: `embedInList: false` literal trong `scrollLayout`, optional row padding dọc.

---

## Ghi chú thêm

- **Phase 2 / Week 2 hoàn thành** — EWallet home đủ roadmap: header, balance, quick actions, banner, list, empty, List vs LazyVStack documented.
- Build Xcode **succeeded** trên simulator iPhone 17.

---

## Next session

**Chủ đề tiếp theo:** Phase 3 Day 1 — SwiftUI State & Data Flow (`@Observable`, bỏ `listRevision`)

**Gợi ý cụ thể:**

1. Refactor `TransactionManager` với `@Observable` — UI cập nhật khi mutate `transactions`.
2. Project mới hoặc feature: `AddTransactionForm` — `TextField`, `Picker`/`Toggle`, `@Binding`, validation.
3. Wiring refresh/seed không cần bump `listRevision`.

**Project:** `projects/week3-state-data-flow/AddTransactionForm/` (theo roadmap) hoặc mở rộng `EWalletHomeScreen` trước khi tách.

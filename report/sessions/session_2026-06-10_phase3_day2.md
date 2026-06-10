# Session Report — 2026-06-10 — @Binding, Form & Validation

---

## Thông tin buổi học

- **Ngày:** 2026-06-10
- **Phase:** Phase 3 — SwiftUI State & Data Flow
- **Day:** Day 2 — `@Binding`, controlled form, validation, submit
- **Thời lượng:** ~3.5 giờ (GUIDE + implement + Q&A validation/preview + REVIEW ×3 → **Pass**)

---

## Mục tiêu buổi học

- [x] Parent owns form state (`@State`); child components dùng `@Binding`
- [x] `TextField`, `Picker`, `DatePicker` — controlled inputs
- [x] Validation: `parsedAmount` computed + `errorMessage` on submit
- [x] Submit → `try manager.add(...)` → reset form → `@Observable` refresh count
- [x] Extract `AmountTextField`, `CategoryPicker`, `DatePickerCustom`
- [x] Stretch: success banner, `submitting`, preview seeded, `@Previewable` child previews
- [x] REVIEW **Pass** (sau polish `createdAt`, `isFormValid`, `note` nil)

---

## Những gì đã học

### Concept chính

- **`@Binding`:** Two-way link từ parent `@State` xuống child — `$amountText` tạo `Binding<String>`. Child khai báo `@Binding var text: String`, không `@State`.
- **Controlled form:** `amountText` giữ `String` (TextField chỉ bind String); parse `Double?` lúc validate/submit — tương đương RN `useState("")` + `parseFloat` on submit.
- **Validation hai lớp:** `isFormValid` (computed, disable nút) vs `errorMessage` (set trong `submit()`, hiển thị lỗi cụ thể).
- **Local form state vs store:** Form fields là `@State` local; chỉ khi submit mới ghi vào `@Observable TransactionManager`.
- **Preview `@Binding`:** `@Previewable @State` trong `#Preview` đóng vai parent; hoặc `init(manager:)` + `previewSeeded()` cho ContentView.
- **`.onChange(of:)`:** Auto-hide success banner sau 2s — pattern `useEffect` dependency trong RN.
- **`init(manager:)` + `_manager = State(initialValue:)`:** Inject store cho preview/test.

### Code đã viết

```swift
// Parent — owns state, passes bindings
@State private var amountText = ""
@State private var category: TransactionCategory = .food

AmountTextField(text: $amountText)
CategoryPicker(selection: $category)

private var parsedAmount: Double? {
    Double(amountText.trimmingCharacters(in: .whitespaces))
}

private var isFormValid: Bool {
    guard let amount = parsedAmount else { return false }
    return amount > 0
}

// Child — @Binding only
struct AmountTextField: View {
    @Binding var text: String
    // TextField("0", text: $text)
}

// Submit → store
try manager.add(
    amount: amount,
    note: note.isEmpty ? nil : note,
    category: category,
    createdAt: createdAt
)
```

```swift
// Preview binding
#Preview {
    @Previewable @State var amountText = "50000"
    AmountTextField(text: $amountText).padding()
}

// Preview seeded manager
#Preview("Seeded — 3 giao dịch") {
    ContentView(manager: .previewSeeded())
}
```

### Mapping React Native → SwiftUI

| React Native | Swift/SwiftUI Day 2 |
|---|---|
| `useState("")` + `TextInput value/onChangeText` | `@State` + `TextField(..., text: $field)` |
| Controlled child props | `@Binding var field` |
| `parseFloat` / `isNaN` | `Double(string)` → `Double?` (`nil` = invalid) |
| `error` state + disabled button | `errorMessage` + `.disabled(!isFormValid)` |
| `dispatch(addTransaction)` | `try manager.add(...)` |
| Mock store in Storybook | `init(manager:)` + `previewSeeded()` |
| `useEffect([flag], () => timeout)` | `.onChange(of: didSubmitSuccessfully)` + `Task.sleep` |

---

## Điểm đã hiểu rõ

- Vì sao amount là `String` trên UI, `Double?` khi validate — TextField không bind số trực tiếp.
- Khác nhau `isFormValid` (realtime disable) vs `errorMessage` (feedback khi submit fail).
- `$` chỉ khi **truyền** binding; `@Binding` khi **nhận** ở child.
- `@Previewable @State` cho preview component có `@Binding`.
- Sau REVIEW: sửa `createdAt: createdAt` trong manager, align `isFormValid` với `amount > 0`.

---

## Điểm còn chưa chắc / cần ôn lại

- `@Bindable` vs `@Binding` vs `@State` khi child cần gọi method trên `@Observable` — **Day 3+**.
- `@Environment` inject `TransactionManager` thay vì `@State` ở root — **Day 3**.
- Khi nào dùng `.task` vs `.onAppear` — **Day 3**.

---

## Exercise / Project đã làm

- [x] Day 2 bài tập bắt buộc (REVIEW **Pass**)
- [x] Stretch: DatePicker, success banner, submitting, previews
- [x] Build succeeded: `AddTransactionForm`

### Deliverables

**`AddTransactionForm/`**
- `ContentView.swift` — form đầy đủ, submit, validation, success UX
- `views/AmountTextField.swift` — `@Binding` + `@FocusState` + focus styling
- `views/CategoryPicker.swift` — `Picker` + `CaseIterable` + `formField()`
- `views/DatePicker.swift` — `DatePickerCustom` + `@Binding Date`
- `models/TransactionManager.swift` — sync overload `createdAt`, `previewSeeded()`
- `models/TransactionCategory.swift` — `CaseIterable`
- `theme/AppTheme.swift` — `FormFieldModifier`, `PrimaryButtonStyle`

### Review feedback (tóm tắt)

- **v1:** Pass với góp ý — `createdAt` bug, `isFormValid` thiếu `> 0`, `note` nên `nil`.
- **v2–v3:** **Pass** — tất cả góp ý đã polish.

---

## Ghi chú thêm

- Buổi GUIDE Bước 3 (validation state) cần giải thích sâu hơn — đã Q&A riêng về `parsedAmount`, `isFormValid`, `errorMessage`.
- Đã học preview pattern trong cùng buổi (binding + seeded manager).
- `.onChange` dùng cho success banner — preview một phần lifecycle roadmap Day 3.

---

## Next session

**Chủ đề tiếp theo:** Phase 3 Day 3 — `@Environment`, inject `TransactionManager`, `.task` / `.onAppear`, hiển thị transaction list dưới form

**Gợi ý cụ thể:**

1. Mở `AddTransactionFormApp.swift` — inject manager qua `.environment(manager)`
2. `ContentView` đọc `@Environment(TransactionManager.self)` thay vì `@State private var manager`
3. Thêm section list giao dịch (`ForEach(manager.sortByNewest())`) dưới form — tái dùng row pattern Week 2
4. `.task` hoặc `.onAppear` nếu cần seed demo data (optional)
5. Ôn `.onChange` — đã dùng cho banner; Day 3 mở rộng react-to-field changes

**Project:** `AddTransactionForm` (Week 3)

# Session Report -- 2026-06-01 -- SwiftUI Image, Button & Design Tokens

---

## Thong tin buoi hoc

- **Ngay:** 2026-06-01
- **Phase:** Phase 2 -- SwiftUI Views & Layout
- **Day:** Day 3 -- `Image`, `Button`, Quick Actions, Design Tokens (Light/Dark)
- **Thoi luong:** ~1.5 gio

---

## Muc tieu buoi hoc

- [x] Dung `Image(systemName:)` (SF Symbols) trong UI action
- [x] Dung `Button` voi closure `action` (callback pattern)
- [x] Tao `QuickActionsRow` voi 4 nut: Nap tien, Chuyen tien, QR, Thanh toan
- [x] Style nhat quan qua component `QuickActionButton` + `isProminent` cho QR
- [x] Thiet lap design tokens (`AppTheme` + Color Sets Light/Dark)
- [x] Refactor views hien co dung token thay hard-code mau
- [x] Preview Light/Dark cho man hinh va quick actions

---

## Nhung gi da hoc

### Concept chinh

- `Button` trong SwiftUI tuong duong `TouchableOpacity` + `onPress` trong RN; closure truyen qua props nhu callback.
- `@escaping () -> Void` trong `init` khi luu closure de goi sau (Swift ownership rules).
- `.buttonStyle(.plain)` de custom layout button ma khong bi chrome mac dinh iOS.
- `Image(systemName:)` dung SF Symbols -- khong can asset image rieng cho icon co san.
- Semantic colors: `Color("token.name")` trong Assets tu dong doi theo Light/Dark.
- `AppColor` / `AppSpacing` / `AppTypography` gom token tap trung -- giong design tokens trong RN theme.
- Contrast tren gradient/brand background: uu tien mau sang (`.white`) hoac token `onBrand`, khong dung `text.primary` tren nen brand.

### Code da viet

```swift
struct QuickActionButton: View {
    let title: String
    let systemImage: String
    let isProminent: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: AppSpacing.xs) {
                Image(systemName: systemImage)
                    .foregroundStyle(isProminent ? .white : AppColor.brandPrimary)
                    .frame(width: 52, height: 52)
                    .background {
                        if isProminent {
                            Circle().fill(AppColor.brandPrimary)
                        }
                    }
                Text(title)
                    .foregroundStyle(AppColor.textPrimary)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
    }
}
```

```swift
// AppTheme.swift -- token entry point
enum AppColor {
    static let bgPrimary = Color("bg.primary")
    static let brandPrimary = Color("brand.primary")
    // ...
}
```

### Mapping React Native -> SwiftUI

| React Native | Swift/SwiftUI |
|---|---|
| `TouchableOpacity` + `onPress` | `Button(action:) { label }` |
| Callback prop `onPress: () => void` | `let action: () -> Void` + `@escaping` |
| `flex: 1` trong row | `.frame(maxWidth: .infinity)` tren tung item |
| Theme colors (`theme.colors.primary`) | `Color("brand.primary")` qua `AppColor` |
| `accessibilityLabel` | `.accessibilityLabel(title)` |
| Icon tu thu vien (vector) | `Image(systemName:)` SF Symbols |

---

## Diem da hieu ro

- Tach `QuickActionButton` / `QuickActionsRow` -- component composition giong RN.
- Khi nao dung `.buttonStyle(.plain)` cho custom button UI.
- Tao Color Set `Any, Dark` trong Assets va goi qua `AppColor`.
- Fix contrast sau REVIEW: `bg.primary` full screen, icon QR prominent, badge VIB co `foregroundStyle`.
- Test theme bang `#Preview` + `.preferredColorScheme(.dark)`.

---

## Diem con chua chac / can on lai

- Token `text.primaryWhite` trong Assets: semantic chua ro (nen doi ten `text.onBrand` hoac giu trang o ca Dark).
- `print(...)` trong action chi la placeholder -- Day 4+ se thay bang navigation/state.
- Chua co `ScrollView` khi noi dung dai -- can cho Day 4.
- Chua `List` / `ForEach` cho nhieu giao dich -- du kien buoi sau.

---

## Exercise da hoan thanh

- [x] Tu lam bai tap cuoi ngay (khong copy full solution)
- [x] Da qua REVIEW (Pass -- vong 2 sau khi sua feedback)

### Deliverables

- `QuickActionButton.swift`, `QuickActionsRow.swift`
- `theme/AppTheme.swift`
- Color Sets: `bg.primary`, `bg.card`, `text.primary`, `text.secondary`, `text.primaryWhite`, `brand.primary`, `brand.secondary`, `accent.success`
- Cap nhat: `ContentView`, `HeaderView`, `BalanceCard`, `TransactionRowView`

### Review feedback (tom tat)

- **Vong 1:** Pass voi gop y -- thieu `bg.primary`, `text.primaryWhite` Dark sai, badge thieu mau chu.
- **Vong 2:** Pass -- da them `.background(AppColor.bgPrimary.ignoresSafeArea())`, QR dung `.white`, BalanceCard chu tren gradient dung `.white`, badge co `foregroundStyle`.

---

## Ghi chu them

- Buoi nay lam them design system som hon roadmap (Phase 8) -- huu ich, nhung nen chuan hoa ten token (`onBrand`) de tranh nham semantic.
- Gap Xcode Source Control loi repo con -- khong anh huong code Day 3.

---

## Next session

**Chu de tiep theo:** Phase 2 Day 4 -- `ScrollView` + Promotion Banner (hoac wrap home screen scrollable), chuan bi layout cho danh sach giao dich nhieu item.

**Goi y cu the:**

- Boc `ContentView` body trong `ScrollView` khi content vuot man hinh
- Tao `PromotionBannerView` (image/text CTA don gian)
- Giu dung `AppColor` / `AppSpacing` -- khong hard-code mau moi

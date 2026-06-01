# Session Report -- 2026-06-01 -- ScrollView, Promotion Banner & LazyVStack

---

## Thong tin buoi hoc

- **Ngay:** 2026-06-01
- **Phase:** Phase 2 -- SwiftUI Views & Layout
- **Day:** Day 4 -- `ScrollView`, `PromotionBannerView`, `ForEach` list + stretch (`LazyVStack`, props, `ZStack`, `UnevenRoundedRectangle`)
- **Thoi luong:** ~2.5 gio (gom REVIEW vong 1-3 + stretch LazyVStack)

---

## Muc tieu buoi hoc

- [x] Boc home screen trong `ScrollView` khi noi dung dai
- [x] Tao `PromotionBannerView` (anh + copy + CTA) dung design tokens
- [x] `ForEach` hien thi nhieu giao dich (scroll doc)
- [x] Thu tu section: Quick actions -> Banner -> Giao dich
- [x] **Stretch:** Props cho banner, `ZStack` overlay, `LazyVStack` + `Section`, test 40 items
- [x] **Stretch:** `pinnedViews: [.sectionHeaders]` cho sticky section header

---

## Nhung gi da hoc

### Concept chinh

- `ScrollView` = container scroll doc; nen `bg.primary` dat **ngoai** scroll, khong scroll theo content.
- Anh banner: `.resizable()` + `.scaledToFill()` + `.clipped()` + `frame(maxWidth: .infinity)` -- tranh tran ngang (tuong duong `resizeMode="cover"`).
- `PromotionBannerView` tach component; props `title`, `description`, `ctaTitle` (stretch).
- `ZStack` tren anh cho badge "Thoi gian co han"; `UnevenRoundedRectangle(bottomTrailingRadius:)` bo **mot goc**.
- `VStack` cho phan co dinh (header, balance, quick actions, banner) + `LazyVStack` cho list -- pattern chuan truoc list dai.
- `LazyVStack` + `Section { ForEach } header: { }` + `pinnedViews: [.sectionHeaders]` -- header section co the dinh khi scroll.
- `appShadow(AppShadow.card)` va extension `View.appShadow` -- token shadow tai su dung.
- `AppColor.bgCard` cho footer banner (Dark mode semantic, khong hard-code `.white`).

### Code da viet

```swift
ScrollView {
    VStack(alignment: .leading, spacing: AppSpacing.md) {
        HeaderView(name: "Phu")
        BalanceCard(balance: 15_000_000)
        QuickActionsRow()
        PromotionBannerView(
            title: "Hoan tien den 5%",
            description: "Thanh toan hoa don qua VIB Wallet",
            ctaTitle: "Xem ngay"
        )
        LazyVStack(alignment: .leading, spacing: AppSpacing.sm,
                   pinnedViews: [.sectionHeaders]) {
            Section {
                ForEach(sampleTransactions) { tx in
                    TransactionRowView(transaction: tx)
                }
            } header: {
                Text("Giao dich gan day:")
                    .font(AppTypography.headline)
            }
        }
    }
    .padding(.horizontal, AppSpacing.lg)
}
.background(AppColor.bgPrimary.ignoresSafeArea())
```

```swift
// PromotionBannerView -- props + ZStack badge
ZStack(alignment: .topLeading) {
    Image("banner")
        .resizable()
        .scaledToFill()
        .clipped()
        .frame(height: bannerHeight)
        .frame(maxWidth: .infinity)
    Text("Thoi gian co han")
        .background(
            UnevenRoundedRectangle(bottomTrailingRadius: AppRadius.card)
                .fill(AppColor.bgCard)
        )
}
```

### Mapping React Native -> SwiftUI

| React Native | Swift/SwiftUI |
|---|---|
| `ScrollView` + `contentContainerStyle` | `ScrollView { VStack/LazyVStack }.padding(...)` |
| `resizeMode="cover"` | `.scaledToFill()` + `.clipped()` |
| `map` + `key` | `ForEach(items)` (`Identifiable`) |
| `FlatList` windowing | `LazyVStack` trong `ScrollView` |
| Sticky section header | `Section` + `pinnedViews: [.sectionHeaders]` |
| `borderBottomRightRadius` | `UnevenRoundedRectangle(bottomTrailingRadius:)` |
| Promo card props | `let title`, `description`, `ctaTitle` tren struct View |

---

## Diem da hieu ro

- Khi nao can `ScrollView` vs chi `VStack` tren man ngan.
- Fix width tran: khong chi `.resizable()`, can `scaledToFill` + gioi han width + clip.
- Tach VStack co dinh vs LazyVStack list -- doc layout hon nested LazyVStack kep.
- `pinnedViews` chi co tac dung voi `Section`, khong phai `Text` le.
- REVIEW iterative: thu tu section, token mau, bo `maxHeight: .infinity` thua.

---

## Diem con chua chac / can on lai

- `manyTransactions` trong `ContentView` trung `sampleTransactions` -- nen xoa dead code.
- `BalanceCard` badge/icon tren gradient van `textPrimary` -- contrast chua toi uu (tu Day 2/3).
- `print` trong CTA/banner -- placeholder den Phase 3/4 (`@State`, navigation).
- Khac biet perf `List` vs `ScrollView + LazyVStack` khi customize sau nay.

---

## Exercise da hoan thanh

- [x] `ScrollView` + home layout day du
- [x] `PromotionBannerView.swift` + asset `banner`
- [x] `ForEach` >= 3 rows (da 40 items test lazy)
- [x] Preview Light/Dark (home + banner)
- [x] REVIEW Day 4: **Pass** (vong 3)
- [x] REVIEW LazyVStack stretch: **Pass**

### Deliverables

- `ContentView.swift` -- ScrollView, VStack + LazyVStack + Section
- `PromotionBannerView.swift` -- props, ZStack, UnevenRoundedRectangle, bgCard, appShadow
- `theme/AppTheme.swift` -- `AppShadow.Style`, `appShadow(_:)`, `AppRadius` mo rong
- `Assets.xcassets/banner.imageset/`

### Review feedback (tom tat)

- **Vong 1-2:** Thieu thu tu section, `.white` banner footer, thieu rows, `LazyV` typo, `.shadow()` trong.
- **Vong 3:** Pass -- Quick -> Banner -> List, `bgCard`, `ForEach` 40, bo nested lazy thua.
- **LazyVStack:** Pass -- `VStack` + `LazyVStack` + `Section`; da them `pinnedViews` sticky header.

---

## Ghi chu them

- Buoi hoc dai hon do lam stretch trong cung ngay (props, ZStack, LazyVStack).
- Gap loi width tran la bai hoc layout quan trong -- modifier order va clip.
- San sang Day 5: `TransactionManager` that, empty state, giam mock 40 items.

---

## Next session

**Chu de tiep theo:** Phase 2 Day 5 -- `TransactionManager` + list dong + empty state

**Goi y cu the:**

- Khoi tao `TransactionManager` trong `ContentView` (`@State` tam thoi, chua `@Observable` day du)
- Seed vai giao dich qua `add(amount:note:category:)` thay `(0..<40).map`
- `ForEach(manager.transactions)` hoac computed `sortByNewest()`
- Khi `transactions.isEmpty` hien empty state view (icon + message)
- Xoa `manyTransactions` dead code

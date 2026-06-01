# Session Report -- 2026-06-01 -- SwiftUI Layout Day 2

---

## Thong tin buoi hoc

- **Ngay:** 2026-06-01
- **Phase:** Phase 2 -- SwiftUI Views & Layout
- **Day:** Day 2 -- VStack/HStack/ZStack, Spacer, Balance Card Layout
- **Thoi luong:** ~1 gio

---

## Muc tieu buoi hoc

- [x] Dung `HStack` + `Spacer()` de canh trai/phai trong `HeaderView`
- [x] Nang cap `BalanceCard` thanh card UI co badge, gradient, bo goc
- [x] Ap dung `ZStack` de them decorative icon cho card
- [x] Chuan hoa spacing/padding toan man hinh trong `ContentView`
- [x] Them preview rieng cho `HeaderView` va `BalanceCard`

---

## Nhung gi da hoc

### Concept chinh

- `VStack` dung cho bo cuc doc, `HStack` cho bo cuc ngang, `ZStack` cho bo cuc chong lop.
- `Spacer()` la cach day cac phan tu ra 2 dau trong `HStack`.
- Thu tu modifier quan trong: padding/background/frame co the thay doi ket qua layout.
- Parent-level padding (`ContentView`) va child-level padding (`BalanceCard`) can phan vai ro rang.
- Contrast text tren gradient card can uu tien kha nang doc (foreground style phu hop).

### Code da viet

```swift
HStack {
    Text("So du hien tai:")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
    Spacer()
    Text("VIB Wallet")
        .font(.caption)
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background(.blue.opacity(0.15))
        .clipShape(Capsule())
}
```

### Mapping React Native -> SwiftUI

| React Native | Swift/SwiftUI |
|---|---|
| `flexDirection: 'row'` + `justifyContent: 'space-between'` | `HStack { ... Spacer() ... }` |
| `positioned overlay/badge` | `ZStack(alignment: ...)` |
| Card + borderRadius | `.background { RoundedRectangle(...) }` |
| `paddingHorizontal` o container root | `.padding(.horizontal, 16)` tren parent view |
| Mau chu tren gradient | `.foregroundStyle(.white/.primary)` de dam bao contrast |

---

## Diem da hieu ro

- Hieu cach dung `Spacer()` trong `HStack` de canh trai/phai.
- Hieu khi nao nen dung `ZStack` thay vi `VStack/HStack`.
- Hieu va da fix duoc van de UI polish: foreground contrast + double padding.

---

## Diem con chua chac / can on lai

- Chua vao `Button` interactions va quick actions (du kien Day 3).
- Chua binding layout voi data list thuc te (`List`/`ForEach`) -- du kien Day 5.

---

## Exercise da hoan thanh

- [x] `HeaderView` co `HStack + Spacer + icon` va preview rieng
- [x] `BalanceCard` co badge "VIB Wallet", gradient background, bo goc, icon overlay
- [x] `ContentView` spacing toan man hinh hop ly (`padding(.horizontal, 16)`)
- [x] Da sua review feedback Day 2: contrast text va padding consistency

### Code exercise

```swift
struct ContentView: View {
    private let sampleTransaction = Transaction(id: UUID().uuidString, amount: 1500000, note: "Di cho", category: .shopping, createAt: Date())

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(name: "Phu")
            BalanceCard(balance: 15000000.0)
            VStack(alignment: .leading) {
                Text("Giao dich gan day:")
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                    .font(.headline)
                TransactionRowView(transaction: sampleTransaction)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
```

---

## Ghi chu them

- Day 2 review: Pass sau khi sua `foregroundStyle` va padding.
- UI da co nen tang layout tot cho Day 3 (button/quick actions).

---

## Next session

**Chu de tiep theo:** Phase 2 Day 3 -- `Image`, `Button`, quick action row (Nap tien, Chuyen tien, QR, Thanh toan) voi icon + style nhat quan.

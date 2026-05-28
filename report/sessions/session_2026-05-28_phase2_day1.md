# Session Report -- 2026-05-28 -- SwiftUI Basics Day 1

---

## Thong tin buoi hoc

- **Ngay:** 2026-05-28
- **Phase:** Phase 2 -- SwiftUI Views & Layout
- **Day:** Day 1 -- View, Text, Modifiers, Preview, Component Props
- **Thoi luong:** ~1 gio

---

## Muc tieu buoi hoc

- [x] Khoi tao iOS SwiftUI app `EWalletHomeScreen`
- [x] Dung `struct ...: View`, `var body: some View`, `Text`, `VStack`, preview light/dark
- [x] Tach model/week1 code thanh file rieng (khong de trong `ContentView`)
- [x] Tao `TransactionRowView` nhan `transaction` truyen vao (props-style)
- [x] Hoan thanh stretch: tach `HeaderView`, `BalanceCard`, va preview rieng cho row

---

## Nhung gi da hoc

### Concept chinh

- SwiftUI view la `struct`, UI duoc khai bao trong `body` theo kieu declarative.
- Modifier chain (`.font`, `.foregroundStyle`, `.padding`, `.frame`) la cach style/layout chinh.
- Text canh giua co 2 lop: canh noi dung (`.multilineTextAlignment`) va canh vi tri view (`.frame(maxWidth: .infinity, alignment: .center)`).
- Truyen data vao child view qua stored property (`let transaction`) ~= props trong React Native.
- Refactor layout thanh subviews som giup code de doc va san sang cho Day 2/Day 3.

### Code da viet

```swift
struct TransactionRowView: View {
    let transaction: Transaction

    var body: some View {
        VStack(alignment: .leading) {
            Text("\(transaction.displayNote) - \(transaction.displayAmount)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
        }
    }
}
```

### Mapping React Native -> SwiftUI

| React Native | Swift/SwiftUI |
|---|---|
| Function component + props | `struct View` + `let` stored property |
| `<Row transaction={item} />` | `TransactionRowView(transaction: item)` |
| `textAlign: "center"` | `.multilineTextAlignment(.center)` (+ `.frame(..., alignment: .center)` neu can) |
| `fontSize` + `fontWeight` | `.font(...)` + `.fontWeight(...)`/`.bold()` |
| `padding`, `paddingHorizontal` | `.padding(...)` |

---

## Diem da hieu ro

- Hieu cach truyen model vao row view thay vi hard-code sample trong child.
- Hieu ly do dung `.frame(maxWidth: .infinity)` thay vi `.frame(width: .infinity)`.
- Hieu cach tach `HeaderView`/`BalanceCard` de giu `ContentView` gon va ro cau truc.

---

## Diem con chua chac / can on lai

- Chua dung `List`/`ForEach` voi manager data that (du kien Day 5-6).
- Chua vao state/data flow (`@State`, `@Binding`) -- se hoc o Phase 3.

---

## Exercise da hoan thanh

- [x] Dung duoc man hinh home co header + balance + transaction row
- [x] Truyen `sampleTransaction` tu `ContentView` vao `TransactionRowView`
- [x] Sửa logic `validate(amount > 0)` va `update(by id)` trong `TransactionManager`
- [x] Preview light/dark cho `ContentView`
- [x] Preview rieng cho `TransactionRowView`

### Code exercise

```swift
struct ContentView: View {
    private let sampleTransaction = Transaction(id: UUID().uuidString, amount: 1500000, note: "Di cho", category: .shopping, createAt: Date())

    var body: some View {
        VStack(alignment: .leading) {
            HeaderView(name: "Phu")
            BalanceCard(balance: 15000000.0)
            VStack(alignment: .leading) {
                Text("Giao dich gan day:").padding(.top, 16).padding(.bottom, 4)
                TransactionRowView(transaction: sampleTransaction)
            }
        }
    }
}
```

---

## Ghi chu them

- REVIEW Day 1: Pass voi gop y -> da fix xong cac issue quan trong.
- Stretch Day 1 da xong: component extraction + row preview.

---

## Next session

**Chu de tiep theo:** Phase 2 Day 2 -- `VStack/HStack/ZStack`, `Spacer`, card layout cho header + balance section.

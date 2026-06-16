//
//  FilterSheetView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct FilterSheetView: View {
    @Binding var draft: TransactionFilter
    
    let onApply: () -> Void
    let onClear: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Danh mục") {
                    Picker("Danh mục",selection: $draft.category) {
                        Text("Tất cả").tag(Optional<TransactionCategory>.none)
                        ForEach(TransactionCategory.allCases, id: \.self) { cat in
                            Text(cat.title).tag(Optional(cat))
                        }
                    }
                }
                Section("Ngày") {
                    DatePicker("Từ ngày", selection: bindingDate($draft.fromDate), displayedComponents: .date)
                    DatePicker("Đến ngày", selection: bindingDate($draft.toDate), displayedComponents: .date)
                }
            }
            .navigationTitle("Lọc")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Huỷ") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .destructiveAction) {
                    Button("Xoá lọc") {
                        onClear()
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Áp dụng") {
                        onApply()
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func bindingDate(_ optional: Binding<Date?>) -> Binding<Date> {
        Binding(
            get: { optional.wrappedValue ?? Date() },
            set: { optional.wrappedValue = $0 }
        )
    }
}

#if DEBUG
#Preview("Empty filter") {
    @Previewable @State var draft = TransactionFilter.empty

    FilterSheetView(
        draft: $draft,
        onApply: {},
        onClear: { draft = .empty }
    )
    .environment(TransactionStore.previewSeeded())
}

#Preview("Active filter") {
    @Previewable @State var draft = TransactionFilter(
        category: .food,
        fromDate: Calendar.current.date(byAdding: .day, value: -7, to: Date()),
        toDate: Date()
    )

    FilterSheetView(
        draft: $draft,
        onApply: {},
        onClear: { draft = .empty }
    )
    .environment(TransactionStore.previewSeeded())
}

#Preview("Active filter — Dark") {
    @Previewable @State var draft = TransactionFilter(
        category: .shopping,
        fromDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()),
        toDate: Date()
    )

    FilterSheetView(
        draft: $draft,
        onApply: {},
        onClear: { draft = .empty }
    )
    .environment(TransactionStore.previewSeeded())
    .preferredColorScheme(.dark)
}
#endif

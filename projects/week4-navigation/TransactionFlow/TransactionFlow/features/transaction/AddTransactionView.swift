//
//  AddTransactionView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(TransactionManager.self) private var manager
    @Environment(\.dismiss) private var dismiss
    
    @State private var note = ""
    @State private var amountText = ""
    @State private var category: TransactionCategory = .food
    @State private var createdAt = Date()
    @State private var errorMessage: String?   
    
    private var parsedAmount: Double? {
        Double(amountText.trimmingCharacters(in: .whitespaces))
    }
    
    private var isFormValid: Bool {
        guard let amount = parsedAmount else { return false }
        return amount > 0
    }
    
    private func submit() {
        errorMessage = nil
        
        guard let amount = parsedAmount, amount > 0 else {
            withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                errorMessage = TransactionError.invalidAmount.errorDescription
            }
            return
        }
        
        do {
            try withAnimation(.snappy) {
                try manager.add(
                    amount: amount,
                    note: note.isEmpty ? nil : note,
                    category: category,
                    createdAt: createdAt
                )
                dismiss()
            }
            amountText = ""
            note = ""
            category = .food
            createdAt = Date()
        } catch let error as TransactionError {
            withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                errorMessage = error.errorDescription
            }
        } catch {
            withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                errorMessage = error.localizedDescription
            }
        }
        
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    
                    AmountTextField(text: $amountText)
                    TextField("Ghi chú", text: $note).formField()
                    CategoryPicker(selection: $category).pickerStyle(.menu)
                    DatePickerCustom(selection: $createdAt)
                    
                    if let errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                            .font(AppTypography.caption)
                            .foregroundStyle(.red)
                            .padding(AppSpacing.md)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.red.opacity(0.1), in: .rect(cornerRadius: AppRadius.sm))
                            .transition(.opacity.combined(
                                with: .scale(scale: 0.95, anchor: .top)
                            ))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, AppSpacing.lg)
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(
                    Rectangle()
                        .fill(AppColor.bgPrimary)
                )
                .navigationTitle("Thêm giao dịch")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            Button {
                submit()
            } label: {
                Text("Thêm giao dịch")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppSpacing.xs)
            }
            .padding(.horizontal, AppSpacing.lg)
            .buttonStyle(PrimaryButtonStyle())
            .disabled(!isFormValid)
        }
    }
}

#if DEBUG
#Preview("Seeded") {
    NavigationStack {
        AddTransactionView()
    }
    .environment(TransactionManager.previewSeeded())
}

#Preview("Seeded — Dark") {
    NavigationStack {
        AddTransactionView()
    }
    .environment(TransactionManager.previewSeeded())
    .preferredColorScheme(.dark)
}
#endif

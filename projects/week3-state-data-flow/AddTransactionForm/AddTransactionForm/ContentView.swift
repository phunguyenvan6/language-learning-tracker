//
//  ContentView.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 9/6/26.
//

import SwiftUI

struct ContentView: View {
    @State private var manager = TransactionManager()
    @State private var note = ""
    @State private var amountText = ""
    @State private var category: TransactionCategory = .food
    
    @State private var errorMessage: String?
    
    private var parsedAmount: Double? {
        Double(amountText.trimmingCharacters(in: .whitespaces))
    }
    
    private var isFormValid: Bool {
        parsedAmount != nil && (parsedAmount ?? 0) > 0
    }
    
    private func submit() {
        errorMessage = nil
        
        guard let amount = parsedAmount, amount > 0 else {
            errorMessage = TransactionError.invalidAmount.errorDescription
            return
        }
        
        do {
            try manager.add(amount: amount, note: note, category: category)
            
            amountText = ""
            note = ""
            category = .food
        
        } catch let error as TransactionError {
            errorMessage = error.errorDescription
        } catch {
            errorMessage = error.localizedDescription
        }
        
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.lg) {
                Text("Thêm giao dịch")
                    .font(AppTypography.title)
                    .foregroundStyle(AppColor.textPrimary)

                AmountTextField(text: $amountText)
                TextField("Ghi chú", text: $note)
                CategoryPicker(selection: $category).pickerStyle(.menu)
                
                if let errorMessage {
                    Text(errorMessage)
                        .font(AppTypography.caption)
                        .foregroundStyle(.red)
                }
                Button("Thêm giao dịch") {
                    submit()
                }
                .disabled(!isFormValid)
                .buttonStyle(.borderedProminent)
                .tint(AppColor.brandPrimary)
                Text("Đã lưu: \(manager.transactions.count) giao dịch")

            }
            .padding(.horizontal, AppSpacing.lg)
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColor.bgPrimary)
        
    }
    
}

#Preview {
    ContentView()
}

#Preview("Dark") {
    ContentView().preferredColorScheme(.dark)
}

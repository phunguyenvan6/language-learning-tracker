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
    @State private var createdAt: Date = Date()
    
    @State private var errorMessage: String?
    @State private var submitting: Bool = false
    @State private var didSubmitSuccessfully = false
    
    private var parsedAmount: Double? {
        Double(amountText.trimmingCharacters(in: .whitespaces))
    }
    
    private var isFormValid: Bool {
        guard let amount = parsedAmount else { return false }
        return amount > 0
    }

    private func submit() {
        submitting = true
        defer { submitting = false }
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
            }
            amountText = ""
            note = ""
            category = .food
            createdAt = Date()
            
            withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                didSubmitSuccessfully = true
            }
            
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
    
    init(manager: TransactionManager = TransactionManager()) {
        _manager = State(initialValue: manager)
    }
    
    var body: some View {
        Group {
            ScrollView {
                VStack(alignment: .leading, spacing: AppSpacing.lg) {
                    Text("Thêm giao dịch")
                        .font(AppTypography.title)
                        .foregroundStyle(AppColor.textPrimary)
                    
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
                    
                    Text("Đã lưu: \(manager.transactions.count) giao dịch")
                        .font(AppTypography.caption)
                        .foregroundStyle(AppColor.textSecondary)
                        .contentTransition(
                            .numericText(value:Double(manager.transactions.count))
                        )
                }
                .padding(.horizontal, AppSpacing.lg)
                .onChange(of: didSubmitSuccessfully) { _, newValue in
                    guard newValue else { return }
                    Task {
                        try await Task.sleep(for: .seconds(2))
                        withAnimation {
                            didSubmitSuccessfully = false
                        }
                    }
                }

            }
            .scrollDismissesKeyboard(.interactively)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(AppColor.bgPrimary)
            .overlay(alignment: .top) {
                if didSubmitSuccessfully {
                    Label("Đã lưu giao dịch mới", systemImage: "checkmark.circle.fill")
                        .font(AppTypography.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, AppSpacing.md)
                        .padding(.horizontal, AppSpacing.xl)
                        .background(AppColor.accentSuccess, in: .capsule)
                        .appShadow(AppShadow.card)
                    .transition(.move(edge: .top).combined(with: .opacity))                }
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
            .disabled(!isFormValid || submitting)
        }
        .sensoryFeedback(.success, trigger: didSubmitSuccessfully) { _, new in new }
    }
    
}

#Preview {
    ContentView()
}
#Preview("Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
#Preview("Seeded — 3 giao dịch") {
    ContentView(manager: .previewSeeded())
}

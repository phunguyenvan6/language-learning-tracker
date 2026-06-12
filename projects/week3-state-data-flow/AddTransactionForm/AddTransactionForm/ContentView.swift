//
//  ContentView.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 9/6/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(TransactionManager.self) private var manager
    @State private var note = ""
    @State private var amountText = ""
    @State private var category: TransactionCategory = .food
    @State private var createdAt: Date = Date()
    
    @State private var errorMessage: String?
    @State private var submitting: Bool = false
    @State private var didSubmitSuccessfully = false
    
    #if DEBUG
    @State private var didSeedDemo = false
    #endif
    
    
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
    
    private var homeTopContent: some View {
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
            Divider().padding(.vertical, AppSpacing.md)
            
            Text("Đã lưu: \(manager.transactions.count) giao dịch")
                .font(AppTypography.caption)
                .foregroundStyle(AppColor.textSecondary)
                .contentTransition(
                    .numericText(value:Double(manager.transactions.count))
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.horizontal, AppSpacing.lg)
        .listRowInsets(EdgeInsets())
        .listRowSeparator(.hidden)
        .listRowBackground(
            Rectangle()
                .fill(AppColor.bgPrimary)
        )
        
    }
    
    private var sortedTransactions: [Transaction] {
        manager.sortByNewest()
    }
    
    private func onRefresh() {
        guard manager.transactions.isEmpty
        else { return }
        seedSampleTransactions()
    }
    
    private func onTransactionTap(id: String) {
        print("Tapped transaction:", id)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                homeTopContent
                TransactionListSection(
                    transactions: sortedTransactions,
                    onRefresh: onRefresh,
                    onTransactionTap: onTransactionTap
                )                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .listSectionSeparator(.hidden)
            .contentMargins(.horizontal, 0, for: .scrollContent)
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
            .task {
                #if DEBUG
                guard !didSeedDemo, manager.transactions.isEmpty else { return }
                didSeedDemo = true
                try? await Task.sleep(for: .milliseconds(300))
                try? manager.add(
                    amount: 25_000,
                    note: "Demo seed",
                    category: .food,
                    createdAt: Date()
                )
                #endif // DEBUG
            }
            .onAppear {
                print("ContentView appeared, count:", manager.transactions.count)
            }
            .onChange(of: didSubmitSuccessfully) { _, newValue in
                guard newValue else { return }
                Task {
                    try await Task.sleep(for: .seconds(2))
                    withAnimation {
                        didSubmitSuccessfully = false
                    }
                }
            }
            .onChange(of: amountText) { _, _ in
                if errorMessage != nil {
                    withAnimation {
                        errorMessage = nil
                    }
                }
            }
            .onChange(of: manager.transactions.count) { _, _ in
                print("Có tất cả \(manager.transactions.count) giao dịch")
            }
            .sensoryFeedback(.success, trigger: didSubmitSuccessfully) { _, new in new }
            
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
    }
    
    private func seedSampleTransactions() {
        let samples: [(Double, String?, TransactionCategory, Date)] = [
            (850_000, "Đi chợ", .food, Date().addingTimeInterval(-41000)),
            (2_500_000, "Chuyển tiền", .transport,  Date().addingTimeInterval(-12000)),
            (120_000, nil, .bill, Date().addingTimeInterval(-2000)),
            (450_000, "Mua sắm", .shopping, Date().addingTimeInterval(-1000)),
        ]
        for sample in samples {
            do {
                try manager.add(
                    amount: sample.0,
                    note: sample.1,
                    category: sample.2,
                    createdAt: sample.3
                )
            } catch let error as LocalizedError {
                print(error.errorDescription ?? String(describing: error))
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView().environment(TransactionManager.init())
}
#Preview("Dark") {
    ContentView()
        .environment(TransactionManager.init())
        .preferredColorScheme(.dark)
}

#Preview("Seeded — 3 giao dịch") {
    ContentView().environment(TransactionManager.previewSeeded())
}

#Preview("Seeded Dark — 3 giao dịch") {
    ContentView()
        .preferredColorScheme(.dark)
        .environment(TransactionManager.previewSeeded())
}

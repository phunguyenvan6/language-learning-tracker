//
//  HomeView.swift
//  TransactionFlow
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 12/6/26.
//

import SwiftUI

struct HomeView: View {
    let onOpenTransaction: (String) -> Void
    let onAddTransaction: () -> Void
    let onOpenFilter: () -> Void
    var onOpenOnboarding: (() -> Void)? = nil
    
    @Environment(TransactionStore.self) private var store

    var body: some View {
        List {
            if store.isEmpty {
                ContentUnavailableView(
                    "Chưa có giao dịch",
                    systemImage: "tray",
                    description: Text("Nhấn + để thêm")
                )
            } else if store.displayedTransactions.isEmpty {
                ContentUnavailableView(
                    "Không có kết quả",
                    systemImage: "magnifyingglass",
                    description: Text("Thử xoá bộ lọc")
                )
            } else {
                ForEach(store.displayedTransactions) { tx in
                    VStack(alignment: .leading) {
                        Button {
                            onOpenTransaction(tx.id)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(tx.displayAmount).font(.headline)
                                Text(tx.displayNote).foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation {
                                store.delete(id: tx.id)
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }
            }
        }
        .task {
            #if DEBUG
            guard !PreviewRuntime.isRunning else { return }
            guard store.isEmpty else { return }
            seedSampleTransactions()
            #endif
        }
        .navigationTitle("Giao dịch")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onOpenFilter()
                } label: {
                    if store.isFilterActive {
                        Badge(count: store.appliedFilter.totalFilter)
                    } else {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onAddTransaction()
                } label: {
                    Image(systemName: "plus")
                }
            }
            #if DEBUG
            ToolbarItem(placement: .topBarLeading) {
                Button("Onboarding") {
                    onOpenOnboarding?()
                }
                .font(.caption)
            }
            #endif

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
                    try store.add(
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

#if DEBUG
private enum PreviewRuntime {
    static var isRunning: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
#endif

private struct HomePreviewShell: View {
    let store: TransactionStore

    @State private var path: [AppRoute] = []
    @State private var activeSheet: HomeSheet? = nil
    @State private var activeCover: AppCover? = nil
    @State private var draftFilter = TransactionFilter.empty

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { path.append(.transactionDetail(id: $0)) },
                onAddTransaction: {
                    activeSheet = .add
                },
                onOpenFilter: {
                    activeSheet = .filter
                },
                onOpenOnboarding: {
                    activeCover = .onboarding
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .transactionDetail(let id):
                    TransactionDetailView(transactionId: id)
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .filter:
                FilterSheetView(
                    draft: $draftFilter,
                    onApply: {
                        withAnimation(.snappy) {
                            store.applyFilter(draftFilter)
                        }
                    },
                    onClear: {
                        withAnimation(.snappy) {
                            draftFilter = .empty
                            store.clearFilter()
                        }
                    }
                )
            case .add:
                NavigationStack {
                    AddTransactionView()
                }
//            case .edit(id: let id):
            }
        }
        .fullScreenCover(item: $activeCover) { cover in
            switch cover {
            case .onboarding:
                OnboardingView {
                    activeCover = nil
                }
            }
        }
        .onChange(of: activeSheet) { _, newValue in
            if newValue == .filter {
                draftFilter = store.appliedFilter
            }
        }
        .environment(store)
    }
}

#Preview("Seeded — interactive") {
    HomePreviewShell(store: .previewSeeded())
}

#Preview("Empty") {
    HomePreviewShell(store: TransactionStore(repository: InMemoryTransactionRepository()))
}

#Preview("Seeded Dark") {
    HomePreviewShell(store: .previewSeeded())
        .preferredColorScheme(.dark)
}

#Preview("Empty Dark") {
    HomePreviewShell(store: TransactionStore(repository: InMemoryTransactionRepository()))
        .preferredColorScheme(.dark)
}

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
    
    @Environment(TransactionManager.self) private var manager
    
    var body: some View {
        List {
            if manager.transactions.isEmpty {
                ContentUnavailableView(
                    "Chưa có giao dịch",
                    systemImage: "tray",
                    description: Text("Nhấn + để thêm")
                )
            } else {
                ForEach(manager.sortByNewest()) { tx in
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
                                manager.delete(id: tx.id)
                            }
                        } label: {
                            Label("Xóa", systemImage: "trash")
                        }
                    }
                }
            }
        }
        .task {
#if DEBUG
            guard !PreviewRuntime.isRunning else { return }
            guard manager.transactions.isEmpty else { return }
            try? manager.add(amount: 50_000, note: "Cà phê", category: .food)
            try? manager.add(amount: 120_000, note: "Grab", category: .transport)
#endif
        }
        .navigationTitle("Giao dịch")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onAddTransaction()
                } label: {
                    Image(systemName: "plus")
                }
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
    let manager: TransactionManager

    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(
                onOpenTransaction: { path.append(.transactionDetail(id: $0)) },
                onAddTransaction: { path.append(.addTransaction) }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .home:
                    EmptyView()
                case .transactionDetail(let id):
                    TransactionDetailView(transactionId: id)
                case .addTransaction:
                    AddTransactionView()
                }
            }
        }
        .environment(manager)
    }
}

#Preview("Seeded — interactive") {
    HomePreviewShell(manager: .previewSeeded())
}

#Preview("Empty") {
    HomePreviewShell(manager: TransactionManager())
}

#Preview("Seeded Dark") {
    HomePreviewShell(manager: .previewSeeded())
        .preferredColorScheme(.dark)
}

#Preview("Empty Dark") {
    HomePreviewShell(manager: TransactionManager())
        .preferredColorScheme(.dark)
}

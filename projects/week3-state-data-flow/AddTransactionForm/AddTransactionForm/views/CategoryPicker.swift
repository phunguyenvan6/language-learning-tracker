//
//  CategoryPicker.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 10/6/26.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selection: TransactionCategory
    
    var body: some View {
        Picker("Danh mục", selection: $selection) {
            ForEach(TransactionCategory.allCases, id: \.self) { cat in
                Label(cat.title, systemImage: cat.systemImage).tag(cat)
            }
        }
        .formField()
    }
}

#Preview {
    @Previewable @State var category: TransactionCategory = .shopping

    CategoryPicker(selection: $category)
}

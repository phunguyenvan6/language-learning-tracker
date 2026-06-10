//
//  DatePicker.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 10/6/26.
//

import SwiftUI

struct DatePickerCustom: View {
    @Binding var selection: Date
    
    var body: some View {
        DatePicker("Ngày giao dịch", selection: $selection, displayedComponents: [.date])
            .formField()
    }
}

#Preview {
    @Previewable @State var date = Date()

    DatePickerCustom(selection: $date)
}

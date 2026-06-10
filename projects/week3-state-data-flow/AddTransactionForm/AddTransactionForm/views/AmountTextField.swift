//
//  AmountTextField.swift
//  AddTransactionForm
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 10/6/26.
//

import SwiftUI

struct AmountTextField: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Số tiền", text: $text)
            .keyboardType(.decimalPad)
    }
}

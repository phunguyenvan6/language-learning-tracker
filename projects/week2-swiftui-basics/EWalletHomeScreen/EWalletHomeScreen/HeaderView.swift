//
//  HeaderView.swift
//  EWalletHomeScreen
//
//  Created by Phu Nguyen Van (BTS-DCT-IDO) on 28/5/26.
//

import SwiftUI

struct HeaderView: View {
    let name: String
    
    var body: some View {
        HStack {
            Text("Chào \(name.uppercased())")
                .padding(.vertical, 8)
                .background(.yellow)
                .font(.headline)
                .foregroundStyle(.linearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                .multilineTextAlignment(.center)
            Spacer()
            Image(systemName: "bell.fill").font(.title3).foregroundStyle(.secondary)
        }
        .padding(.vertical,8)
    }
}

#Preview("Header") {
    HeaderView(name: "Phú")
        .padding()
}

//
//  HeaderView.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import SwiftUI

struct HeaderView: View {
    @State var headerHeight: CGFloat?
    var body: some View {
        HStack {
            Text("Москва ✔")
            Spacer()
        }
        .padding()
        .font(.system(size: 14))
        .frame(height: headerHeight)
        .background(Color(.systemBackground))}
}

#Preview {
    HeaderView()
}

//
//  PromotionBanner.swift
//  HammerApp
//
//  Created by Михаил Ганин on 24.07.2025.
//

import SwiftUI

struct PromotionBanner: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("СКИДКА 30%")
                .font(.title2)
                .bold()
            Text("с понедельника по четверг с 10 до 16")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.2))
        .cornerRadius(10)
        .padding(.horizontal)
        .frame(width: 300, height: 112)
        .background(Color(.systemBackground))
    }
}

#Preview {
    PromotionBanner()
}

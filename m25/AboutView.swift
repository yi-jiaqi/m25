//
//  AboutView.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.14.
//

import Foundation
import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack(spacing: 60) {  // spacing between the two groups
            
                // MARK: - Top Section
            VStack(spacing: 30) { // spacing between each item
                Text("MANIFESTO")
                Text("RULES")
                Text("THE ARTISTS")
                Text("FAQ")
                Text("YOUR MEMBERSHIP")
            }
            .font(.custom("Rubik-Medium", size: 24))
            .foregroundColor(.white)
            
                // MARK: - Bottom Section
            VStack(spacing: 30) {
                Text("DO NOT DISTURB")
                Text("DEMO")
            }
            .font(.custom("Rubik-Medium", size: 24))
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .multilineTextAlignment(.center)
        .background(Color(hex: "1D1D1D"))
        .padding(.horizontal, 30)
    }
}

#Preview {
    AboutView()
}

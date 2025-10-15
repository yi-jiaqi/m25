    //
    //  Headline.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.13.
    //

import Foundation
import SwiftUI

    // You can define universal color codes by extending Color, for example:
    // extension Color {
    //     static let customBlack = Color(red: 0.0, green: 0.0, blue: 0.0)
    // }
extension Color {
    static let menu_color = Color(red: 0.11, green: 0.11, blue: 0.11) // hex 1d1d1d
}

struct Headline: View {
    
    enum HeadlineType {
        case menu
        case reading
        case shop
        case setting
    }
    
    var type: HeadlineType
    var heading: String
    
    var body: some View {
        switch type {
        case .menu:
                
                VStack(spacing: 0) {

                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                        // Make sure Rubik font is included in the app’s resources
                    Text(heading)
                        .font(.custom("Rubik-Medium", size: 24))
                        .foregroundColor(.white)
                        .padding()
                        .textCase(.uppercase)
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.white.opacity(0.7))
                }
                .padding(.horizontal, 30)
                .background(Color.menu_color)
                
                
        case .reading:
                    // 📖 READING version
                Text("HEADLINE - Reading")
                    .font(.custom("Rubik", size: 32).weight(.medium))
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))
                    .frame(width: 454, height: 55)
                    .offset(y: 37.5)
                
        case .shop:
                    // 🏪 SHOP version
                VStack(alignment: .leading, spacing: 10) {
                    Text("Headline - Settings / Shop")
                        .font(.custom("Rubik", size: 32).weight(.medium))
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(width: 454)
                .offset(y: 136.5)
            
        case .setting:
                // 🏪 SHOP version
            VStack(alignment: .leading, spacing: 10) {
                Text("Headline - Settings / Shop")
                    .font(.custom("Rubik", size: 32).weight(.medium))
                    .foregroundColor(.white)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.black.opacity(0.7))
            }
            .frame(width: 454)
            .offset(y: 136.5)
    
        }
        
    }
}

#Preview {
    VStack(spacing: 40) {
        Headline(type: .menu,heading:"News")
    }
}


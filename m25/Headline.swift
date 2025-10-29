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
        case shop_title
        case setting
        
    }
    
    var type: HeadlineType
    var heading: String
    
    var body: some View {
        switch type {
        case .menu:
                
                VStack(spacing: 0) {

  
                    Divider()
                        .background(Color.white.opacity(0.7))
                        .frame(height: 2)
                    Text(heading)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical,12)
                        .textCase(.uppercase)
         
                    Divider()
                        .background(Color.white.opacity(0.7))
                        .frame(height: 2)
                }
                .padding(0)
                .background(Color.menu_color)
                
                
        case .reading:
                    // 📖 READING version
                Text(heading)
                    .font(.largeHeadline)
                    .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.11))

                
        case .shop:
                    // 🏪 SHOP version
                VStack(alignment: .leading, spacing: 10) {
                    Text(heading)
                        .font(.largeHeadline)
                        .foregroundColor(.white)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white.opacity(0.7))
                }
            
        case .shop_title:
                // 🏪 SHOP version
            VStack(alignment: .leading, spacing: 10) {
                Text(heading)
                    .font(.xLargeHeadline)
                    .foregroundColor(.white)
                
            }


            
        case .setting:
                // SETTING version
            VStack(alignment: .leading, spacing: 10) {
                Text(heading)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.horizontal, 15)

    
        }
        
    }
}

#Preview {
    VStack(spacing: 40) {
        Headline(type: .menu,heading:"News")
    }
}


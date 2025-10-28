    //
    //  News.swift
    //  m25
    //
    //  Created by Jiaqi Yi on 2025.10.13.
    //

import Foundation
import SwiftUI

struct News: View {
    enum NewsType {
        case noImage
        case littleImage
        case bigImage
        case veryBigImage
        case thumbImage
    }
    
    var type: NewsType
    var title: String
    var content: String
    var image: Image? = nil
    
    private func lineHeight(for font: Font) -> CGFloat {
        switch font {
        case .xXSmallHeadline: return 14 // adjust to your actual line height
        default: return 16
        }
    }
    
    var body: some View {
        Group {
            switch type {
                
                    // MARK: - No Image
            case .noImage:
                VStack(alignment: .leading) {
                    Text(title.uppercased())
                        .font(.smallHeadline)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    Text(content)
                        .font(.smallBodyText)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                    // MARK: - Little Image
            case .littleImage:
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title.uppercased())
                            .font(.smallHeadline)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                        
                        Text(content)
                            .font(.smallBodyText)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                    }
                    Spacer()
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                            .cornerRadius(12)
                    }
                }
                
                    // MARK: - Big Image
            case .bigImage:
                VStack(alignment: .leading, spacing: 6) {
                    Text(title.uppercased())
                        .font(.smallHeadline)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text(content)
                        .font(.smallBodyText)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    
                    
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 280, height: 280)
                            .clipped()
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                    // MARK: - Very Big Image - Shop Preview in the Menu-Shop(LittleShopView)
            case .veryBigImage:
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .center) {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 300, height: 300)
                                .clipped()
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                    Text(title.uppercased())
                        .font(.xSmallHeadline)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .multilineTextAlignment(.center) 
                        .frame(maxWidth: .infinity, alignment: .center)                .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                    Text(content)
                        .font(.smallBodyText)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)                .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(5)
                }
                    // MARK: - Thumb Image - for showing item in Shop(ShopView)
            case .thumbImage:
                VStack(alignment: .center, spacing: 6) {
                    
                    
                    if let image = image {
                        GeometryReader { geometry in
                            let cardWidth = (geometry.size.width - 6) / 1  // 16 = horizontal padding between two cards
                            
                            image
                                .resizable()
                                .scaledToFit() // ✅ keeps aspect ratio (fit)
                                .frame(width: cardWidth, height: cardWidth) // ✅ square frame
                                .clipped()
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(maxHeight: .infinity, alignment: .center)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    HStack(alignment: .top) {
                        Text(title.uppercased())
                            .font(.xXSmallHeadline)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .lineLimit(3) // ✅ max 3 lines
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(
                                minHeight: Font.lineHeight(for: .xXSmallHeadline) * 2,
                                maxHeight: Font.lineHeight(for: .xXSmallHeadline) * 3
                            )
                    }
                    Text(content.lowercased())
                        .font(.xSmallBodyText)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
        .frame(maxWidth: .infinity)
        .background(Color(hex: "C7C7C7"))
        .cornerRadius(18)
    }
}


#Preview {
    ScrollView {
        VStack {
            News(type: .noImage, title: "Demo", content: "Quick demo on how the project works.")
            News(type: .littleImage, title: "Do not Disturb", content: "Set a time...", image: Image("minutiae_clock_square"))
            News(type: .bigImage, title: "NEW POSTERS AVAILABLE!", content: "We’ve just launched...", image: Image("minutiae_poster_notification"))
        }
        .padding(.horizontal,30)
        
        VStack(spacing: 40) {
            News(type: .littleImage,
                 title: "Little Image",
                 content: "When there’s a small image, put it on the right side.",
                 image: Image("minutiae_clock_square"))

            
                // MARK: 🧩 Demo: Grid layout using thumbImage
            VStack(alignment: .leading, spacing: 6) {
                // Two-column grid
                let columns = [
                    GridItem(.flexible(), spacing: 6),
                    GridItem(.flexible(), spacing: 6)
                ]
                
                LazyVGrid(columns: columns, spacing: 6) {
                    ForEach(1..<5) { index in
                        News(type: .thumbImage,
                             title: "Item \(index)",
                             content: "From $199",
                             image: Image("minutiae_poster_notification"))
                    }
                }
                .padding(.horizontal, 16)
            }
            
            VStack(spacing: 20) {
                News(type: .veryBigImage,
                     title: "Very Big Image",
                     content: "For Shop preview in menu.",
                     image: Image("minutiae_poster_notification"))
                
                News(type: .noImage,
                     title: "Notification",
                     content: "Content of the notification.")
                
                News(type: .littleImage,
                     title: "Little Image",
                     content: "When there’s a small image, put it on the right side.",
                     image: Image("minutiae_clock_square"))
                
                News(type: .bigImage,
                     title: "Big Image",
                     content: "When there’s a big image, put below.",
                     image: Image("minutiae_poster_notification"))
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 30)
        .background(Color(hex: "F1F1F1"))
    }
}

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
    var imageName: String? = nil //if need to detect aspect ratio (in .thumbnail, in ShopeView)
    
    init(
        type: NewsType,
        title: String,
        content: String,
        image: Image? = nil,
        imageName: String? = nil
    ) {
        self.type = type
        self.title = title
        self.content = content
        self.image = image
        self.imageName = imageName
    }
    
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
                    if !content.isEmpty {
                        Text(content)
                            .font(.smallBodyText)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                    }
                    
                    
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
                        .frame(maxWidth: .infinity, alignment: .center)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                    
                    
                        Text(content)
                            .font(.smallBodyText)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fixedSize(horizontal: false, vertical: false)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                    
                    

                }
                    // MARK: - Thumb Image - for showing item in Shop(ShopView)
            case .thumbImage:
                VStack(alignment: .center, spacing: 4) {
                        //                    if let image = image {
                        //                        GeometryReader { geometry in
                        //                            let cardWidth = geometry.size.width
                        //                                // Try to read actual image dimensions from asset
                        //                            if let imageName = imageName {
                        //                                if let uiImage = UIImage(named: "\(imageName)") {
                        //                                    let aspectRatio = uiImage.size.height / uiImage.size.width
                        //                                        // Landscape → shorter; Portrait → taller
                        //                                    image
                        //                                        .resizable()
                        //                                        .scaledToFit()
                        //                                        .frame(width: cardWidth,
                        //                                               height: cardWidth * (aspectRatio < 0.8 ? 0.7 : 1.0))
                        //                                        .clipped()
                        //                                        .cornerRadius(12)
                        //                                        .frame(maxWidth: .infinity, alignment: .center)
                        //                                        .frame(maxHeight: .infinity, alignment: .center)
                        //                                } else {
                        //                                        // Fallback if aspect ratio can't be detected
                        //                                    image
                        //                                        .resizable()
                        //                                        .scaledToFit()
                        //                                        .frame(width: cardWidth, height: cardWidth)
                        //                                        .clipped()
                        //                                        .cornerRadius(12)
                        //                                        .frame(maxWidth: .infinity, alignment: .center)
                        //                                }
                        //                            }
                        //                        }
                        //                        .aspectRatio(1, contentMode: .fit)
                        //                    }
                    if let image = image {
                        if let imageName = imageName,
                           let uiImage = UIImage(named: imageName) {
                            let aspectRatio = uiImage.size.height / uiImage.size.width
                            let heightFactor: CGFloat = aspectRatio < 0.8 ? 0.7 : 1.0
                            let widthOffestWhenLandscape: CGFloat = aspectRatio < 0.8 ? 6.0 : 0.0
                            
                            GeometryReader { geometry in
                                let cardWidth = geometry.size.width
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: cardWidth+widthOffestWhenLandscape,
                                           height: (cardWidth+widthOffestWhenLandscape) * heightFactor)
                                    .clipped()
                                    .cornerRadius(12)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }.aspectRatio(1/heightFactor, contentMode: .fit)
                        }
                    }
                    
                        // Title
                    HStack(alignment: .top) {
                        Text(title.uppercased())
                            .font(.xXSmallHeadline)
                            .foregroundColor(Color(hex: "1D1D1D"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(
                                minHeight: Font.lineHeight(for: .xXSmallHeadline) * 2,
                                maxHeight: Font.lineHeight(for: .xXSmallHeadline) * 3
                            )
                    }
                    
                        // Content
                    Text(content)
                        .font(.xSmallBodyText)
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding(type == .thumbImage
                 ? EdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6)
                 : EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
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
            News(type: .bigImage, title: "NEW POSTERS AVAILABLE!", content: "", image: Image("minutiae_poster_notification"))
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
    }.environmentObject(AppDataManager())
}

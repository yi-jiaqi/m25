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
    }
    
    var type: NewsType
    var title: String
    var content: String
    var image: Image? = nil
    
    var body: some View {
        Group {
            switch type {
                
                    // MARK: - No Image
            case .noImage:
                VStack(alignment: .leading) {
                    Text(title.uppercased())
                        .font(Font.custom("Rubik", size: 20).weight(.medium))
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                    Text(content)
                        .font(Font.custom("Rubik", size: 18).weight(.light))
                        .foregroundColor(Color(hex: "1D1D1D"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                    // MARK: - Little Image
            case .littleImage:
                HStack(alignment: .top, spacing: 6) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title.uppercased())
                            .font(Font.custom("Rubik", size: 20).weight(.medium))
                            .foregroundColor(Color(hex: "1D1D1D"))
                        
                        Text(content)
                            .font(Font.custom("Rubik", size: 18).weight(.light))
                            .foregroundColor(Color(hex: "1D1D1D"))
                    }
                    
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
                        .font(Font.custom("Rubik", size: 20).weight(.medium))
                        .foregroundColor(Color(hex: "1D1D1D"))
                    
                    Text(content)
                        .font(Font.custom("Rubik", size: 18).weight(.light))
                        .foregroundColor(Color(hex: "1D1D1D"))
                    
                    
                    HStack(alignment: .center) {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 280)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                }
            
            case .veryBigImage:
                VStack(alignment: .leading, spacing: 6) {
                    HStack(alignment: .center) {
                        if let image = image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 280, height: 280)
                                .clipped()
                                .cornerRadius(12)
                        }
                    }
                    
                    Text(title.uppercased())
                        .font(Font.custom("Rubik", size: 20).weight(.medium))
                        .foregroundColor(Color(hex: "1D1D1D"))
                }
            }
        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
        .frame(maxWidth: .infinity)
        .background(Color(hex: "C7C7C7"))
        .cornerRadius(18)
        .padding(.horizontal, 16)
    }
}


#Preview {
    VStack(spacing: 20) {
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
}

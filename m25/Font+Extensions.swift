//
//  Font+Extensions.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.21.
//

import Foundation
import SwiftUI

extension Font {
    static let xLargeHeadline = Font.custom("Rubik-Medium", size: 32)
    static let largeHeadline  = Font.custom("Rubik-Medium", size: 28)
    static let headline       = Font.custom("Rubik-Medium", size: 24)
    static let smallHeadline  = Font.custom("Rubik-Medium", size: 20)
    static let xSmallHeadline = Font.custom("Rubik-Medium", size: 16)
    static let xXSmallHeadline = Font.custom("Rubik-Medium", size: 14)
    
    static let xlargeBodytext = Font.custom("Rubik-Light", size: 24)
    static let largeBodytext  = Font.custom("Rubik-Light", size: 22)
    static let bodyText       = Font.custom("Rubik-Light", size: 20)
    static let bodyTextItalic = Font.custom("Rubik-LightItalic", size: 20)
    static let bodyTextBold   = Font.custom("Rubik-Bold", size: 20)
    static let smallBodyText  = Font.custom("Rubik-Light", size: 16)
    static let xSmallBodyText = Font.custom("Rubik-Light", size: 14)
}

extension Font {
        // Approximate line heights for each custom font style.
        // Useful for calculating min/max frame heights (e.g., in multi-line text blocks).
    static func lineHeight(for font: Font) -> CGFloat {
        switch font {
        case .xLargeHeadline:  return 40
        case .largeHeadline:   return 36
        case .headline:        return 32
        case .smallHeadline:   return 28
        case .xSmallHeadline:  return 22
        case .xXSmallHeadline: return 20
            
        case .xlargeBodytext:  return 32
        case .largeBodytext:   return 28
        case .bodyText, .bodyTextItalic, .bodyTextBold: return 26
        case .smallBodyText:   return 22
        case .xSmallBodyText:  return 20
            
        default: return 24 // fallback safe line height
        }
    }
}

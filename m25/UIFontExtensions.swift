//
//  UIFontExtensions.swift
//  m25
//
//  Created by Jiaqi Yi on 2025.10.21.
//

import Foundation
import UIKit

extension UIFont {
    static func rubik(_ weight: String, size: CGFloat) -> UIFont {
        return UIFont(name: "Rubik-\(weight)", size: size)!
    }
    
    static var rubikLight24: UIFont { rubik("Light", size: 24) }
    static var rubikMedium24: UIFont { rubik("Medium", size: 24) }
    static var rubikMedium32: UIFont { rubik("Medium", size: 32) }
    static var rubikLight20: UIFont { rubik("Light", size: 20) }
}

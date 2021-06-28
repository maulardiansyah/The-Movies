//
//  Font.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

enum FontSize
{
    case xxsmall
    case xsmall
    case small
    case normal
    case medium
    case large
    case xlarge
    case x40
    case x48
    
    var value: CGFloat {
        switch self {
        case .xxsmall: return 10
        case .xsmall: return 12
        case .small: return 14
        case .normal: return 16
        case .medium: return 18
        case .large: return 24
        case .xlarge: return 28
        case .x40: return 40
        case .x48: return 48
        }
    }
}

extension UIFont
{
    class func system(_ size: FontSize, weight: Weight = .regular) -> UIFont {
        return  UIFont.systemFont(ofSize: size.value, weight: weight)
    }
}


//
//  Colors.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit.UIColor

extension UIColor
{
    class public var green: UIColor { UIColor.UIColorRGB(rgbValue: 0x279B24) }
    class public var darkBlue: UIColor { UIColor.UIColorRGB(rgbValue: 0x1b2769) }
    class public var gray: UIColor { UIColor.UIColorRGB(rgbValue: 0x666666) }
    
    class func UIColorRGB(rgbValue: UInt) -> UIColor
    {
        return UIColor(
            displayP3Red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0))
    }
}

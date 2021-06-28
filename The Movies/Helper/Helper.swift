//
//  Helper.swift
//  The Movies
//
//  Created by Maul on 28/06/21.
//

import UIKit

public class Helper
{
    class func getBottomPadding() -> CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.bottom ?? 0
    }
    
    class func getTopPadding() -> CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.safeAreaInsets.top ?? 0
    }
}

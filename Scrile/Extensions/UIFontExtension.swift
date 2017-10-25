//
//  UIFontExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 24/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let vagThin = "VAGRoundedStd-Thin"
    static let vagBold = "VAGRoundedStd-Bold"
    
    static func vagBold(size: CGFloat) -> UIFont {
        return UIFont(name: vagBold, size: size)!
    }
    
    static func vagThin(size: CGFloat) -> UIFont {
        return UIFont(name: vagThin, size: size)!
    }
}

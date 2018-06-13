//
//  UIFontExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 24/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let quickSandLight = "Quicksand-Light"
    static let quickSandMedium = "Quicksand-Medium"
    static let quickSandRegular = "Quicksand-Regular"
    static let quickSandBold = "Quicksand-Bold"
    
    static func font1Light(size: Double) -> UIFont { return UIFont(name: quickSandLight, size: CGFloat(size))! }
    static func font1Medium(size: Double) -> UIFont { return UIFont(name: quickSandMedium, size: CGFloat(size))! }
    static func font1Regular(size: Double) -> UIFont { return UIFont(name: quickSandRegular, size: CGFloat(size))! }
    static func font1Bold(size: Double) -> UIFont { return UIFont(name: quickSandBold, size: CGFloat(size))! }
}

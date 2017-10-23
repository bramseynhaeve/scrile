//
//  UIColorExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 13/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension UIColor {
    func changedBrightness(byPercentage perc: CGFloat) -> UIColor? {
        if perc == 0 {
            return self.copy() as? UIColor
        }
        
        guard let hsba = hsba() else { return nil }
        let percentage: CGFloat = min(max(perc, -1), 1)
        let newBrightness = min(max(hsba.brightness + percentage, -1), 1)
        return UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: newBrightness, alpha: hsba.alpha)
    }
    
    func hsba() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)? {
        var hue: CGFloat = .nan,
            saturation: CGFloat = .nan,
        	brightness: CGFloat = .nan,
            alpha: CGFloat = .nan
        
        guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { return nil }
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    public func lightened(byPercentage percentage: CGFloat = 0.1) -> UIColor? {
        return changedBrightness(byPercentage: percentage)
    }
    
    public func darkened(byPercentage percentage: CGFloat = 0.1) -> UIColor? {
        return changedBrightness(byPercentage: -percentage)
    }
}

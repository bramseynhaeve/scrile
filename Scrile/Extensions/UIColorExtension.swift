//
//  UIColorExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 13/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension UIColor {

    static var tile: UIColor { return UIColor(hex: "00A36C") }

    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }

    func changedBrightness(byPercentage perc: CGFloat) -> UIColor {
        if perc == 0 {
            return self
        }
        
        let hsba = self.hsba()
        let percentage: CGFloat = min(max(perc, -1), 1)
        let newBrightness = min(max(hsba.brightness + percentage, -1), 1)
        return UIColor(hue: hsba.hue, saturation: hsba.saturation, brightness: newBrightness, alpha: hsba.alpha)
    }
    
    func hsba() -> (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = .nan,
            saturation: CGFloat = .nan,
        	brightness: CGFloat = .nan,
            alpha: CGFloat = .nan
        
        guard self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) else { fatalError("Failed to get color values") }
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    func rgba() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = .nan,
        green: CGFloat = .nan,
        blue: CGFloat = .nan,
        alpha: CGFloat = .nan

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { fatalError("Failed to get color values") }
        return (red: red, green: green, blue: blue, alpha: alpha)
    }

    public func lightened(byPercentage percentage: CGFloat = 0.1) -> UIColor {
        return changedBrightness(byPercentage: percentage)
    }
    
    public func darkened(byPercentage percentage: CGFloat = 0.1) -> UIColor {
        return changedBrightness(byPercentage: -percentage)
    }
    
//    public func p3() -> UIColor {
//        return self
//        let colorInfo = self.rgba()
//        return UIColor(displayP3Red: colorInfo.red, green: colorInfo.green, blue: colorInfo.blue, alpha: colorInfo.alpha)
//    }
    
    func grayscale(maxWhite: CGFloat = 1, minWhite: CGFloat = 0) -> UIColor {
        var grayscale: CGFloat = 0
        var alpha: CGFloat = 0
        self.getWhite(&grayscale, alpha: &alpha)
        return UIColor(white: max(minWhite, min(maxWhite, grayscale)), alpha: alpha)
    }
    
    public var image: UIImage {
        return self.image()
    }
    
    public func image(with size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        
        guard let context = UIGraphicsGetCurrentContext() else { fatalError("Failed to get context") }
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let generatedImage = image else { fatalError("Failed to generate image") }
        return generatedImage
    }
}

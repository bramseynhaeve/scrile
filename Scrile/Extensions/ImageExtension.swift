//
//  ImageExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 02/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

extension UIImage {
    public func maskWithColor(color: UIColor) -> UIImage {
        guard let maskImage = cgImage else { fatalError("Failed to get image") }
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        guard
            let cgImage = cgImage
        else { fatalError("Failed to generate image") }
        
        let coloredImage = UIImage(cgImage: cgImage)
        return coloredImage
    }
}

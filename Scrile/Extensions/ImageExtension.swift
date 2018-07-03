//
//  ImageExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 02/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

extension UIColor {
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

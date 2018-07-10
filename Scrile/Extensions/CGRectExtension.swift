//
//  CGRectExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 13/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
    }

    func distanceToBorder(forAngle angle: CGFloat) -> CGFloat {
        let borderPoint = self.borderPoint(for: angle)
        return self.center.distance(borderPoint)
    }

    func borderPoint(for angle: CGFloat) -> CGPoint {

        let halfHeight = height / 2
        let halfWidth = width / 2
        let halfPi = CGFloat.pi / 2 // Quarter of a circle
        let verticalOffsetFromCenter = halfWidth * tan(angle)
        let horizontalOffsetFromCenter = halfHeight * tan(halfPi - angle)

        let topLeftFlipAngle = atan2(-midY, -midX)
        let bottomLeftFlipAngle = atan2(height - midY, -midX)
        let topRightFlipAngle = atan2(-midY, width - midX)
        let bottomRightFlipAngle = atan2(height - midY, width - midX)

        var xPos = halfWidth + horizontalOffsetFromCenter
        var yPos = halfHeight + verticalOffsetFromCenter

        if angle < topRightFlipAngle && angle > topLeftFlipAngle {
            yPos = 0
            xPos = width - xPos
        } else if angle > topRightFlipAngle && angle < bottomRightFlipAngle {
            xPos = width
        } else if angle > bottomRightFlipAngle && angle < bottomLeftFlipAngle {
            yPos = height
        } else {
            xPos = 0
            yPos = height - yPos
        }

        return CGPoint(x: xPos, y: yPos)
    }
}

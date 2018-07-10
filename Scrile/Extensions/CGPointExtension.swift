//
//  CGPointExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 03/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

extension CGPoint {
    func distance(_ point: CGPoint) -> CGFloat { return sqrt(pow(self.x - point.x, 2) + pow(self.y - point.y, 2)) }
    func angle(_ point: CGPoint) -> CGFloat { return atan2(point.y - self.y, point.x - self.x) }

    func point(angle: CGFloat, distance: CGFloat) -> CGPoint {
        let xPos = x + (cos(angle) * distance)
        let yPos = y + (sin(angle) * distance)
        return CGPoint(x: xPos, y: yPos)
    }
}

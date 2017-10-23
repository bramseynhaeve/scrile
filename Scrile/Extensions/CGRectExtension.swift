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
}

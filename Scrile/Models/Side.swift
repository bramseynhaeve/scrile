//
//  Side.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

struct Side: OptionSet {
    let rawValue: Int
    
    static let left = Side(rawValue: 1 << 1)
    static let top = Side(rawValue: 1 << 2)
    static let right = Side(rawValue: 1 << 3)
    static let bottom = Side(rawValue: 1 << 4)
    static let middle = Side(rawValue: 1 << 5)
}

extension Side {
    func flyOffset(size: CGSize) -> CGSize {
        
        switch (self) {
        case [.left, .top]:
            return arc4random_uniform(2) == 0 ? CGSize(width: -size.width, height: 0) : CGSize(width: 0, height: -size.height)
        case [.right, .top]:
            return arc4random_uniform(2) == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: 0, height: -size.height)
        case [.left, .bottom]:
            return arc4random_uniform(2) == 0 ? CGSize(width: -size.width, height: 0) : CGSize(width: 0, height: size.height)
        case [.right, .bottom]:
            return arc4random_uniform(2) == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: 0, height: size.height)
        case .left:
            return CGSize(width: -size.width, height: 0)
        case .top:
            return CGSize(width: 0, height: -size.height)
        case .right:
            return CGSize(width: size.width, height: 0)
        case .bottom:
            return CGSize(width: 0, height: size.height)
        default:
            return CGSize.zero
        }
    }
    
    func color() -> UIColor {
        switch (self) {
        case [.middle, .top]:
            return UIColor.yellow.darkened(byPercentage: 0.3)!
        case [.middle, .bottom]:
            return UIColor.blue.darkened(byPercentage: 0.3)!
        case [.left, .top]:
            return .orange
        case [.right, .top]:
            return .brown
        case [.left, .bottom]:
            return .purple
        case [.right, .bottom]:
            return .cyan
        case .left:
            return .red
        case .top:
            return .yellow
        case .right:
            return .green
        case .bottom:
            return .blue
        default:
            return .gray
        }
    }
}

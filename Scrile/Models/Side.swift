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
    
    static let topLeft: Side = [.left, .top]
    static let topRight: Side = [.right, .top]
    static let bottomLeft: Side = [.left, .bottom]
    static let bottomRight: Side = [.right, .bottom]

    static let topMiddle: Side = [.left, .right, .top]
    static let bottomMiddle: Side = [.left, .right, .bottom]
    static let middle: Side = [.left, .right, .top, .bottom]
    
}

extension Side {
    func flyOffset(size: CGSize) -> CGSize {
        
        self.randomDirection()
        
        switch (self) {
        case .topMiddle:
            let random = arc4random_uniform(3)
            
            //left or right
            let offset = random == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: -size.width, height: 0)
            
            //or up
            return random == 2 ? CGSize(width: 0, height: -size.height) : offset
        case .bottomMiddle:
            let random = arc4random_uniform(3)
            
            //left or right
            let offset = random == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: -size.width, height: 0)
            
            //or down
            return random == 2 ? CGSize(width: 0, height: size.height) : offset
        case .topLeft:
            return arc4random_uniform(2) == 0 ? CGSize(width: -size.width, height: 0) : CGSize(width: 0, height: -size.height)
        case .topRight:
            return arc4random_uniform(2) == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: 0, height: -size.height)
        case .bottomLeft:
            return arc4random_uniform(2) == 0 ? CGSize(width: -size.width, height: 0) : CGSize(width: 0, height: size.height)
        case .bottomRight:
            return arc4random_uniform(2) == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: 0, height: size.height)
        case .left:
            return CGSize(width: -size.width, height: 0)
        case .top:
            return CGSize(width: 0, height: -size.height)
        case .right:
            return CGSize(width: size.width, height: 0)
        case .bottom:
            return CGSize(width: 0, height: size.height)
        case .middle:
            let random = arc4random_uniform(4)
            
            //left or right
            let offset = random == 0 ? CGSize(width: size.width, height: 0) : CGSize(width: -size.width, height: 0)
            
            //or up
            return random == 2 ? CGSize(width: 0, height: -size.height) : offset
        default:
            return CGSize.zero
        }
    }
    
    func color() -> UIColor {
        switch (self) {
        case .topMiddle:
            return UIColor.yellow.darkened(byPercentage: 0.3)!
        case .bottomMiddle:
            return UIColor.blue.darkened(byPercentage: 0.3)!
        case .topLeft:
            return .orange
        case .topRight:
            return .brown
        case .bottomLeft:
            return .purple
        case .bottomRight:
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

//
//  Side.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

enum Direction {
    case left
    case right
    case up
    case down
}

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
        
        switch self.randomDirection() {
        case .left:
            return CGSize(width: -size.width, height: 0)
        case .up:
            return CGSize(width: 0, height: -size.height)
        case .right:
            return CGSize(width: size.width, height: 0)
        case .down:
            return CGSize(width: 0, height: size.height)
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
    
    func randomDirection() -> Direction {
        switch (self) {
        case .topMiddle:
            return [.left, .up, .right].randomItem
        case .bottomMiddle:
            return [.left, .down, .right].randomItem
        case .topLeft:
            return [.left, .up].randomItem
        case .topRight:
            return [.up, .right].randomItem
        case .bottomLeft:
            return [.left, .down].randomItem
        case .bottomRight:
            return [.down, .right].randomItem
        case .left:
            return .left
        case .top:
            return .up
        case .right:
            return .right
        case .bottom:
            return .down
        default:
            return [.left, .up, .right, .down].randomItem
        }
    }
}

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
    
    static let none = Side(rawValue: 0)
    
    static let left = Side(rawValue: 1 << 0)
    static let top = Side(rawValue: 1 << 1)
    static let right = Side(rawValue: 1 << 2)
    static let bottom = Side(rawValue: 1 << 3)
    
    static let leaningTop = Side(rawValue: 1 << 4)
    static let leaningBottom = Side(rawValue: 1 << 5)
    
    static let topLeft: Side = [.left, .top]
    static let topRight: Side = [.right, .top]
    static let topLeftRight: Side = [.left, .top, .right]
    static let bottomLeft: Side = [.left, .bottom]
    static let bottomRight: Side = [.right, .bottom]
    static let bottomLeftRight: Side = [.left, .bottom, .right]
}

extension Side {
    func flyOffset(size: CGSize) -> CGSize {
        
        var multiplier:CGFloat = 1.0
        switch self {
        case .leaningTop, .leaningBottom:
            multiplier = 2.2
        case .none:
            multiplier = 3.3
        default:
            multiplier = 1.1
        }
        
        switch self.randomDirection() {
        case .left:
            return CGSize(width: -size.width * multiplier, height: 0)
        case .up:
            return CGSize(width: 0, height: -size.height * multiplier)
        case .right:
            return CGSize(width: size.width * multiplier, height: 0)
        case .down:
            return CGSize(width: 0, height: size.height * multiplier)
        }
    }
    
    func color() -> UIColor {
        switch (self) {
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
        case .top, .topLeftRight:
            return .yellow
        case .right:
            return .green
        case .bottom, .bottomLeftRight:
            return .blue
        case .leaningTop:
            return UIColor.yellow.darkened(byPercentage: 0.4)
        case .leaningBottom:
            return UIColor.blue.darkened(byPercentage: 0.4)
        default:
            return .gray
        }
    }
    
    func randomDirection() -> Direction {
        switch (self) {
        case .topLeft:
            return [.left, .up].randomItem
        case .topRight:
            return [.up, .right].randomItem
        case .bottomLeft:
            return [.left, .down].randomItem
        case .bottomRight:
            return [.down, .right].randomItem
        case .topLeftRight:
            return [.left, .up, .right].randomItem
        case .bottomLeftRight:
            return [.left, .down, .right].randomItem
        case .left:
            return .left
        case .top:
            return .up
        case .right:
            return .right
        case .bottom:
            return .down
        case .leaningTop:
            return [.left, .up, .right].randomItem
        case .leaningBottom:
            return [.left, .down, .right].randomItem

        default:
            return [.left, .up, .right, .right].randomItem
        }
    }
    
    func isAtBorder() -> Bool {
        return contains(.left) || contains(.top) || contains(.right) || contains(.bottom)
    }
}

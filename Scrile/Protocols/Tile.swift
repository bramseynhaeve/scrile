//
//  Tile.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import UIKit

enum TileType {
    case number(Float)
    case hiddenNumber(Float)
    
    case text(String)
    case hiddenText(String)
    
    case option(OptionType)
    case hiddenOption(OptionType)
    
    case numberResult(Float)
    case textResult(String)
    case optionResult(OptionType)

    func result() -> TileType {
        switch self {
        case .number(let number), .hiddenNumber(let number): return .numberResult(number)
        case .text(let size), .hiddenText(let size): return .textResult(size)
        case .option(let option), .hiddenOption(let option): return .optionResult(option)
        default:
            fatalError("Invalid hide type")
        }
    }

    func hide() -> TileType {
        switch self {
        case .number(let number): return .hiddenNumber(number)
        case .text(let size): return .hiddenText(size)
        case .option(let option): return .hiddenOption(option)
        case .hiddenNumber, .hiddenText: return self
        default:
            fatalError("Invalid hide type")
        }
    }

    func color() -> UIColor {
        switch self {
        case .number(_), .text(_):
            return UserDefaults.standard.userColor()
        case .numberResult(_), .textResult(_), .optionResult(_):
            return UIColor.white
        case .hiddenNumber(_), .hiddenText(_), .hiddenOption(_):
            return UserDefaults.standard.userColor().grayscale(maxWhite: 0.5)
        case .option(let option):
            return option.color
        }
    }
}

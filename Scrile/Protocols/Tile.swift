//
//  Tile.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

enum TileType {
    case number(Float)
    case hiddenNumber(Float)
    
    case tshirtSize(String)
    case hiddenTshirtSize(String)
    
    case numberResult(Float)
    case tshirtResult(String)

    case option(OptionType)

    func result() -> TileType {
        switch self {
        case .number(let number), .hiddenNumber(let number): return .numberResult(number)
        case .tshirtSize(let size), .hiddenTshirtSize(let size): return .tshirtResult(size)
        default:
            fatalError("Invalid hide type")
        }
    }

    func hide() -> TileType {
        switch self {
        case .number(let number): return .hiddenNumber(number)
        case .tshirtSize(let size): return .hiddenTshirtSize(size)
        case .hiddenNumber, .hiddenTshirtSize: return self
        default:
            fatalError("Invalid hide type")
        }
    }
}

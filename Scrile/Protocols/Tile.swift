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
    case result(Float)
    case option(OptionType)
}

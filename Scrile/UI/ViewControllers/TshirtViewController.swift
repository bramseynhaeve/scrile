//
//  TshirtViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import Foundation

class TshirtViewController: TileCollectionViewController {
    init() {

        let numbers = ["XXS", "XS", "S", "M", "L", "XL", "XXL"].map { (size) -> TileType in
            return TileType.tshirtSize(size)
        }

        let options = [OptionType.tshirt, OptionType.color].map { (type) -> TileType in
            return TileType.option(type)
        }

        let tiles = numbers + options
        super.init(tiles: tiles)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

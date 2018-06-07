//
//  NumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import Foundation

class NumberViewController: TileCollectionViewController {
    init() {

        let numbers = Array(0...User.numberTileCount).map { (index) -> TileType in
            return TileType.number(index.scrumFibonacci())
        }

        let options = [OptionType.tshirt, OptionType.coffee].map { (type) -> TileType in
            return TileType.option(type)
        }

        let tiles = numbers + options
        super.init(tiles: tiles)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

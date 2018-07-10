//
//  NumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class NumberViewController: TileCollectionViewController {

    init(color: UIColor) {
        let numbers = Array(0..<User.numberTileCount).map { (index) -> TileType in
            return TileType.number(index.scrumFibonacci())
        }

        let options = [OptionType.coffee, OptionType.tshirt, OptionType.color, OptionType.settings, OptionType.info].map { (type) -> TileType in
            return TileType.option(type)
        }

        let tiles = numbers + options
        super.init(tiles: tiles, color: color)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.layoutSubviews()
        navigationController?.viewControllers = [self]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

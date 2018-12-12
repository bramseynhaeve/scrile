//
//  TshirtViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class TshirtViewController: TileCollectionViewController {
    init(color: UIColor) {

        let numbers = User.tshirtSizes.map { (size) -> TileType in
            return TileType.tshirtSize(size)
        }

        let options = [OptionType.coffee, OptionType.numbers, OptionType.color, OptionType.settings, OptionType.info].map { (type) -> TileType in
            return TileType.option(type)
        }

        let tiles = numbers + options
        super.init(tiles: tiles, color: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UserDefaults.standard.saveUserFlow(.tshirt)
        navigationController?.viewControllers = [self]
    }
}

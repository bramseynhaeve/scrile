//
//  ResultCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultCollectionViewController: TileCollectionViewController {

    init(result: TileType, numberOfTiles: Int) {
        let tiles = Array(0..<numberOfTiles).map { (_) -> TileType in
            return result
        }

        super.init(tiles: tiles, color: UIColor.white)

        collectionView?.isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

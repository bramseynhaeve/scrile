//
//  ResultCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultCollectionViewController: TileCollectionViewController {

    init(result: Int, numberOfTiles: Int) {

        let tiles = Array(0..<numberOfTiles).map { (_) -> ResultTile in
            return ResultTile(result: result)
        }

        super.init(tiles: tiles)

        collectionView?.isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

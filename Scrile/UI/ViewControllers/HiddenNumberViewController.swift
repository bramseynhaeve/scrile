//
//  HiddenNumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class HiddenNumberViewController: TileCollectionViewController {

    let result: Int

    init(result: Int, numberOfTiles: Int) {

        let tiles = Array(0..<numberOfTiles).map { (_) -> BlankTile in
            return BlankTile(color: UIColor.gray, number: result)
        }

        self.result = result
        super.init(tiles: tiles)

        collectionView?.isScrollEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

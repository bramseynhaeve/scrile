//
//  HiddenNumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class HiddenNumberViewController: TileCollectionViewController {
    
    fileprivate let result: TileType

    init(result: TileType, numberOfTiles: Int) {
        self.result = result
        
        let tiles = Array(0..<numberOfTiles).map { (_) -> TileType in
            return result
        }

        super.init(tiles: tiles, color: UIColor.darkGray)

        collectionView.isScrollEnabled = false
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            handleTile(result)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

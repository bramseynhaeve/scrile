//
//  HiddenNumberTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class HiddenNumberTileCollectionViewCell: TileCollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.green
    }
}

//
//  InActiveCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class InActiveCollectionViewCell: TileCollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.red.darkened(byPercentage: 0.5)
    }
}

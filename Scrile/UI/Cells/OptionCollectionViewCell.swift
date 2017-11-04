//
//  OptionCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: TileCollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.orange
    }
}

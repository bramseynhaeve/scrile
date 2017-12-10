//
//  TileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutTile()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        transform = CGAffineTransform.identity
    }
    
    func layoutTile() {
        backgroundColor = UIColor.darkGray
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

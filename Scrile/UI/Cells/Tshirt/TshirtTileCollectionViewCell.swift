//
//  TshirtTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class TshirtTileCollectionViewCell: TileCollectionViewCell {

    fileprivate let tshirtSizeLabel = UILabel()
    
    static var reuseID: String {
        return String(describing: self)
    }

    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.red

        tshirtSizeLabel.font = UIFont.font1Light(size: 50)
        tshirtSizeLabel.textColor = .white
        tshirtSizeLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tshirtSizeLabel)

        tshirtSizeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tshirtSizeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func setSize(_ size: String) {
        tshirtSizeLabel.text = size
    }
}

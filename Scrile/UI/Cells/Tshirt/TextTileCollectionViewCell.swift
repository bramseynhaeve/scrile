//
//  TextTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import UIKit

class TextTileCollectionViewCell: TileCollectionViewCell {

    fileprivate let textLabel = UILabel()
    
    static var reuseID: String {
        return String(describing: self)
    }

    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.red

        textLabel.font = UIFont.font1Light(size: 50)
        textLabel.textColor = .white
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        addSubview(textLabel)

        textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    func setText(_ text: String) {
        textLabel.text = text
    }
}

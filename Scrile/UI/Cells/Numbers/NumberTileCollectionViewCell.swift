//
//  StringTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class NumberTileCollectionViewCell: TileCollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    fileprivate let numberLabel: UILabel = UILabel()
    
    var number: Float = 0.0 {
        didSet {
            let format = number > 0 && number < 1 ? "%.1f" : "%.0f"
            numberString = String(format: format, number)
        }
    }
    
    var numberString: String = "" {
        didSet {
            numberLabel.text = numberString
        }
    }
    
    var result: String? {
        return numberLabel.text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        layoutTile()
        
        numberLabel.text = ""
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        numberLabel.font = UIFont.font1Light(size: 50)
        numberLabel.textColor = .white
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(numberLabel)
        
        numberLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

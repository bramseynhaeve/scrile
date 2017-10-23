//
//  NumberTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class NumberTileCollectionViewCell: UICollectionViewCell {
    
    fileprivate let numberLabel: UILabel = UILabel()
    var number: Float = 0.0 {
        didSet {
            let format = number > 0 && number < 1 ? "%.1f" : "%.0f"
            numberLabel.text = String(format: format, number)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()        
        numberLabel.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutTile()
    }
    
    fileprivate func layoutTile() {
        backgroundColor = UIColor.red
        
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        numberLabel.text = "1"
        numberLabel.font = .systemFont(ofSize: 50)
        numberLabel.textColor = .white
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(numberLabel)
        
        //TODO add pureLayout
        let labelCenterX = NSLayoutConstraint(item: numberLabel,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0.0)
        
        let labelCenterY = NSLayoutConstraint(item: numberLabel,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0.0)
        
        addConstraints([labelCenterX, labelCenterY])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

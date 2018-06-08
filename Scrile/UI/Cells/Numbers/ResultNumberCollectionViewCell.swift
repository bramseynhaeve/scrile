//
//  ChosenNumberCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultNumberCollectionViewCell: TileCollectionViewCell {
    
    let fontSize: Double = 480
    let baseLineFactor: Double = 0.0625
    let numberLabel = UILabel()
    var result: String = "" {
        didSet {
            let adjustmentFactor = max((1 - (0.23 * Double(result.count - 1))), 0)
            let baselineOffset = -fontSize * (baseLineFactor * adjustmentFactor)
            let attributedString = NSAttributedString(string: result, attributes: [NSAttributedStringKey.baselineOffset: baselineOffset])
            
            numberLabel.attributedText = attributedString
//            numberLabel.font = UIFont.vagThin(size: fontSize * adjustmentFactor)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textAlignment = .center
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.baselineAdjustment = .alignCenters
        numberLabel.numberOfLines = 1
        numberLabel.minimumScaleFactor = 0.3
        numberLabel.font = UIFont.vagThin(size: fontSize)
        numberLabel.textColor = UIColor.red

        addSubview(numberLabel)
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }

        numberLabel.centerXAnchor.constraint(equalTo: newSuperview.centerXAnchor).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: newSuperview.centerYAnchor).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: newSuperview.leftAnchor, constant: 0).isActive = true
        numberLabel.rightAnchor.constraint(equalTo: newSuperview.rightAnchor, constant: 0).isActive = true
        numberLabel.backgroundColor = UIColor.black.withAlphaComponent(0.01)
    }
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func layoutTile() {
        super.layoutTile()
//        layer.cornerRadius = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  ResultTshirtCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class ResultTshirtCollectionViewCell: TileCollectionViewCell {

    let fontSize: Double = 480
    let baseLineFactor: Double = 0.0625
    let numberLabel = UILabel()
    var result: String = "" {
        didSet {
            let adjustmentFactor = max((1 - (0.23 * Double(result.count - 1))), 0)
            let baselineOffset = -fontSize * (baseLineFactor * adjustmentFactor)
            let attributedString = NSAttributedString(string: result, attributes: [NSAttributedStringKey.baselineOffset: baselineOffset])

            numberLabel.attributedText = attributedString
            numberLabel.font = UIFont.vagThin(size: fontSize * adjustmentFactor)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.vagThin(size: fontSize)
        numberLabel.textColor = UIColor.red

        addSubview(numberLabel)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }

        let centerXConstraint = NSLayoutConstraint(item: numberLabel, attribute: .centerX, relatedBy: .equal, toItem: newSuperview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: numberLabel, attribute: .centerY, relatedBy: .equal, toItem: newSuperview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leftConstraint = NSLayoutConstraint(item: numberLabel, attribute: .left, relatedBy: .greaterThanOrEqual, toItem: newSuperview, attribute: .left, multiplier: 1.0, constant: 0.0)
        let rightConstraint = NSLayoutConstraint(item: numberLabel, attribute: .right, relatedBy: .greaterThanOrEqual, toItem: newSuperview, attribute: .right, multiplier: 1.0, constant: 0.0)

        newSuperview.addConstraints([centerXConstraint, centerYConstraint, leftConstraint, rightConstraint])

        numberLabel.sizeToFit()
    }

    static var reuseID: String {
        return String(describing: self)
    }

    override func layoutTile() {
        super.layoutTile()
        layer.cornerRadius = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  TileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class TileCollectionViewCell: UICollectionViewCell {

    fileprivate let borderOffset:CGFloat = 2.0
    fileprivate let cornerRadius:CGFloat = 2.0

    let backgroundContainer: UIView = UIView()
    var widthConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var heightConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var color = UIColor.tile {
        didSet { backgroundColor = color }
    }

    override var backgroundColor: UIColor? {
        set {
            backgroundContainer.backgroundColor = newValue
        }

        get {
            return backgroundContainer.backgroundColor
        }
    }

    var actionViewController: UIViewController {
        return UIViewController()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutTile()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        backgroundColor = color
        transform = CGAffineTransform.identity
    }

    func showBorder() {
        widthConstraint.constant = -borderOffset
        heightConstraint.constant = -borderOffset
        backgroundContainer.layer.cornerRadius = cornerRadius
    }

    func hideBorder() {
        widthConstraint.constant = 0
        heightConstraint.constant = 0
        backgroundContainer.layer.cornerRadius = 0
    }
    
    func layoutTile() {
        addSubview(backgroundContainer)
        layer.masksToBounds = true
        
        backgroundContainer.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainer.layer.cornerRadius = cornerRadius
        backgroundContainer.layer.masksToBounds = true

        backgroundContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        backgroundContainer.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        widthConstraint = backgroundContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -borderOffset)
        heightConstraint = backgroundContainer.heightAnchor.constraint(equalTo: heightAnchor, constant: -borderOffset)

        widthConstraint.isActive = true
        heightConstraint.isActive = true
    }

    func addBorder() {

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

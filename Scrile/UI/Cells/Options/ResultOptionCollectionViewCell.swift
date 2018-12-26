//
//  ResultOptionCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/12/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import Foundation
import UIKit

class ResultOptionCollectionViewCell: TileCollectionViewCell {
    let resultView = UIImageView()
    
    var result: OptionType = .empty {
        didSet {
            // set option image
            let newImage = result.image.withRenderingMode(.alwaysTemplate)
            resultView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        resultView.contentMode = .scaleAspectFit
        resultView.tintColor = UserDefaults.standard.userColor()
        backgroundContainer.addSubview(resultView)
    }
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func layoutTile() {
        super.layoutTile()
        hideBorder()
    }
    
    override func didMoveToSuperview() {
        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.centerXAnchor.constraint(equalTo: newSuperview.centerXAnchor).activate()
        resultView.centerYAnchor.constraint(equalTo: newSuperview.centerYAnchor).activate()
        resultView.heightAnchor.constraint(equalTo: newSuperview.heightAnchor, multiplier: 0.55).activate()
        resultView.widthAnchor.constraint(equalTo: newSuperview.widthAnchor, multiplier: 0.55).activate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MainFlowLayout.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class MainFlowLayout: UICollectionViewFlowLayout {
    
    let numberOfHorizontalItems: Int = 3
    let numberOfVerticalItems: Int = 4
    
    override init() {
        super.init()
        
        minimumLineSpacing = 0.0
        minimumInteritemSpacing = 0.0
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = newValue
        }
        get {
            guard let collectionView = collectionView else { return CGSize.zero }
            
            let viewWidth = collectionView.frame.width
            let viewHeight = collectionView.frame.height - 40
            let numberOfHorizontalSeperators = numberOfHorizontalItems - 1
            let numberOfVerticalSeperators = numberOfVerticalItems - 1
            let tileWidth = (viewWidth - CGFloat(Int(minimumInteritemSpacing) * numberOfHorizontalSeperators)) / CGFloat(numberOfHorizontalItems)
            let tileHeight = (viewHeight - CGFloat(Int(minimumLineSpacing) * numberOfVerticalSeperators)) / CGFloat(numberOfVerticalItems)
            
            return CGSize(width: tileWidth, height: tileHeight)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

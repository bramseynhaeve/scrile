//
//  TileCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class TileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let flowLayout = MainFlowLayout()

    init() {
        super.init(collectionViewLayout: flowLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.clear
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        let totalNumberOfTiles = User.numberTileCount + User.optionTileCount
        let numberOfSections = Int(ceil(Double(totalNumberOfTiles) / Double(flowLayout.numberOfHorizontalItems)))
        
        return numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalNumberOfTiles = User.numberTileCount + User.optionTileCount
        let restTiles = totalNumberOfTiles % flowLayout.numberOfHorizontalItems
        let isLastSection = section == numberOfSections(in: collectionView) - 1
        
        if isLastSection && restTiles != 0 {
            return restTiles
        }
        
        return flowLayout.numberOfHorizontalItems
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let totalNumberOfTiles = User.numberTileCount + User.optionTileCount
        let restTiles = totalNumberOfTiles % flowLayout.numberOfHorizontalItems
        let isLastSection = indexPath.section == numberOfSections(in: collectionView) - 1
        
        if isLastSection && restTiles != 0 {
            var size = flowLayout.itemSize
            let totalSpacing = flowLayout.minimumInteritemSpacing * (CGFloat(restTiles) - 1)
            size.width = (collectionView.frame.width - totalSpacing) / CGFloat(restTiles)
            
            return size
        }
        
        return flowLayout.itemSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

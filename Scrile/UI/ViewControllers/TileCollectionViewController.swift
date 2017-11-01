//
//  TileCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class TileCollectionViewController: UICollectionViewController {

    init() {
        let flowLayout = MainFlowLayout()
        super.init(collectionViewLayout: flowLayout)
        
        if #available(iOS 11.0, *) {
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            additionalSafeAreaInsets = UIEdgeInsetsMake(-statusBarHeight, 0, -statusBarHeight, 0)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15 //should be the same as the original view controllers
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  HiddenNumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let hiddenTileCellIdentifier = "hiddenTileCell"

class HiddenNumberViewController: TileCollectionViewController {
        
    let animator = FlipAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationStyle = .custom
        transitioningDelegate = animator
        
        if let collectionView = collectionView {
            collectionView.isScrollEnabled = false
            collectionView.register(HiddenNumberTileCollectionViewCell.self, forCellWithReuseIdentifier: hiddenTileCellIdentifier)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hiddenTileCellIdentifier, for: indexPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popToRootViewController(animated: true)
    }
}

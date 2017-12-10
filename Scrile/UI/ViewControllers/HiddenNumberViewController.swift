//
//  HiddenNumberViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let hiddenTileCellIdentifier = "hiddenTileCell"

class HiddenNumberViewController: ResultDependingCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.register(HiddenNumberTileCollectionViewCell.self, forCellWithReuseIdentifier: hiddenTileCellIdentifier)
            collectionView.isScrollEnabled = false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hiddenTileCellIdentifier, for: indexPath)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(ChosenNumberCollectionViewController(result: result), animated: true)
    }
}

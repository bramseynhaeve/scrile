//
//  ChosenNumberCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ChosenNumberCollectionViewController: ResultDependingCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.isScrollEnabled = false
            collectionView.register(ChosenNumberCollectionViewCell.self, forCellWithReuseIdentifier: ChosenNumberCollectionViewCell.reuseID)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChosenNumberCollectionViewCell.reuseID, for: indexPath)
        
        if let cell = cell as? ChosenNumberCollectionViewCell {
            cell.result = result
        }        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.popToRootViewController(animated: true)
    }
}

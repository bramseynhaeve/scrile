//
//  ViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 04/07/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let tileCellIdentifier = "tileCell"

class NumberCollectionViewController: TileCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.register(NumberTileCollectionViewCell.self, forCellWithReuseIdentifier: tileCellIdentifier)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tileCellIdentifier, for: indexPath)
        
        if let tileCell = cell as? NumberTileCollectionViewCell {
            tileCell.number = indexPath.row.scrumFibonacci()
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        present(ColorViewController(), animated: true, completion: nil)
        present(HiddenNumberViewController(), animated: true, completion: nil)
    }
}

//
//  TshirtCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 06/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class TshirtCollectionViewController: TileCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // reset root viewcontroller
        navigationController?.viewControllers = [self]

        if let collectionView = collectionView {
            collectionView.register(StringTileCollectionViewCell.self, forCellWithReuseIdentifier: StringTileCollectionViewCell.reuseID)
            collectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseID)
            collectionView.register(InActiveCollectionViewCell.self, forCellWithReuseIdentifier: InActiveCollectionViewCell.reuseID)
        }
    }

}

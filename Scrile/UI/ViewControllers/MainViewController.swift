//
//  ViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 04/07/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    let tileCellIdentifier = "tileCell"

    init() {
        let flowLayout = MainFlowLayout()
        super.init(collectionViewLayout: flowLayout)
        
        
        if let collectionView = collectionView {
            if #available(iOS 11.0, *) {
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                collectionView.insetsLayoutMarginsFromSafeArea = false
                additionalSafeAreaInsets = UIEdgeInsetsMake(-statusBarHeight, 0, -statusBarHeight, 0)
            }
            
            collectionView.backgroundColor = .clear
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: tileCellIdentifier)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let collectionView = collectionView else { return }
        for cell in collectionView.visibleCells {
            let _ = collectionView.side(for: cell)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tileCellIdentifier, for: indexPath)
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let colorViewController = ColorViewController()
        present(colorViewController, animated: true, completion: nil)
    }
}


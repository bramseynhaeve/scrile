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
        
        if #available(iOS 11.0, *) {
            if let collectionView = collectionView {
                collectionView.insetsLayoutMarginsFromSafeArea = false
                
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                additionalSafeAreaInsets = UIEdgeInsetsMake(-statusBarHeight, 0, -statusBarHeight, 0)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {        
        if let collectionView = collectionView {
            collectionView.register(TileCollectionViewCell.self, forCellWithReuseIdentifier: tileCellIdentifier)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else { return }
        for cell in collectionView.visibleCells {
            let side = collectionView.side(for: cell)
            cell.backgroundColor = side.color()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tileCellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.clear
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


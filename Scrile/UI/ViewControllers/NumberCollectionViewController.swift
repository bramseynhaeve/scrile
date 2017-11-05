//
//  ViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 04/07/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

enum CellType {
    case number
    case option
    case inActive
}

class NumberCollectionViewController: TileCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionView = collectionView {
            collectionView.register(NumberTileCollectionViewCell.self, forCellWithReuseIdentifier: NumberTileCollectionViewCell.reuseID)
            collectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseID)
            collectionView.register(InActiveCollectionViewCell.self, forCellWithReuseIdentifier: InActiveCollectionViewCell.reuseID)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch cellType(for: indexPath) {
        case .number:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberTileCollectionViewCell.reuseID, for: indexPath)
            
            if let tileCell = cell as? NumberTileCollectionViewCell {
                tileCell.number = index(for: indexPath).scrumFibonacci()
            }
            
            return cell
        case .option:
            return collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseID, for: indexPath)
            
        case .inActive:
            return collectionView.dequeueReusableCell(withReuseIdentifier: InActiveCollectionViewCell.reuseID, for: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch cellType(for: indexPath) {
        case .number:
            navigationController?.pushViewController(HiddenNumberViewController(), animated: true)
            
        case .option:
            navigationController?.pushViewController(ColorViewController(), animated: true)
            
        default:
            print("No action is needed here")
        
        }
    }
    
    func cellType(for indexPath:IndexPath) -> CellType {
        let cellIndex = index(for: indexPath)
        
        if cellIndex < User.numberTileCount { return .number }
        else if cellIndex < User.numberTileCount + User.optionTileCount { return .option }
        else { return .inActive }
    }
    
    func index(for indexPath: IndexPath) -> Int {
        return (indexPath.section * flowLayout.numberOfHorizontalItems) + indexPath.row
    }
}

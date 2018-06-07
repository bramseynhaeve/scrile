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
    let tiles: [TileType]

    init(tiles: [TileType]) {
        self.tiles = tiles
        super.init(collectionViewLayout: flowLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.clear

        collectionView?.register(StringTileCollectionViewCell.self, forCellWithReuseIdentifier: StringTileCollectionViewCell.reuseID)
        collectionView?.register(HiddenStringTileCollectionViewCell.self, forCellWithReuseIdentifier: HiddenStringTileCollectionViewCell.reuseID)
        collectionView?.register(ChosenNumberCollectionViewCell.self, forCellWithReuseIdentifier: ChosenNumberCollectionViewCell.reuseID)
        collectionView?.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseID)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSections = Int(ceil(Double(tiles.count) / Double(flowLayout.numberOfHorizontalItems)))
        return numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let restTiles = tiles.count % flowLayout.numberOfHorizontalItems
        let isLastSection = section == numberOfSections(in: collectionView) - 1
        
        if isLastSection && restTiles != 0 {
            return restTiles
        }
        
        return flowLayout.numberOfHorizontalItems
     }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let tile = tiles[index(for: indexPath)]

        switch tile {
        case .number(let number):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringTileCollectionViewCell.reuseID, for: indexPath)
            if let numberCell = cell as? StringTileCollectionViewCell {
                numberCell.number = number
            }

            return cell

        case .hiddenNumber:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HiddenStringTileCollectionViewCell.reuseID, for: indexPath)
            return cell

        case .result(let number):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChosenNumberCollectionViewCell.reuseID, for: indexPath)
            if let resultCell = cell as? ChosenNumberCollectionViewCell {
                resultCell.result = "\(number)"
            }
            return cell

        case .option(let type):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseID, for: indexPath)
            if let optionCell = cell as? OptionCollectionViewCell {
                optionCell.setType(type: type)
            }
            return cell

        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = tiles[index(for: indexPath)]

        switch tile {
        case .number(let number):
            let viewController = HiddenNumberViewController(result: number, numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            break

        case .hiddenNumber(let number):
            let viewController = ResultCollectionViewController(result: number, numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            break

        case .result:
            navigationController?.popToRootViewController(animated: true)
            break

        case .option(let type):
            break

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let restTiles = tiles.count % flowLayout.numberOfHorizontalItems
        let isLastSection = indexPath.section == numberOfSections(in: collectionView) - 1
        
        if isLastSection && restTiles != 0 {
            var size = flowLayout.itemSize
            let totalSpacing = flowLayout.minimumInteritemSpacing * (CGFloat(restTiles) - 1)
            size.width = (collectionView.frame.width - totalSpacing) / CGFloat(restTiles)
            
            return size
        }
        
        return flowLayout.itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Remove inset border in last row
        return section == 0 ? UIEdgeInsets.zero : flowLayout.sectionInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func index(for indexPath: IndexPath) -> Int {
        return (indexPath.section * flowLayout.numberOfHorizontalItems) + indexPath.row
    }

}

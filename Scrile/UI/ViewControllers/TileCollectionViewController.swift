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
    let tiles: [Tile]

    init(tiles: [Tile]) {
        self.tiles = tiles
        super.init(collectionViewLayout: flowLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.clear

        collectionView?.register(StringTileCollectionViewCell.self, forCellWithReuseIdentifier: StringTileCollectionViewCell.reuseID)
        collectionView?.register(HiddenStringTileCollectionViewCell.self, forCellWithReuseIdentifier: HiddenStringTileCollectionViewCell.reuseID)
        collectionView?.register(ChosenNumberCollectionViewCell.self, forCellWithReuseIdentifier: ChosenNumberCollectionViewCell.reuseID)
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
        case let numberTile as NumberTile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StringTileCollectionViewCell.reuseID, for: indexPath)
            if let numberCell = cell as? StringTileCollectionViewCell {
                numberCell.numberString = "\(numberTile.number)"
            }

            return cell

        case is BlankTile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HiddenStringTileCollectionViewCell.reuseID, for: indexPath)
            return cell

        case let resultTile as ResultTile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChosenNumberCollectionViewCell.reuseID, for: indexPath)
            if let resultCell = cell as? ChosenNumberCollectionViewCell {
                resultCell.result = "\(resultTile.result)"
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = tiles[index(for: indexPath)]

        switch tile {
        case let numberTile as NumberTile:
            let viewController = HiddenNumberViewController(result: numberTile.number, numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)

        case let blankTile as BlankTile:
            let viewController = ResultCollectionViewController(result: blankTile.number, numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)

        case is ResultTile:
            navigationController?.popToRootViewController(animated: true)

        default:
            return
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

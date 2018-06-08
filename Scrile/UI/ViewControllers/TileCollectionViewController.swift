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

        collectionView?.register(NumberTileCollectionViewCell.self, forCellWithReuseIdentifier: NumberTileCollectionViewCell.reuseID)
        collectionView?.register(HiddenTileCollectionViewCell.self, forCellWithReuseIdentifier: HiddenTileCollectionViewCell.reuseID)
        collectionView?.register(ResultNumberCollectionViewCell.self, forCellWithReuseIdentifier: ResultNumberCollectionViewCell.reuseID)
        collectionView?.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseID)
        collectionView?.register(TshirtTileCollectionViewCell.self, forCellWithReuseIdentifier: TshirtTileCollectionViewCell.reuseID)
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberTileCollectionViewCell.reuseID, for: indexPath)
            if let numberCell = cell as? NumberTileCollectionViewCell {
                numberCell.number = number
            }

            return cell

        case .numberResult(let number):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNumberCollectionViewCell.reuseID, for: indexPath)
            if let resultCell = cell as? ResultNumberCollectionViewCell {
                resultCell.result = "\(number)"
            }
            return cell

        case .tshirtSize(let size):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TshirtTileCollectionViewCell.reuseID, for: indexPath)
            if let tshirtCell = cell as? TshirtTileCollectionViewCell {
                tshirtCell.setSize(size)
            }
            return cell

        case .tshirtResult(let size):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNumberCollectionViewCell.reuseID, for: indexPath)
            if let resultCell = cell as? ResultNumberCollectionViewCell {
                resultCell.result = size
            }
            return cell

        case .hiddenNumber, .hiddenTshirtSize:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HiddenTileCollectionViewCell.reuseID, for: indexPath)
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
        case .number, .tshirtSize:
            let viewController = HiddenNumberViewController(result: tile.hide(), numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            break

        case .hiddenNumber, .hiddenTshirtSize:
            let viewController = ResultCollectionViewController(result: tile.result(), numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            break

        case .numberResult, .tshirtResult:
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

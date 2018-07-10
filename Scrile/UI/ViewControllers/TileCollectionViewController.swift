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
    fileprivate let color: UIColor

    init(tiles: [TileType], color: UIColor) {
        self.tiles = tiles
        self.color = color
        super.init(collectionViewLayout: flowLayout)
        self.collectionView?.isPrefetchingEnabled = false
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
        let cell: TileCollectionViewCell

        switch tile {
        case .number(let number):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NumberTileCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let numberCell = cell as? NumberTileCollectionViewCell {
                numberCell.number = number
                print("Update color: \(number)")
            }
            break

        case .numberResult(let number):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNumberCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let resultCell = cell as? ResultNumberCollectionViewCell {
                resultCell.result = number
            }
            break

        case .tshirtSize(let size):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: TshirtTileCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let tshirtCell = cell as? TshirtTileCollectionViewCell {
                tshirtCell.setSize(size)
            }
            break

        case .tshirtResult(let size):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNumberCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let resultCell = cell as? ResultNumberCollectionViewCell {
                resultCell.result = 0
            }
            break

        case .hiddenNumber, .hiddenTshirtSize:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HiddenTileCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            break

        case .option(let type):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let optionCell = cell as? OptionCollectionViewCell {
                optionCell.setType(type: type)
            }
            break
        }

        cell.color = tile.color()
        return cell
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
            let viewController = type.viewController

            if let colorViewController = viewController as? ColorViewController {
                colorViewController.delegate = self
            }

            navigationController?.pushViewController(viewController, animated: true)
            break

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsInSection = collectionView.numberOfItems(inSection: indexPath.section)
        let currentIndexOfItem = indexPath.item
        let totalWidth = collectionView.frame.width
        let width = totalWidth / CGFloat(numberOfItemsInSection)
        let height = flowLayout.itemSize.height
        let modulo = numberOfItemsInSection

        guard modulo > 0 else {
            return CGSize(width: width, height: height)
        }

        let cellWidth = currentIndexOfItem % modulo == 0 ? ceil(width) : floor(width)

        return CGSize(width: cellWidth, height: height)
    }

    // Color Testing
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let collectionView = collectionView else { return }
//
//        collectionView.visibleCells.forEach({ (cell) in
//            let side = collectionView.side(for: cell)
//            let color = side.color()
//            cell.backgroundColor = color
//        })
//    }

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

extension TileCollectionViewController: ColorDelegate {
    func didChooseColor(color: UIColor) {
        UserDefaults.standard.saveUserColor(color)

        self.collectionView?.visibleCells.forEach { cell in
            guard
                let cell = cell as? TileCollectionViewCell,
                let indexPath = self.collectionView?.indexPath(for: cell)
            else { return }

            let tile = tiles[index(for: indexPath)]
            cell.color = tile.color()
        }

        self.navigationController?.popToRootViewController(animated: true)
    }
}

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
        self.collectionView.isPrefetchingEnabled = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = UIColor.clear
        
        collectionView.register(NumberTileCollectionViewCell.self, forCellWithReuseIdentifier: NumberTileCollectionViewCell.reuseID)
        collectionView.register(HiddenTileCollectionViewCell.self, forCellWithReuseIdentifier: HiddenTileCollectionViewCell.reuseID)
        collectionView.register(TextTileCollectionViewCell.self, forCellWithReuseIdentifier: TextTileCollectionViewCell.reuseID)
        collectionView.register(ResultNumberCollectionViewCell.self, forCellWithReuseIdentifier: ResultNumberCollectionViewCell.reuseID)
        collectionView.register(OptionCollectionViewCell.self, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseID)
        collectionView.register(ResultTextCollectionViewCell.self, forCellWithReuseIdentifier: ResultTextCollectionViewCell.reuseID)
        collectionView.register(ResultOptionCollectionViewCell.self, forCellWithReuseIdentifier: ResultOptionCollectionViewCell.reuseID)
    }
    
    func handleTile(_ tile: TileType) {
        switch tile {
        case .number, .text:
            let viewController = HiddenNumberViewController(result: tile.hide(), numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            
        case .hiddenNumber, .hiddenText, .hiddenOption:
            let viewController = ResultCollectionViewController(result: tile.result(), numberOfTiles: tiles.count)
            navigationController?.pushViewController(viewController, animated: true)
            
        case .numberResult, .textResult, .optionResult:
            navigationController?.popToRootViewController(animated: true)
            
        case .option(let type):
            guard type != .empty else { return }
            
            guard let viewController = type.viewController else {
                let viewController = HiddenNumberViewController(result: tile.hide(), numberOfTiles: tiles.count)
                navigationController?.pushViewController(viewController, animated: true)
                return
            }
            
            // Coordinator patterns would be nice
            if let colorViewController = viewController as? ColorViewController {
                colorViewController.delegate = self
            } else if let infoViewController = viewController as? InfoViewController {
                infoViewController.delegate = self
            } else if let settingsViewController = viewController as? SettingsViewController {
                settingsViewController.delegate = self
            } else if let coffeeResultViewController = viewController as? CoffeeResultViewController {
                coffeeResultViewController.delegate = self
            }
            
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - DataSource & Delegate

extension TileCollectionViewController {
    
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
            }
            
        case .numberResult(let number):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultNumberCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let resultCell = cell as? ResultNumberCollectionViewCell {
                resultCell.result = number
            }
            
        case .text(let text):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextTileCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let textCell = cell as? TextTileCollectionViewCell {
                textCell.setText(text)
            }

        case .textResult(let text):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultTextCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let resultCell = cell as? ResultTextCollectionViewCell {
                resultCell.result = text
            }
            
        case .hiddenNumber, .hiddenText, .hiddenOption:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HiddenTileCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            
        case .option(let type):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let optionCell = cell as? OptionCollectionViewCell {
                optionCell.setType(type: type)
            }
            
        case .optionResult(let option):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultOptionCollectionViewCell.reuseID, for: indexPath) as! TileCollectionViewCell
            if let resultCell = cell as? ResultOptionCollectionViewCell {
                resultCell.result = option
            }
        }
        
        cell.color = tile.color()
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tile = tiles[index(for: indexPath)]
        handleTile(tile)
    }
}

// MARK: - FlowLayout

extension TileCollectionViewController {
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
    
    func index(for indexPath: IndexPath) -> Int {
        return (indexPath.section * flowLayout.numberOfHorizontalItems) + indexPath.row
    }
}

// MARK: - Color Delegate

extension TileCollectionViewController: ColorDelegate {
    func didChooseColor(color: UIColor) {
        UserDefaults.standard.saveUserColor(color)
        
        self.collectionView.visibleCells.forEach { cell in
            guard
                let cell = cell as? TileCollectionViewCell,
                let indexPath = self.collectionView.indexPath(for: cell)
                else { return }
            
            let tile = tiles[index(for: indexPath)]
            cell.color = tile.color()
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension TileCollectionViewController: SettingsDelegate {
    func closeSettings() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension TileCollectionViewController: InfoDelegate {
    func closeInfo() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension TileCollectionViewController: CoffeeResultDelegate {
    func endCoffeeBreak() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

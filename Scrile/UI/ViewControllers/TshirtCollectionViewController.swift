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

        navigationController?.viewControllers = [self]

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
                let indexValue = index(for: indexPath)

                if indexValue == User.numberTileCount - 1 {
                    tileCell.numberString = "∞"
                } else {
                    tileCell.numberString = "-"
                }
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
            guard
                let cell = collectionView.cellForItem(at: indexPath) as? NumberTileCollectionViewCell,
                let result = cell.result
                else { return }

            navigationController?.pushViewController(HiddenNumberViewController(result: result), animated: true)

        case .option:
            let trueIndex = index(for: indexPath) - User.numberTileCount
            let optionType = User.options[trueIndex]

            if let viewcontroller = optionViewController(option: optionType) {
                navigationController?.pushViewController(viewcontroller, animated: true)
            }

        default:
            print("No action is needed here")

        }
    }

    func optionViewController(option: OptionType) -> UIViewController? {
        switch option {
        case .coffee:
            return ColorViewController()

        case .colorPicker:
            return ColorViewController()

        case .customNumber:
            return ColorViewController()

        case .tshirtSizing:
            return NumberCollectionViewController()

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

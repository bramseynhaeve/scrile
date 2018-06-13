//
//  ResultCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultCollectionViewController: TileCollectionViewController {

    let resultView = ResultView()

    init(result: TileType, numberOfTiles: Int) {

        let tiles = Array(0..<numberOfTiles).map { (_) -> TileType in
            return result
        }

        switch result {
        case .numberResult(let number):
            resultView.setResult(number)
        default:
            resultView.isHidden = true
        }

        super.init(tiles: tiles)

        collectionView?.isScrollEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(resultView)
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        resultView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

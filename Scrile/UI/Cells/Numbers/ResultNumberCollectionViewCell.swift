//
//  ChosenNumberCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultNumberCollectionViewCell: TileCollectionViewCell {
    
    let fontSize: Double = 480
    let baseLineFactor: Double = 0.0625
    let resultView = ResultView()

    var result: Float = 0 {
        didSet {
            resultView.setResult(result)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        backgroundContainer.addSubview(resultView)
    }

    override func layoutTile() {
        super.layoutTile()
        hideBorder()
    }

    override func didMoveToSuperview() {
        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }

        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.topAnchor.constraint(equalTo: newSuperview.topAnchor).isActive = true
        resultView.bottomAnchor.constraint(equalTo: newSuperview.bottomAnchor).isActive = true
        resultView.leftAnchor.constraint(equalTo: newSuperview.leftAnchor).isActive = true
        resultView.rightAnchor.constraint(equalTo: newSuperview.rightAnchor).isActive = true
    }
    
    static var reuseID: String {
        return String(describing: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

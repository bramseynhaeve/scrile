//
//  ResultTextCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import UIKit

class ResultTextCollectionViewCell: TileCollectionViewCell {
    let resultView = ResultView()
    
    var result: String = "" {
        didSet {
            resultView.setResult(result)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
            
        backgroundContainer.addSubview(resultView)
    }

    static var reuseID: String {
        return String(describing: self)
    }

    override func layoutTile() {
        super.layoutTile()
        hideBorder()
    }
    
    override func didMoveToSuperview() {
        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }
        
        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.topAnchor.constraint(equalTo: newSuperview.topAnchor).activate()
        resultView.bottomAnchor.constraint(equalTo: newSuperview.bottomAnchor).activate()
        resultView.leftAnchor.constraint(equalTo: newSuperview.leftAnchor).activate()
        resultView.rightAnchor.constraint(equalTo: newSuperview.rightAnchor).activate()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  ResultDependingCollectionViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 25/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResultDependingCollectionViewController: TileCollectionViewController {
    
    let result: String
    
    init(result: String) {
        self.result = result
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

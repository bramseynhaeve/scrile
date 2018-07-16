//
//  User.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

private let numberOfNumberTilesKey = "numberOfTilesKey"

class User: NSObject {
    
    static var numberTileCount: Int {
        get {
            let numberOfTiles = UserDefaults.standard.integer(forKey: numberOfNumberTilesKey)
            guard numberOfTiles != 0 else { return 10 }
            
            return numberOfTiles
        }
        
        set { UserDefaults.standard.set(newValue, forKey: numberOfNumberTilesKey) }
    }

    static var tshirtSizes: [String] = ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXL", "XXL", "XXL"]
}

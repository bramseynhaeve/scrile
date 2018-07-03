//
//  HiddenStringTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class HiddenTileCollectionViewCell: TileCollectionViewCell {

    let defaultColor = UIColor.darkGray
    var flashTimer: Timer?
    
    static var reuseID: String {
        return String(describing: self)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        flashTimer = randomTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func randomTimer() -> Timer {
        let randomFactor = Double(arc4random_uniform(100)) / 100.0
        let randomInterval: Double = 1 + (10 * randomFactor)

        return Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { timer in
            self.flashTimer = self.randomTimer()
            self.backgroundColor = self.defaultColor.lightened(byPercentage: 0.1)

            UIView.animate(withDuration: 0.29) {
                self.backgroundColor = self.defaultColor
            }
        }
    }
    
    override func layoutTile() {
        super.layoutTile()
        backgroundColor = defaultColor
    }
}

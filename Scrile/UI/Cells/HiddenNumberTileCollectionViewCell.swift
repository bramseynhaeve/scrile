//
//  HiddenNumberTileCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class HiddenNumberTileCollectionViewCell: TileCollectionViewCell {
    
    var timer: Timer? = nil
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    override func prepareForReuse() {
        resetTimer()
    }
    
    deinit {
        timer?.invalidate()
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.waitingBackgroundColor
        
        resetTimer()
    }
    
    func resetTimer() {
        
        let interval: TimeInterval = Double(arc4random_uniform(100)) / 10
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] (timer) in
            guard let weakSelf = self else {
                timer.invalidate()
                return
            }
            
            weakSelf.backgroundColor = UIColor.waitingLightBackgroundColor
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn, animations: {
                weakSelf.backgroundColor = UIColor.waitingBackgroundColor
            }, completion:nil)
            
            weakSelf.resetTimer()
        }
    }
}

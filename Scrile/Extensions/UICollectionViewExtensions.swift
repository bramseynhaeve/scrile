//
//  UICollectionViewExtensions.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

extension UICollectionView {
    func side(for cell: UICollectionViewCell) -> Side {
        let correctionMargin: CGFloat = 5.0
        let verticalMargin:CGFloat = ((self.frame.height - cell.frame.height) / 2) - correctionMargin
        let horizontalMargin:CGFloat = ((self.frame.width - cell.frame.width) / 2) - correctionMargin
        
        var frame = cell.frame
        frame.origin.y -= self.contentOffset.y
        
        var side = Side.none
        if round(frame.midX) <= (self.frame.midX - horizontalMargin) { side.insert(.left) }
        if round(frame.midY) <= (self.frame.midY - verticalMargin) { side.insert(.top) }
        if round(frame.midX) >= (self.frame.midX + horizontalMargin) { side.insert(.right) }
        if round(frame.midY) >= (self.frame.midY + verticalMargin) { side.insert(.bottom) }
        
        if side == .none {
            if round(frame.midY) <= self.frame.midY - (frame.height / 2) { side.insert(.leaningTop) }
            if round(frame.midY) >= self.frame.midY + (frame.height / 2) { side.insert(.leaningBottom) }
        }
        
        return side
    }
}



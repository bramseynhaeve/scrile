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
        let margin:CGFloat = 5.0
        var frame = cell.frame
        frame.origin.y -= self.contentOffset.y
        
        //TODO: use optional Side
        var side = Side(rawValue: 0)
        if round(frame.origin.x) == 0 { side.insert(.left) }
        if round(frame.origin.y) <= margin { side.insert(.top) }
        if round(frame.origin.x - self.frame.size.width + frame.size.width) == 0 { side.insert(.right) }
        if round(frame.origin.y - self.frame.size.height + frame.size.height) >= -margin { side.insert(.bottom) }

        return side
    }
}



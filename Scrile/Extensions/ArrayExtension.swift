//
//  ArrayExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 13/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import Foundation

extension Array {
    // Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    
    // Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    
    var randomItem: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
}


//
//  IntExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 16/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import Foundation

extension Int {

    func scrumFibonacci() -> Float {
        
        // Make the first number 0 since we don't want 1 two times.
        if self == 0 { return Float(self) }
        if self == 1 { return 0.5 }
        
        var num1 = 0
        var num2 = 1
        
        for _ in 0 ..< self - 1 {
            
            let num = num1 + num2
            num1 = num2
            num2 = num
        }
        
        return Float(num2)
    }
}

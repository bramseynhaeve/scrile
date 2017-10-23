//
//  FloatExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 20/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import Foundation

extension Float {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

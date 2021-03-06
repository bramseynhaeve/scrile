//
//  StringExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 02/07/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }
}

//
//  UserDefaultsExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 06/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

private let kUserColorKey = "user_color"

extension UserDefaults {

    func userColor() -> UIColor {
        return colorForKey(key: kUserColorKey) ?? UIColor.tile
    }

    func saveUserColor(_ color: UIColor) {
        setColor(value: color, forKey: kUserColorKey)
    }

    func setColor(value: UIColor?, forKey key: String) {
        guard let value = value else {
            set(nil, forKey: key)
            return
        }

        set(NSKeyedArchiver.archivedData(withRootObject: value), forKey: key)
    }

    func colorForKey(key:String) -> UIColor? {
        guard
            let data = data(forKey: key),
            let color = NSKeyedUnarchiver.unarchiveObject(with: data) as? UIColor
        else { return nil }

        return color
    }
}

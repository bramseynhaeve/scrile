//
//  UserDefaultsExtension.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 06/07/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

private let kUserColorKey = "user_color"

public enum UserFlow: Int {
    case numbers
    case tshirt
}

extension UserDefaults {
    
    func lastUserFlow() -> UserFlow {
        return UserFlow(rawValue: UserDefaults.standard.integer(forKey: "userFlow"))!
    }
    
    func saveUserFlow(_ flow: UserFlow) {
        UserDefaults.standard.set(flow.rawValue, forKey: "userFlow")
    }

    func userColor() -> UIColor {
        let color = colorForKey(key: kUserColorKey) ?? UIColor.tile
        return color.p3()
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

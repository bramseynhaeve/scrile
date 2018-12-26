//
//  OptionTile.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import UIKit

enum OptionType {
    case tshirt
    case numbers
    case color
    case settings
    case info
    case coffee
    case empty
    
    var image: UIImage {
        switch self {
        case .tshirt: return UIImage(named: "tshirt")!
        case .numbers: return UIImage(named: "numbers")!
        case .color: return UIImage(named: "colorpicker")!
        case .settings: return UIImage(named: "settings")!
        case .info: return UIImage(named: "info")!
        case .coffee: return UIImage(named: "coffee")!
        case .empty: return UIImage()
        }
    }
    
    var color: UIColor {
        if self == .empty {
            return UserDefaults.standard.userColor().darkened(byPercentage: 0.25)
        }
        
        return UserDefaults.standard.userColor().darkened(byPercentage: 0.1)
    }
    
    var viewController: UIViewController? {
        let currentUserColor = UserDefaults.standard.userColor()
        
        switch self {
        case .tshirt: return TshirtViewController(color: currentUserColor)
        case .numbers: return NumberViewController(color: currentUserColor)
        case .color: return ColorViewController(color: UserDefaults.standard.userColor())
        case .settings: return SettingsViewController()
        case .info: return InfoViewController()
        case .coffee: return nil
        case .empty: return nil
        }
    }
}

struct OptionTile {
    let type: OptionType
}

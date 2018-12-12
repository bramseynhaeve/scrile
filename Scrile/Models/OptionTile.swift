//
//  TshirtTile.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 07/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

enum OptionType {
    case tshirt
    case numbers
    case color
    case settings
    case info
    case coffee

    var image: UIImage {
        switch self {
        case .color: return UIImage(named: "colorpicker")!
        case .coffee: return UIImage(named: "coffee")!
        case .tshirt: return UIImage(named: "tshirt")!
        default: return UIImage(named: "settings")!
        }
    }

    var color: UIColor {
        return UserDefaults.standard.userColor().darkened(byPercentage: 0.1)
    }

    var viewController: UIViewController {
        let currentUserColor = UserDefaults.standard.userColor()
        
        switch self {
        case .tshirt: return TshirtViewController(color: currentUserColor)
        case .numbers: return NumberViewController(color: currentUserColor)
        default:
            return ColorViewController(color: UserDefaults.standard.userColor())
        }
    }
}

struct OptionTile {
    let type: OptionType
}

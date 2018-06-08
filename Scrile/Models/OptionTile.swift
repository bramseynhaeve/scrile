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
        default: return UIImage(named: "rules")!
        }
    }

    var color: UIColor {
        return .red

        switch self {
        case .tshirt: return UIColor.red
        default: return UIColor.yellow
        }
    }

    var viewController: UIViewController {
        switch self {
        case .tshirt: return TshirtViewController()
        case .numbers: return NumberViewController()
        default:
            return ColorViewController()

        }
    }
}

struct OptionTile {
    let type: OptionType
}

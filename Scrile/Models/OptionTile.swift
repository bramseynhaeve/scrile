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
        case .tshirt: return UIImage(named: "colorpicker")!
        default: return UIImage(named: "rules")!
        }
    }

    var color: UIColor {
        switch self {
        case .tshirt: return UIColor.blue
        default: return UIColor.yellow
        }
    }

//    var viewController: UIViewController {
//        switch self {
//        case .tshirt:
//            
//        default:
//
//        }
//    }
}

struct OptionTile {
    let type: OptionType
}

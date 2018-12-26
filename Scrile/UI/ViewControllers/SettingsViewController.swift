//
//  SettingsViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/12/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate: AnyObject {
    func closeSettings()
}

class SettingsViewController: UIViewController {
    weak var delegate: SettingsDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            self?.delegate?.closeSettings()
        }
    }
}

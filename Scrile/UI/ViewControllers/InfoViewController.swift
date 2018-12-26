//
//  InfoViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/12/2018.
//  Copyright © 2018 Bram Seynhaeve. All rights reserved.
//

import Foundation
import UIKit

protocol InfoDelegate: AnyObject {
    func closeInfo()
}

class InfoViewController: UIViewController {
    weak var delegate: InfoDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            self?.delegate?.closeInfo()
        }
    }
}

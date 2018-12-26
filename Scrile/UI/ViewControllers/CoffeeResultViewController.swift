//
//  CoffeeResultViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 26/12/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import Foundation
import UIKit

protocol CoffeeResultDelegate: AnyObject {
    func endCoffeeBreak()
}

class CoffeeResultViewController: UIViewController {
    weak var delegate: CoffeeResultDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            self?.delegate?.endCoffeeBreak()
        }
    }
}

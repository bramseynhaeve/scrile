//
//  ColorViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    let animator = FlyAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.green
        
        modalPresentationStyle = .custom
        transitioningDelegate = animator
        
        let button = UIButton(frame: CGRect(x: 30, y: 30, width: 100, height: 100))
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTouchBackButton), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func didTouchBackButton() {        
        navigationController?.popToRootViewController(animated: true)
    }
}

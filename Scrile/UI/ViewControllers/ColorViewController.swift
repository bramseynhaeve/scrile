//
//  ColorViewController.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 12/10/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

protocol ColorDelegate: AnyObject {
    func didChooseColor(color: UIColor)
}

class ColorViewController: UIViewController {

    fileprivate let colorCircle = UIView()
    fileprivate let okButton = UIButton()
    fileprivate let scrubber = UIView()
    fileprivate let colorNameLabel = UILabel()
    weak var delegate: ColorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO dynamic color
        view.backgroundColor = UIColor.red

        colorCircle.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        scrubber.translatesAutoresizingMaskIntoConstraints = false
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(colorCircle)
        view.addSubview(okButton)
        view.addSubview(scrubber)
        view.addSubview(colorNameLabel)

        let okButtonRadius:CGFloat = 25.0
        okButton.widthAnchor.constraint(equalToConstant: okButtonRadius * 2).isActive = true
        okButton.heightAnchor.constraint(equalTo: okButton.widthAnchor).isActive = true
        okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        okButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        okButton.setBackgroundImage(UIColor.white.image, for: .normal)
        okButton.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).image, for: .highlighted)
        okButton.setTitleColor(UIColor.red, for: .normal) // TODO dynamic color
        okButton.setTitle("color_button_ok".localized, for: .normal)
        okButton.addTarget(self, action: #selector(self.didTouchBackButton), for: .touchUpInside)
        okButton.titleLabel?.font = UIFont.font1Bold(size: 22)
        okButton.layer.cornerRadius = okButtonRadius
        okButton.clipsToBounds = true

        let colorCircleRadius:CGFloat = 70.0
        colorCircle.widthAnchor.constraint(equalToConstant: colorCircleRadius * 2).isActive = true
        colorCircle.heightAnchor.constraint(equalTo: colorCircle.widthAnchor).isActive = true
        colorCircle.centerXAnchor.constraint(equalTo: okButton.centerXAnchor).isActive = true
        colorCircle.centerYAnchor.constraint(equalTo: okButton.centerYAnchor).isActive = true
        colorCircle.layer.borderColor = UIColor.white.cgColor
        colorCircle.layer.borderWidth = 5
        colorCircle.layer.cornerRadius = colorCircleRadius
        colorCircle.alpha = 0.4

        let scrubberRadius:CGFloat = 15.0
        scrubber.widthAnchor.constraint(equalToConstant: scrubberRadius * 2).isActive = true
        scrubber.heightAnchor.constraint(equalTo: scrubber.widthAnchor).isActive = true
        scrubber.backgroundColor = UIColor.white
        scrubber.layer.cornerRadius = scrubberRadius
        scrubber.layer.borderWidth = 3
        scrubber.layer.borderColor = UIColor.white.cgColor

        colorNameLabel.textAlignment = .center
        colorNameLabel.font = UIFont.font1Light(size: 25)
        colorNameLabel.textColor = UIColor.white
        colorNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        colorNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorNameLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        colorNameLabel.text = "Turqoise"
    }
    
    @objc func didTouchBackButton() {
        delegate?.didChooseColor(color: UIColor.green)
    }
}

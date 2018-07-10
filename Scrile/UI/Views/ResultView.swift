//
//  ResultView.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 08/06/2018.
//  Copyright © 2018 In The Pocket. All rights reserved.
//

import UIKit

class ResultView: UIView {
    fileprivate let resultLabel = UILabel()
    fileprivate let fontSize: Double = 480

    init(result: Float = 0) {
        super.init(frame: .zero)

        backgroundColor = UIColor.clear

        addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        resultLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        resultLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        resultLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true

        resultLabel.textAlignment = .center
        resultLabel.adjustsFontSizeToFitWidth = true
        resultLabel.baselineAdjustment = .alignCenters
        resultLabel.numberOfLines = 1
        resultLabel.minimumScaleFactor = 0.2
        resultLabel.font = UIFont.font1Regular(size: fontSize)
        resultLabel.textColor = UserDefaults.standard.userColor()

        setResult(result)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }

    func setResult(_ result: Float) {
        let format = result > 0 && result < 1 ? "%.1f" : "%.0f"
        let numberString = String(format: format, result)
        resultLabel.text = numberString
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

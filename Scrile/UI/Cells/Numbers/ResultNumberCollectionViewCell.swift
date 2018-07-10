//
//  ChosenNumberCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 05/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class ResultNumberCollectionViewCell: TileCollectionViewCell {
    
    let fontSize: Double = 480
    let resultView = ResultView()
    var flashTimer: Timer?

    var result: Float = 0 {
        didSet {
            resultView.setResult(result)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundContainer.addSubview(resultView)

        flashTimer = randomTimer()
    }

    override func layoutTile() {
        super.layoutTile()
        hideBorder()
    }

    override func didMoveToSuperview() {
        // Get parrent of collectionView
        guard let newSuperview = superview?.superview else { return }

        resultView.translatesAutoresizingMaskIntoConstraints = false
        resultView.topAnchor.constraint(equalTo: newSuperview.topAnchor).isActive = true
        resultView.bottomAnchor.constraint(equalTo: newSuperview.bottomAnchor).isActive = true
        resultView.leftAnchor.constraint(equalTo: newSuperview.leftAnchor).isActive = true
        resultView.rightAnchor.constraint(equalTo: newSuperview.rightAnchor).isActive = true
    }

    private func randomTimer() -> Timer {
        let randomFactor = Double(arc4random_uniform(100)) / 100.0
        let randomInterval: Double = 1 + (10 * randomFactor)

        return Timer.scheduledTimer(withTimeInterval: randomInterval, repeats: false) { timer in
            self.flashTimer = self.randomTimer()

            self.backgroundColor = self.color.darkened(byPercentage: 0.05)
            UIView.animate(withDuration: 0.29, delay: 0, options: .allowUserInteraction, animations: {
                self.backgroundColor = self.color
            })
        }
    }
    
    static var reuseID: String {
        return String(describing: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

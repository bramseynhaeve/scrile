//
//  OptionCollectionViewCell.swift
//  Scrile
//
//  Created by Bram Seynhaeve on 01/11/2017.
//  Copyright © 2017 In The Pocket. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: TileCollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        imageView.image = UIImage(named: "colorpicker")
        
        let widthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: 0.0)
        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.addSubview(imageView)
        self.addConstraints([widthConstraint, heightConstraint, centerXConstraint, centerYConstraint])
    }
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    func setType(type: OptionType) {
        setImage(image: imageForType(optionType: type))
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    func imageForType(optionType: OptionType) -> UIImage {
        switch optionType {
        case .colorPicker: return UIImage(named: "colorpicker")!
        default: return UIImage(named: "colorpicker")!
        }
    }
    
    override func layoutTile() {
        super.layoutTile()
        
        backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

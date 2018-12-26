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
        imageView.tintColor = .white
        imageView.image = UIImage(named: "colorpicker")
        self.addSubview(imageView)
        
        imageView.widthAnchor.constraint(equalToConstant: 50).activate()
        imageView.heightAnchor.constraint(equalToConstant: 50).activate()
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).activate()
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).activate()
    }
    
    static var reuseID: String {
        return String(describing: self)
    }
    
    func setType(type: OptionType) {
        setImage(image: type.image)
        backgroundColor = type.color
    }
    
    func setImage(image: UIImage) {
        let newImage = image.withRenderingMode(.alwaysTemplate)
        imageView.image = newImage
    }
    
    override func layoutTile() {
        super.layoutTile()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

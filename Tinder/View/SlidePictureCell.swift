//
//  SlidePictureCell.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 09/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class SlidePictureCell: UICollectionViewCell {
    
    var picture: UIImageView = .photoImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(picture)
        
        picture.preencherSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

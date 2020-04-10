//
//  DetailPictureCell.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 09/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class DetailPictureCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = .textBoldLabel(16)
    let slidePicturesVC = SlidePicturesVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        descriptionLabel.text = "Fotos recebentes"
        addSubview(descriptionLabel)
        
        descriptionLabel.preencher(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        
        addSubview(slidePicturesVC.view)
        
        slidePicturesVC.view.preencher(top: descriptionLabel.bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

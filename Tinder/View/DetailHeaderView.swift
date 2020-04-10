//
//  DetailHeaderView.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 09/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class DetailHeaderView: UICollectionReusableView {
    
    var picture: UIImageView = .photoImageView()
    
    var user: User? {
        didSet {
            if let user = user {
                picture.image = UIImage(named: user.picture)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(picture)
        
        picture.preencherSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

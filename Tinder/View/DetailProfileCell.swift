//
//  DetailProfileCell.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 09/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class DetailProfileCell: UICollectionViewCell {
    
    let nameLabel: UILabel = .textBoldLabel(32)
    let ageLabel: UILabel = .textLabel(28)
    let phaseLabel: UILabel = .textBoldLabel(18, numberOfLines: 2)
    
    var user: User? {
        didSet {
            if let user = user {
                nameLabel.text = user.name
                ageLabel.text = "\(user.age)"
                phaseLabel.text = user.phase
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let nameAgeStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        nameAgeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nameAgeStackView, phaseLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.preencherSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

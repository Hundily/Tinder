//
//  CombineCardView.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 02/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class CombineCardView: UIView {
    
    let nameLabel: UILabel = .textBoldLabel(32, textColor: .white)
    let ageLabel: UILabel = .textLabel(28, textColor: .white)
    let phaseLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    let photoImageView: UIImageView = .photoImageView(named: "pessoa-1")
    let deslikeImageView: UIImageView = .iconCard(named: "card-deslike")
    let likeImageView: UIImageView = .iconCard(named: "card-like")
    
    var callBack: ((User) -> Void)?
    
    var user: User? {
        didSet {
            if let user = user {
                photoImageView.image = UIImage(named: user.picture)
                nameLabel.text = user.name
                ageLabel.text = String(user.age)
                phaseLabel.text = user.phase
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 3.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        
        nameLabel.addShadow()
        ageLabel.addShadow()
        phaseLabel.addShadow()
        
        
        addSubview(photoImageView)
        addSubview(deslikeImageView)
        addSubview(likeImageView)
        deslikeImageView.preencher(top: topAnchor, leading: nil, trailing: trailingAnchor, bottom: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 20))
        likeImageView.preencher(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        
        photoImageView.preencherSuperview()
        
        let nameAndAgeStackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, UIView()])
        nameAndAgeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nameAndAgeStackView, phaseLabel])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        
        addSubview(stackView)
        
        stackView.preencher(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        stackView.spacing = 12
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSelectUser))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSelectUser() {
        if let user = self.user {
            self.callBack?(user)
        }
    }
}

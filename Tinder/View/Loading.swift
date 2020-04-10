//
//  Loading.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 04/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class Loading: UIView {
    
    let loadingView: UIView = {
        let load = UIView()
        load.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        load.backgroundColor = UIColor(red: 218/255, green: 99/255, blue: 111/255, alpha: 1)
        load.layer.cornerRadius = 50
        load.layer.borderWidth = 1
        load.layer.borderColor = UIColor.red.cgColor
        return load
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        image.layer.cornerRadius = 50
        image.layer.borderWidth = 5
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
        image.image = UIImage(named: "perfil")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(loadingView)
        loadingView.center = center
        
        addSubview(profileImage)
        profileImage.center = center
        
        animation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        UIView.animate(withDuration: 1.3, animations: {
            self.loadingView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
            self.loadingView.center = self.center
            self.loadingView.layer.cornerRadius = 125
            self.loadingView.alpha = 0.3
        }) { (_) in
            self.loadingView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
            self.loadingView.center = self.center
            self.loadingView.layer.cornerRadius = 50
            self.loadingView.alpha = 1
            
            self.animation()
        }
    }
}

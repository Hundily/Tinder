//
//  CombineVC.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 02/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

enum Action {
    case deslike, like, superlike
}

class CombineVC: UIViewController {
    
    var users: [User] = []
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    var profileButton: UIButton = .iconMenu(named: "icone-perfil")
    var chatButton: UIButton = .iconMenu(named: "icone-chat")
    var logoButton: UIButton = .iconMenu(named: "icone-logo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        navigationController?.navigationBar.isHidden = true
        
        let loader = Loading(frame: view.frame)
        view.insertSubview(loader, at: 0)
        
        addHeader()
        addFooter()
        getUser()
    }
}

extension CombineVC {
    
    @objc
    func handlerCard(gesture: UIPanGestureRecognizer) {
        if let card = gesture.view as? CombineCardView {
            let point = gesture.translation(in: view)
            
            let rotationAngle = point.x / view.bounds.width * 0.24
            
            if point.x > 0 {
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            } else {
                card.deslikeImageView.alpha = rotationAngle * 5 * -1
                card.likeImageView.alpha = 0
            }
            
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            if gesture.state == .ended {
                if card.center.x > self.view.bounds.width + 50 {
                    self.anamationCard(rotationAngle: rotationAngle, action: .like)
                    return
                }
                
                if card.center.x < -50 {
                    self.anamationCard(rotationAngle: rotationAngle, action: .deslike)
                    return
                }
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                    card.deslikeImageView.alpha = 0
                    card.likeImageView.alpha = 0
                }
            }
        }
    }
    
    func anamationCard(rotationAngle: CGFloat, action: Action) {
        if let user = self.users.first {
            for view in self.view.subviews {
                if view.tag == user.id {
                    if let card = view as? CombineCardView {
                        let center: CGPoint
                        var like: Bool
                        
                        switch action {
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        case .superlike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        }
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            
                            card.deslikeImageView.alpha = !like ? 1 : 0
                            card.likeImageView.alpha = like ? 1 : 0
                        }) { (_) in
                            
                            if like {
                                self.matchUsers(user: user)
                            }
                            
                            self.removeCard(card: card)
                        }
                    }
                }
            }
        }
    }
}

extension CombineVC {
    
    func addCard() {
        for user in users {
            let card = CombineCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            
            card.center = view.center
            card.user = user
            card.tag = user.id
            
            card.callBack = { (data) in
                self.showUserDetail(user: data)
            }
            
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlerCard))
            card.addGestureRecognizer(gesture)
            
            view.insertSubview(card, at: 1)
        }
    }
    
    func getUser() {
        UserService.shared.getUser { (users, err) in
            if let users = users {
                
                DispatchQueue.main.async {
                    self.users = users
                    self.addCard()
                }
            }
        }
    }
    
    func removeCard(card: UIView) {
        card.removeFromSuperview()
        
        self.users = self.users.filter({ (us) -> Bool in
            return us.id != card.tag
        })
    }
    
    func matchUsers(user: User) {
        if user.match {
            let matchVC = MatchVC()
            matchVC.user = user
            matchVC.modalPresentationStyle = .fullScreen
            self.present(matchVC, animated: true, completion: nil)
        }
    }
    
    func showUserDetail(user: User) {
        let detailUserVC = DetailUserVC()
        detailUserVC.user = user
        detailUserVC.modalPresentationStyle = .fullScreen
        
        detailUserVC.callBack = {(user, action) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if action == .deslike {
                    self.handleDeslikeButton()
                } else {
                    self.handleLikeButton()
                }
            }
        }
        self.present(detailUserVC, animated: true, completion: nil)
    }
}

extension CombineVC {
    
    func addHeader() {
        //get safearea
        let windows = UIApplication.shared.windows.first { $0.isKeyWindow }
        let top: CGFloat = windows?.safeAreaInsets.top ?? 44
        
        let stackView = UIStackView(arrangedSubviews: [profileButton, logoButton, chatButton])
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        stackView.preencher(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: top, left: 16, bottom: 0, right: 16))
    }
    
    func addFooter() {
        let stackView = UIStackView(arrangedSubviews: [UIView(), deslikeButton, superlikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        
        stackView.preencher(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 16, bottom: 34, right: 16))
        
        likeButton.addTarget(self, action: #selector(handleLikeButton), for: .touchUpInside)
        superlikeButton.addTarget(self, action: #selector(handleSuperlikeButton), for: .touchUpInside)
        deslikeButton.addTarget(self, action: #selector(handleDeslikeButton), for: .touchUpInside)
    }
    
    @objc func handleLikeButton() {
        self.anamationCard(rotationAngle: 0.4, action: .like)
    }
    
    @objc func handleDeslikeButton() {
        self.anamationCard(rotationAngle: -0.4, action: .deslike)
    }
    
    @objc func handleSuperlikeButton() {
        self.anamationCard(rotationAngle: 0, action: .superlike)
    }
}

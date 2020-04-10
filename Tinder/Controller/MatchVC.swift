//
//  MatchVC.swift
//  Tinder
//
//  Created by Hundily Cerqueira on 05/04/20.
//  Copyright © 2020 Hundily Cerqueira. All rights reserved.
//

import UIKit

class MatchVC: UIViewController {
    
    var user: User? {
        didSet {
            if let user = user {
                photoImageView.image = UIImage(named: user.picture)
                messageLabel.text = "\(user.name) curtiu você também!"
            }
        }
    }
    
    let photoImageView: UIImageView = .photoImageView(named: "pessoa-1")
    let likeImageView: UIImageView = .photoImageView(named: "icone-like")
    let messageLabel: UILabel = .textBoldLabel(18, textColor: .white, numberOfLines: 1)
    let messageInput: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.heightAnchor.constraint(equalToConstant: 44).isActive = true
        input.placeholder = "Digite algo legal..."
        input.backgroundColor = .white
        input.layer.cornerRadius = 8
        input.textColor = .darkText
        input.returnKeyType = .go
        
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        input.leftViewMode = .always
        
        input.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        input.rightViewMode = .always
        return input
    }()
    
    let buttonSend: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return button
    }()
    
    let buttonClose: UIButton = {
        let button = UIButton()
        button.setTitle("Go back to Tinder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(photoImageView)
        photoImageView.preencherSuperview()
        
        let gradiant = CAGradientLayer()
        gradiant.frame = view.frame
        gradiant.colors = [UIColor.clear.cgColor,UIColor.clear.cgColor, UIColor.black.cgColor]
        
        photoImageView.layer.addSublayer(gradiant)
        messageLabel.textAlignment = .center
        
        buttonClose.addTarget(self, action: #selector(handleCloseModal), for: .touchUpInside)
        buttonSend.addTarget(self, action: #selector(handleSendMessage), for: .touchUpInside)
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        messageInput.addSubview(buttonSend)
        messageInput.delegate = self
        
        buttonSend.preencher(top: messageInput.topAnchor, leading: nil, trailing: messageInput.trailingAnchor, bottom: messageInput.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, messageLabel, messageInput, buttonClose])
        stackView.axis = .vertical
        stackView.spacing = 16
        view.addSubview(stackView)
        
        stackView.preencher(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: .init(top: 0, left: 32, bottom: 46, right: 32))
    }
}

extension MatchVC {
    
    @objc func handleCloseModal() {
        dismiss(animated: true)
    }
    
    @objc func handleSendMessage() {
        if let message = self.messageInput.text {
            print(message)
        }
    }
    
    @objc func handleKeyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duration) {
                    self.view.frame = CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - keyboardSize.height)
                }
                
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func handleKeyboardHide(notification: NSNotification) {
        if let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
            UIView.animate(withDuration: duration) {
                self.view.frame = UIScreen.main.bounds
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension MatchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.handleSendMessage()
        
        return true
    }
}

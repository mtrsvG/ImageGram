//
//  ProfileViewController.swift
//  ImageGram
//
//  Created by Георгий Матросов on 19.07.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var userAvatarImage: UIImageView!
    
    @IBOutlet var userInfoLabel: UILabel!
    
    @IBOutlet var userNicknameLabel: UILabel!
    
    @IBOutlet var userStatusLabel: UILabel!
    @IBOutlet var exitButton: UIButton!
    @IBAction func didExitButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAvatar(image: userAvatarImage)
        setUserNameLabel(label: userInfoLabel)
        setUserNicknameLabel(label: userNicknameLabel)
        setUserStatusLabel(label: userStatusLabel)
        setExitButton()
    }
}


extension ProfileViewController {
    
    func setAvatar(image: UIImageView?)  {
        userAvatarImage = UIImageView()
        userAvatarImage.image = UIImage(named: "Photo")
        userAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userAvatarImage)
        
        NSLayoutConstraint.activate([
            userAvatarImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            userAvatarImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            userAvatarImage.widthAnchor.constraint(equalToConstant: 70),
            userAvatarImage.heightAnchor.constraint(equalToConstant: 70)
            
        ])
    }
    
    func setUserNameLabel(label: UILabel?) {
        userInfoLabel = UILabel()
        userInfoLabel.text = "Екатерина Новикова"
        userInfoLabel.textColor = .white
        userInfoLabel.font = UIFont.systemFont(ofSize: 23, weight: UIFont.Weight.bold)
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userInfoLabel)
        
        NSLayoutConstraint.activate([
            userInfoLabel.leadingAnchor.constraint(equalTo: userAvatarImage.leadingAnchor),
            userInfoLabel.topAnchor.constraint(equalTo: userAvatarImage.bottomAnchor, constant: 8)])
    }
    
    func setUserNicknameLabel(label: UILabel?) {
        userNicknameLabel = UILabel()
        userNicknameLabel.text = "@ekaterina_nov"
        userNicknameLabel.textColor = .gray
        userNicknameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        userNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userNicknameLabel)
        
        NSLayoutConstraint.activate([
            userNicknameLabel.leadingAnchor.constraint(equalTo: userInfoLabel.leadingAnchor),
            userNicknameLabel.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 8)])
    }
    
    func setUserStatusLabel(label: UILabel?) {
        userStatusLabel = UILabel()
        userStatusLabel.text = "Hello, world!"
        userStatusLabel.textColor = .white
        userStatusLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.regular)
        userStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(userStatusLabel)
        
        NSLayoutConstraint.activate([
            userStatusLabel.leadingAnchor.constraint(equalTo: userNicknameLabel.leadingAnchor),
            userStatusLabel.topAnchor.constraint(equalTo: userNicknameLabel.bottomAnchor, constant: 8)])
    }
    
    func setExitButton() {
        let exitButton = UIButton.systemButton(with: UIImage(named: "Button_exit")!,
                                           target: self,
                                           action: nil)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.imageView?.tintColor = UIColor(named: "YP Red")
        view.addSubview(exitButton)
        
        
        NSLayoutConstraint.activate([
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            exitButton.centerYAnchor.constraint(equalTo: userAvatarImage.centerYAnchor, constant: 0)])
    }
}

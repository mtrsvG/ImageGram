//
//  SplashViewController.swift
//  ImageGram
//
//  Created by Георгий Матросов on 13.08.2023.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    private var authViewController: AuthViewController?
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let oauth2Service = OAuth2Service.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let splashScreenImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Vector"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1058823529, blue: 0.1333333333, alpha: 1)
        addSubViews()
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let token = oauth2Service.authToken {
            self.fetchProfile(token: token)
            switchToTabBarController()
        } else {
            switchToAuth()
        }
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    private func switchToAuth() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        authViewController = storyboard.instantiateViewController(withIdentifier: ShowAuthenticationScreenSegueIdentifier) as? AuthViewController
        authViewController?.delegate = self
        guard let authViewController = authViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
        
    }
    
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    func showNetErrorAlert() {
        let alertNetError = UIAlertController(title: "Что-то пошло не так(",
                                              message: "Не удалось войти в систему",
                                              preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertNetError.addAction(action)
        present(alertNetError, animated: true)
    }
    
    private func fetchOAuthToken(_ code: String) {
        oauth2Service.fetchOAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.switchToTabBarController()
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
//                assertionFailure("token is not catch")
                showNetErrorAlert()
                break
            }
        }
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                showNetErrorAlert()
                break
            }
        }
    }
}

extension SplashViewController {
    func addSubViews() {
        view.addSubview(splashScreenImageView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            splashScreenImageView.heightAnchor.constraint(equalToConstant: 77),
            splashScreenImageView.widthAnchor.constraint(equalToConstant: 74),
            splashScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

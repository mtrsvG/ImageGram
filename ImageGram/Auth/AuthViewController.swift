//
//  AuthViewController.swift
//  ImageGram
//
//  Created by Георгий Матросов on 08.08.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let oauth2Service = OAuth2Service.shared

    private let showWebViewSegueIdentifier = "ShowWebView"
    
    weak var delegate: AuthViewControllerDelegate?
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showWebViewSegueIdentifier {
            guard
                let webViewController = segue.destination as? WebViewViewController
            else {return}
            webViewController.delegate = self
        } else {
            prepare(for: segue, sender: sender)
        }
    }
}

extension AuthViewController: WebViewViewControllerDelegate {
    func webViewViewControllerDidCancel(_ vc: WebViewViewController) {
        dismiss(animated: true)
    }
    
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String) {
        
        delegate?.authViewController(self, didAuthenticateWithCode: code)
    }
}

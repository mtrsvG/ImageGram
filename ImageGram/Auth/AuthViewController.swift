//
//  AuthViewController.swift
//  ImageGram
//
//  Created by Георгий Матросов on 08.08.2023.
//

import UIKit

private let oauth2Service = OAuth2Service()

final class AuthViewController: UIViewController {
    private let ShowWebViewSegueIdentifier = "ShowWebView"
    weak var delegate: AuthViewControllerDelegate?
    
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowWebViewSegueIdentifier {
            guard
                let webViewController = segue.destination as? WebViewViewController
            else {fatalError("Failed to prepare for \(ShowWebViewSegueIdentifier) ")}
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

//
//  WebViewViewControllerDelegate.swift
//  ImageGram
//
//  Created by Георгий Матросов on 11.08.2023.
//

import UIKit

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController (_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
    
}

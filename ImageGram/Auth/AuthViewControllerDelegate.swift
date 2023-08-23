//
//  AuthViewControllerDelegate.swift
//  ImageGram
//
//  Created by Георгий Матросов on 13.08.2023.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}

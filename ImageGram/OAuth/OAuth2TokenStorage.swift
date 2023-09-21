//
//  OAuth2TokenStorage.swift
//  ImageGram
//
//  Created by Георгий Матросов on 13.08.2023.
//

import Foundation
import SwiftKeychainWrapper

final class OAuth2TokenStorage {
    
    private enum key: String {
        case token
    }
    
    static let shared = OAuth2TokenStorage()
    
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            KeychainWrapper.standard.string(forKey: key.token.rawValue)
        }
        set {
            guard let newValue = newValue else {
                KeychainWrapper.standard.removeObject(forKey: key.token.rawValue)
                return
            }
            let isSuccess = KeychainWrapper.standard.set(newValue, forKey: key.token.rawValue)
            guard isSuccess else {
                return
            }
        }
    }
    
    private init() {}
}

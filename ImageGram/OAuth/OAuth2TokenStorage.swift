//
//  OAuth2TokenStorage.swift
//  ImageGram
//
//  Created by Георгий Матросов on 13.08.2023.
//

import Foundation

final class OAuth2TokenStorage {
    
    private enum key: String {
        case token
    }
    
    static let shared = OAuth2TokenStorage()
    
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            userDefaults.string(forKey: key.token.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: key.token.rawValue)
        }
    }
    
    private init() {}
}

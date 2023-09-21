//
//  Constants.swift
//  ImageGram
//
//  Created by Георгий Матросов on 08.08.2023.
//

import UIKit
struct WebConstants{
    static let AccessKey = "3SMaczJamkSb_bIY6yuiMnefewmK9CgvPyPpYsJKL1Y"
    static let SecretKey = "b0bprw90IVVbX-wmmQa9KLO12fYMHEyDD8VcyAOkP08"
    static let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let AccessScope = "public+read_user+write_likes"
    static let DefaultBaseURL = URL(string: "https://api.unsplash.com/")!
    static let UnsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let tokenRequestPathString = "/oauth/token"
    static let GrantType = "authorization_code"
    static let OAuthHttpMethod = "POST"
    static let OAuthBaseUrl = "https://unsplash.com"
}


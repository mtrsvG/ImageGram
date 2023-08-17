//
//  OAuthTokenResponseBody.swift
//  ImageGram
//
//  Created by Георгий Матросов on 13.08.2023.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}

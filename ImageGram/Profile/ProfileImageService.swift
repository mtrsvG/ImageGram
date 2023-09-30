//
//  ProfileImageService.swift
//  ImageGram
//
//  Created by Георгий Матросов on 12.09.2023.
//

import UIKit

final class ProfileImageService {
    
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    static let shared = ProfileImageService()
    private(set) var avatarURL: String?
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    private init() {}
    
    struct UserResult: Decodable {
        let profileImage: ProfileImage?
        
        enum CodingKeys: String, CodingKey {
            case profileImage = "profile_image"
        }
    }
    struct ProfileImage: Decodable {
        let small: String?
        let medium: String?
        let large: String?
    }


    struct ImageURL: Decodable {
        let small: String?
    }
    
    func fetchProfileImageURL(
        token: String,
        username: String,
        _ completion: @escaping (Result <String, Error>) -> Void) {
            assert(Thread.isMainThread)
            if avatarURL != nil { return }
            task?.cancel()
            
            var requestImage = profileImageRequest(username)
            requestImage?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            guard let requestImage = requestImage else { return }
            let session = URLSession.shared
            let task = session.objectTask(for: requestImage) {[weak self] (result: Result<UserResult, Error>) in
                guard let self = self else { return }
                
                switch result {
                case .success(let image):
                    let avatarURL = image.profileImage?.small
                    
                    guard let avatarURL = avatarURL else {
                        assertionFailure("image not catch")
                        return
                    }
                    self.avatarURL = avatarURL
                    completion(.success(avatarURL))
                    NotificationCenter.default
                        .post(name: ProfileImageService.DidChangeNotification, object: self,userInfo: ["URL": avatarURL])
                    self.task = nil
                case .failure(let error):
                    assertionFailure("Error is \(error)")
                    completion(.failure(error))
                    print("The error is \(error)")
                    self.avatarURL = nil
                }
            }
            self.task = task
            task.resume()
    }
    
    private func profileImageRequest(_ username: String) -> URLRequest? {
        URLRequest.makeHTTPRequest(path: "users/\(username)", httpMethod: "GET")
        
    }
    
//    private func objectTask(
//        for request: URLRequest,
//        completion: @escaping (Result<UserResult, Error>) -> Void
//    ) -> URLSessionTask {
//        let decoder = JSONDecoder()
//        return urlSession.data(for: request) { (result: Result<Data,Error>) in
//            let response = result.flatMap { data -> Result<UserResult, Error> in
//                Result {
//                    try decoder.decode(UserResult.self, from: data)
//                }
//            }
//            completion(response)
//        }
//    }
}

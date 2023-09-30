//
//  ProfileService.swift
//  ImageGram
//
//  Created by Георгий Матросов on 11.09.2023.
//

import UIKit

final class ProfileService {
    
    private(set) var profile: Profile?
    
    static let shared = ProfileService()
    
    private var task: URLSessionTask?
    private let urlSession = URLSession.shared
    
    struct ProfileResult: Codable {
        let username: String
        let firstName: String
        let lastName: String?
        let bio: String?
        
        private enum CodingKeys: String, CodingKey {
            case username
            case firstName = "first_name"
            case lastName = "last_name"
            case bio
        }
    }
    
    struct Profile {
        let username: String
        let name: String
        var loginName: String {
            get {
                "@\(username)"
            }
        }
        let bio: String
    }
    
    private init() { }
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        if profile != nil {
            return
        }
        task?.cancel()
        //Get запрос на получение профиля
        var requestProfile: URLRequest? = URLRequest.makeHTTPRequest(path: "/me", httpMethod: "GET")
        //Передаем bearer токен в реквест профайла
        requestProfile?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //Распаковка опционала
        guard let requestProfile = requestProfile else {
            assertionFailure("Invalid request")
            return }
        //Create task
        let session = URLSession.shared
        let task = session.objectTask(for: requestProfile) {[weak self] (result: Result <ProfileResult, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let body):
                    let profile = Profile(username: body.username,
                                          name: "\(body.firstName) \(body.lastName ?? "")",
                                          bio: body.bio ?? "")
                    self.profile = profile
                    ProfileImageService.shared.fetchProfileImageURL(token: token,
                                                                    username: "mtrsv_g") {_ in}
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
//                    assertionFailure("error is: \(error)")
                    self.profile = nil
                }
                
            }
        }
        self.task = task
        task.resume()
        
    }
    
    //Task
//    private func objectTask(
//        for request: URLRequest,
//        completion: @escaping (Result<ProfileResult, Error>) -> Void
//    ) -> URLSessionTask {
//        let decoder = JSONDecoder()
//        return urlSession.data(for: request) { (result: Result<Data,Error>) in
//            let response = result.flatMap { data -> Result<ProfileResult, Error> in
//                Result {
//                    try decoder.decode(ProfileResult.self, from: data)
//                }
//            }
//            completion(response)
//        }
//    }
}

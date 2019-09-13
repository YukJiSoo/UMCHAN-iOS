//
//  AuthService.swift
//  Umchan
//
//  Created by 육지수 on 9/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

class AuthService {
    
    static let shared = AuthService()
    
    func loginUser(email: String, password: String, completion: @escaping (_ Response: Result<Bool, APIError>) -> Void) {
        
        // TODO: API Networking(GraphQL)
        let resultStub = true
        
        if !resultStub {
            completion(.failure(.login))
            return
        }
        
        UserDataService.shared.saveUserData(user: User(email: "이메일", name: "크루장", nickname: "별명", imagePath: "이미지", location: Location(latitude: 20.0, longitude: 10.2))) { (result) in
            switch result {
            case .success(_):
                completion(.success(true))
                
            case .failure(KeychainError.failToSave):
                completion(.failure(.login))
            }
        }
    }
}

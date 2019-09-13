//
//  AuthService.swift
//  Umchan
//
//  Created by 육지수 on 9/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import Apollo

class AuthService {
    
    static let shared = AuthService()
    
    func loginUser(email: String, password: String, completion: @escaping (_ Response: Result<Bool, APIError>) -> Void) {
        
        let loginInput = LoginInput(email: email, password: password)
        Apollo.shared.client.perform(mutation: LoginMutation(account: loginInput)) { result in
            
            guard let data = try? result.get().data else {
                debugPrint("perform error")
                completion(.failure(.login))
                return
            }
            
            guard let user = data.login?.user else {
                debugPrint("fail convert user")
                completion(.failure(.login))
                return
            }
            let location = Location(latitude: user.location.latitude, longitude: user.location.longitude)
            
            UserDataService.shared.saveUserData(user: User(email: email, name: user.name, nickname: user.nickname, imagePath: user.imagePath, location: location)) { (result) in
                switch result {
                case .success(_):
                    completion(.success(true))

                case .failure(KeychainError.failToSave):
                    completion(.failure(.login))
                }
            }
        }
    }
}

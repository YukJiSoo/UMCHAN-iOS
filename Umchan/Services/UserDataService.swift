//
//  UserDataService.swift
//  Umchan
//
//  Created by 육지수 on 9/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let shared = UserDataService()
    
    // MARK: 
    func saveUserData(user: User, completion: @escaping (_ Response: Result<Bool, KeychainError>) -> Void) {
        
        if Keychain.saveValue(user.name, for: "user_name") {
            completion(.success(true))
        } else {
            completion(.failure(.failToSave))
        }
    }
}

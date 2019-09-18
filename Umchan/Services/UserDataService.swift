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
    
    // MARK: Properties
    private(set) var user: User?
    
    // MARK: Func
    func saveUserData(_ dictionary: [String: Any], completion: @escaping (_ Response: Result<Bool, KeychainError>) -> Void) {
        
        guard let user = try? User(dictionary) else {
            completion(.failure(.failToSave("Fail initialize User struct")))
            return
        }
        
        self.user = user
        completion(.success(true))
    }

}

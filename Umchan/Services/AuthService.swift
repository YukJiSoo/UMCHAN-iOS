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
        
        if resultStub {
            
            completion(.success(true))
        } else {
            
            completion(.failure(.login))
        }
    }
}

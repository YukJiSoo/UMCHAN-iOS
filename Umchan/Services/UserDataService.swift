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

    func loadUserData(completion: @escaping (_ Response: Result<Bool, UserAPIError>) -> Void) {

        Apollo.shared.client.fetch(query: UserQuery()) { result in

            guard
                let data = try? result.get().data,
                let code = data.user?.code,
                let message = data.user?.message
                else {
                    completion(.failure(.user(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.user(message)))
                return
            }

            // response from server
            guard let user = data.user?.user?.jsonObject else {
                completion(.failure(.user("Fail Convert json data")))
                return
            }

            self.saveUserData(user, completion: { (response) in
                switch response {
                case .success(_):

                    completion(.success(true))
                case .failure(.failToSave(let message)):
                    
                    print(message)
                    completion(.failure(.user("Fail save data")))
                default:
                    debugPrint("Uncorrect access")
                }
            })
        }
    }

}

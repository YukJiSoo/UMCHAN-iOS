//
//  User.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct User {
    
    var name: String
    var nickname: String
    var imagePath: String
    var location: Location
}

extension User: Codable {
    
    init(_ dictionary: [String: Any]) throws {
        self = try JSONDecoder().decode(User.self, from: JSONSerialization.data(withJSONObject: dictionary))
    }
}

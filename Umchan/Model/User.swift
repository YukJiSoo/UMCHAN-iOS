//
//  User.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct User: Codable {
    
    var email: String
    var name: String
    var nickname: String
    var imagePath: String
    var location: Location
}

struct Location: Codable {
    
    var latitude: Double
    var longitude: Double
}

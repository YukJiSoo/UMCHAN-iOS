//
//  Error.swift
//  Umchan
//
//  Created by 육지수 on 9/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

enum APIError: Error {
    case login
}

enum KeychainError: Error {
    case failToSave
}

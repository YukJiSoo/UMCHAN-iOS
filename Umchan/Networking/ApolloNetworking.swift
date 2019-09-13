//
//  Networking.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Apollo

final class Apollo {
    
    static let shared = Apollo()
    
    private let baseURL = "http://localhost:3030/graphql"
    
    private(set) lazy var client = ApolloClient(url: URL(string: baseURL)!)
}

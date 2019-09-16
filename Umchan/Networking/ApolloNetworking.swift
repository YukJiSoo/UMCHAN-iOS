//
//  Networking.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Apollo

//final class Apollo {
//
//    // MARK: Singleton
//    static let shared = Apollo()
//
//    // MARK: Constant
//    private let baseURL = "http://localhost:3030/graphql"
//
//    // MARK: Properties
//    private(set) lazy var client = ApolloClient(url: URL(string: baseURL)!)
//}

class Apollo {

    // MARK: Singleton
    static let shared = Apollo()

    // MARK: Constant
    private let baseURL = "http://localhost:3030/graphql"

    private lazy var networkTransport = HTTPNetworkTransport(
        url: URL(string: baseURL)!,
        delegate: self
    )

    private(set) lazy var client = ApolloClient(networkTransport: self.networkTransport)
}

extension Apollo: HTTPNetworkTransportPreflightDelegate {

    func networkTransport(_ networkTransport: HTTPNetworkTransport, shouldSend request: URLRequest) -> Bool {
        return true
    }

    func networkTransport(_ networkTransport: HTTPNetworkTransport, willSend request: inout URLRequest) {
        var headers = request.allHTTPHeaderFields ?? [String: String]()
        if let accessToken = AuthService.shared.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }

        request.allHTTPHeaderFields = headers

        print("Outgoing request: \(request)")
    }
}

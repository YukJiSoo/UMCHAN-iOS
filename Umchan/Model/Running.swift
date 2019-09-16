//
//  Running.swift
//  Umchan
//
//  Created by 육지수 on 8/22/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

struct Running {
    
    var name: String
    var oneLine: String
    var runningDate: Date
    var registerDate: Date
    var runningPoints: [Location]
}

extension Running: Codable {

    init(_ dictionary: [String: Any]) throws {
        self.name = (dictionary["name"] as? String) ?? ""
        self.oneLine = (dictionary["oneLine"] as? String) ?? ""
        let formatter = DateFormatter.basicFormatter(format: "\(DateFormat.date) \(DateFormat.time)", locale: DateFormat.locale)
        // TODO: 데이터 변환
        self.runningDate = Date()
        self.registerDate = Date()
        self.runningPoints = []
    }
}

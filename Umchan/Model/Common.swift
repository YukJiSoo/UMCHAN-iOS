//
//  Common.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

typealias Latitude = Double
typealias Longitude = Double
typealias LocationType = (Latitude, Longitude)

struct Location: Codable {

    var latitude: Latitude
    var longitude: Longitude
}

//
//  DistrictInfoService.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

typealias convertLocationCompletion = (_ Response: Result<String, DistrictInfoError>) -> Void

class DistrictInfoService {
    
    static let shared = DistrictInfoService()
    
    lazy var districtCoordinates: [DistrictCoordinate] = self.readJSON()
    
    var districtCoordinatesCount: Int {
        return self.districtCoordinates.count
    }
    
    private init() {
        
    }
    
    func readJSON() -> [DistrictCoordinate] {
        
        guard let dataAsset = NSDataAsset(name: DISTRICTS) else {
            debugPrint("err: no asset \(DISTRICTS).json")
            return []
        }
        
        guard let json = try? JSONDecoder().decode([DistrictCoordinate].self, from: dataAsset.data) else {
            debugPrint("err: fail decode data \(DISTRICTS).json")
            return []
        }
        
        return json
    }

    func convertLocationToDisrict(latitude: Double, longitude: Double, completion: @escaping convertLocationCompletion) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")

        geocoder.reverseGeocodeLocation(location, preferredLocale: locale, completionHandler: { (placemarks, error) in
            if let address: [CLPlacemark] = placemarks, let name = address.last?.locality {
                completion(.success(name))
            } else {
                completion(.failure(.failToConvertLocation("placemarks is nil")))
            }
        })
    }
}

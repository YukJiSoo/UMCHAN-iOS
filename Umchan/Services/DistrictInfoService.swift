//
//  DistrictInfoService.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

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
    
}

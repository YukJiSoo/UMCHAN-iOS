//
//  RunningPoint.swift
//  Umchan
//
//  Created by 육지수 on 8/31/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import MapKit

class RunningPoint: NSObject, MKAnnotation {
    
    // dynamic
    var coordinate: CLLocationCoordinate2D
    var order: Int
    
    init(coordinate: CLLocationCoordinate2D, order: Int) {
        
        self.coordinate = coordinate
        self.order = order
        
        super.init()
    }

}

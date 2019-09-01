//
//  RunnintPointMarkerView.swift
//  Umchan
//
//  Created by 육지수 on 9/1/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import MapKit

class RunningPointAnnotationView: MKMarkerAnnotationView, NibLodable {
    
    func configure(markerColor: UIColor, text: String) {
        
        self.markerTintColor = Color.symbol
        self.glyphText = text
    }
}

//
//  MapView.swift
//  Umchan
//
//  Created by 육지수 on 8/27/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    // MARK: - SubViews
    weak var mapView: MKMapView?
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setupMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setupMapView()
    }
    
    // MARK: - Functions
    func setupMapView() {
        
        let mapView = MKMapView(frame: .zero)
        self.addSubview(mapView)
        
        // set Constraints
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = mapView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomAnchor = mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let leadingAnchor = mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
        
        self.mapView = mapView
    }
    
}

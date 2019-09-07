//
//  RegisterRunningViewController+MKMapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/7/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

extension RegisterRunningViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Color.symbolTransparent
        renderer.lineWidth = 4.0
        
        return renderer
    }
}

//
//  MapView+CalculateRunningCourseDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/7/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

protocol CalculateRunningCourseDelegate {
    
    func drawRunningCourse()
    func removeRunningCourse()
}

extension MapView {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Color.symbolTransparent
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    
    func drawRunningCourse() {
        
        let a = self.annotationList[0].coordinate
        let b = self.annotationList[1].coordinate
        let ma = MKPlacemark(coordinate: a)
        let mb = MKPlacemark(coordinate: b)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: ma)
        directionRequest.destination = MKMapItem(placemark: mb)
        directionRequest.transportType = .automobile
        
        let direct = MKDirections(request: directionRequest)
        direct.calculate { (response, error) in
            
            guard let directionResponse = response else {
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                return
            }
            
            let route = directionResponse.routes[0]
            self.mapView?.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView?.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
    }
    
    func removeRunningCourse() {
        
    }
}

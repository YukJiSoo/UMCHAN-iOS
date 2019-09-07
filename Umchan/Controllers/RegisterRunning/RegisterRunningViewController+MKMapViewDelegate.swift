//
//  RegisterRunningViewController+MKMapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/7/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

extension RegisterRunningViewController: MKMapViewDelegate, OverlayRunningCourseDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = Color.symbolTransparent
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func drawRunningCourse() {
        
        guard let runningPoints = self.runningCourseData else {
            return
        }
        
        _ = runningPoints
            .map{ $0.coordinate }
            .reduce(nil) { (startCoordinate, endCoordinate) -> CLLocationCoordinate2D in
                
                guard let startCoordinate = startCoordinate else {
                    return endCoordinate
                }
                
                let startPlacemark = MKPlacemark(coordinate: startCoordinate)
                let endPlacemark = MKPlacemark(coordinate: endCoordinate)
                
                let directionRequest = MKDirections.Request()
                directionRequest.source = MKMapItem(placemark: startPlacemark)
                directionRequest.destination = MKMapItem(placemark: endPlacemark)
                directionRequest.transportType = .walking
                
                let directions = MKDirections(request: directionRequest)
                directions.calculate { (response, error) in
                    
                    guard let directionResponse = response else {
                        if let error = error {
                            print("\(error.localizedDescription)")
                        }
                        return
                    }
                    
                    let overlay = directionResponse.routes[0].polyline
                    
                    self.runningCourseOverlays.append(overlay)
                    self.mapView?.addOverlay(overlay, level: .aboveRoads)
                }
                
                return endCoordinate
        }
    }
    
    func clearRunningCourse() {
        
        self.mapView.removeOverlays(self.runningCourseOverlays)
    }
}

//
//  MapView+MKMapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/1/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import MapKit

extension MapView: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        guard let runningPointAnnotation = annotation as? RunningPoint else {
            debugPrint("err: fail convert to RunningPoint in MapView+MKMapViewDelegate.swift")
            return nil
        }

        guard let runningPointView = mapView.dequeueReusableAnnotationView(withIdentifier: RunningPointAnnotationView.nibId, for: runningPointAnnotation) as? RunningPointAnnotationView else {
            
            debugPrint("err: fail convert to RunningPointAnnotationView in MapView+MKMapViewDelegate.swift")
            return nil
        }
        runningPointView.configure(markerColor: Color.symbol, text: String(runningPointAnnotation.order))

        return runningPointView
    }
}

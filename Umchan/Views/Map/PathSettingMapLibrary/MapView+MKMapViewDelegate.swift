//
//  MapView+MKMapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/1/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        view.setSelected(false, animated: false)
        self.delegate?.answerAnnotationRemoveDelegate(didSelect: view)
    }
    
    func resortRunningPointArrayOrder() {
        
        for (order, runningPoint) in self.annotationList.enumerated() {
            runningPoint.order = order
        }
    }
    
    func reloadAnnotaionViews() {
        
        for (order, runningPoint) in self.annotationList.enumerated() {
            runningPoint.order = order + 1
        }
        
        if let annotations = self.mapView?.annotations {
            
            self.mapView?.removeAnnotations(annotations)
            self.mapView?.addAnnotations(self.annotationList)
        }
    }
}

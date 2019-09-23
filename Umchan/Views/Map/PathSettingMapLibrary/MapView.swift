//
//  MapView.swift
//  Umchan
//
//  Created by 육지수 on 8/27/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

@IBDesignable
class MapView: UIView {
    
    // MARK: - SubViews
    weak var mapView: MKMapView?
    weak var annotationButton: UIButton?
    weak var annotationView: UIImageView?
    
    // MARK: - Properties
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()

    @IBInspectable var regionRadius: CLLocationDistance = 1000 {
        didSet {
            if let nowLocation = self.mapView?.userLocation.location {
                self.centerMapOnLocation(location: nowLocation)
            }
        }
    }
    @IBInspectable var annotationSize: CGFloat = 50
    
    var annotationList = [RunningPoint]()
    var runningCourses = [MKOverlay]()
    
    weak var delegate: MapViewDelegate?
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setupSubViews()
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
        
        self.setupSubViews()
    }
    
    // MARK: - Functions
    func setupSubViews() {

        self.locationManager.delegate = self

        self.setupMapView()
        self.setupAnnotationView()
    }
    
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
        self.mapView?.delegate = self
        
        self.mapView?.register(RunningPointAnnotationView.self, forAnnotationViewWithReuseIdentifier: RunningPointAnnotationView.nibId)
    }
    
    func setupAnnotationButton() {
        
        let button = AnnotationButton(frame: .zero)
        button.delegate = self
        
        self.addSubview(button)
        
        // set Constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = button.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        let leadingAnchor = button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([ topAnchor, leadingAnchor ])
        
        self.annotationButton = button
    }
    
    func setupAnnotationView() {
        
        let annotationView = UIImageView(frame: .zero)
        annotationView.image = UIImage(named: AssetName.annotation)
        annotationView.contentMode = .scaleAspectFit
        annotationView.isHidden = true
        
        self.addSubview(annotationView)
        
        annotationView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightAnchor = annotationView.heightAnchor.constraint(equalToConstant: self.annotationSize)
        let widthAnchor = annotationView.widthAnchor.constraint(equalToConstant: self.annotationSize)
        let centerXAnchor = annotationView.centerXAnchor.constraint(equalTo: self.mapView!.centerXAnchor)
        let centerYAnchor = annotationView.centerYAnchor.constraint(equalTo: self.mapView!.centerYAnchor, constant: -(self.annotationSize / 2))
        
        NSLayoutConstraint.activate([ heightAnchor, widthAnchor, centerXAnchor, centerYAnchor ])
        
        self.annotationView = annotationView
    }
    
    func setupFix() {
        
        self.mapView?.isZoomEnabled = true
        self.mapView?.isPitchEnabled = true
        self.mapView?.isRotateEnabled = false
        self.mapView?.isScrollEnabled = false
        self.mapView?.isMultipleTouchEnabled = false
    }
    
    func centerMapOnLocation(location: CLLocation) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: self.regionRadius)
        self.mapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation() {
        
        guard let centerCoordinate = self.mapView?.centerCoordinate else {
            
            debugPrint("err: fail to load center coordinate")
            return
        }
        
        let nowOrderOfPoint = self.annotationList.count + 1
        let runningPoint = RunningPoint(coordinate: centerCoordinate, order: nowOrderOfPoint)
        self.annotationList.append(runningPoint)
        
        self.mapView?.addAnnotations([runningPoint])
    }
    
    func reloadAnnotation() {
        
        if let annotations = self.mapView?.annotations {
            
            self.mapView?.removeAnnotations(annotations)
        }
        self.mapView?.addAnnotations(self.annotationList)

        if let mapViewAnnotations = self.mapView?.annotations {
            self.mapView?.showAnnotations(mapViewAnnotations, animated: true)
        }
    }

}

extension MapView: AnnotationButtonDelegate {
    
    func pressed(isCheckMode: Bool) {
        
        if isCheckMode {
            
            self.clearRunningCourse()
        } else {
            
            self.drawRunningCourse()
        }
        
        self.annotationView?.isHidden = !isCheckMode
        self.delegate?.annotationButtonDelegate(isCheckMode: isCheckMode)
    }
}

extension MapView: CLLocationManagerDelegate {
    func configureLocationServices() {

        if self.authorizationStatus == .notDetermined {
            self.locationManager.requestAlwaysAuthorization()
        } else {
            self.centerMapOnUserLocation()
            return
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("call?")
        self.centerMapOnUserLocation()
    }

    func centerMapOnUserLocation() {

        guard let coordinate = self.locationManager.location?.coordinate else {
            return
        }

        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: self.regionRadius, longitudinalMeters: self.regionRadius)
        self.mapView?.setRegion(coordinateRegion, animated: true)
    }
}


//
//  MapViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var selectButton: UIButton!
    
    // MARK: - Properties
    // TODO: - 지정된 위치가 없는 경우 현재 위치를 default로 받아오는 기능 구현
    var isCheckMode: Bool = false

    var runningCourseData: [RunningPoint]?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupMapView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
        self.navigationBar.configureBottomLineView(color: Color.symbol.cgColor, opacity: 0.3, radius: 0.1)
    }
    
    func setupMapView() {
        
        self.mapView.setupAnnotationButton()
        self.mapView.delegate = self
//        self.mapView.centerMapOnLocation(location: self.initialLocation)

        if let runningCourseData = self.runningCourseData {
            
            self.mapView.annotationList = runningCourseData
            self.mapView.reloadAnnotation()
            self.mapView.drawRunningCourse()
        } else {
            self.mapView.configureLocationServices()
            print(self.mapView.locationManager.location)
        }
    }
    
    @IBAction func setCourseButtonPressed(_ sender: UIButton) {
        
        if self.isCheckMode {
            
            self.mapView.addAnnotation()
        } else {
            
            self.runningCourseData = self.mapView.annotationList
            self.performSegue(withIdentifier: Segue.unwindToRegisterRunningViewController, sender: self)
        }
    }
}

extension MapViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

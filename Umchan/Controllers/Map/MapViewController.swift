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
    
    // MARK: - Properties
    let initialLocation = CLLocation(latitude: 37.562310, longitude: 126.999827)
    
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
        
        self.mapView.centerMapOnLocation(location: self.initialLocation)
    }
    
    @IBAction func setCourseButtonPressed(_ sender: UIButton) {
        
        // todo: - MKMapSnapshotter으로 image캡쳐
        self.navigationController?.popViewController(animated: true)
    }
}

extension MapViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

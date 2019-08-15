//
//  MainViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var seoulMapView: SeoulMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.seoulMapView.setDistrictDelegate(self)
    }
    
    @IBAction func profileButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func goToRunButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func searchCrewByName(_ sender: Any) {
        
    }
    
}

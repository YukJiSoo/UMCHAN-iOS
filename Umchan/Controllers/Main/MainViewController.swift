//
//  MainViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var seoulMapView: SeoulMapView!
    @IBOutlet weak var contentView: UIView!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.seoulMapView.setDistrictDelegate(self)
        
        let hotCrewsView = CrewStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        self.contentView.addSubview(hotCrewsView)
    }
    
    // MARK: - Actions
    @IBAction func profileButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func goToRunButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func searchCrewByName(_ sender: Any) {
        
    }
    
}

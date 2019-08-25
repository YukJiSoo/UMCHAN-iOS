//
//  RegisterRunningViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RegisterRunningViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var runningNameLabel: UITextField!
    @IBOutlet weak var oneLineLabel: UITextField!
    @IBOutlet weak var registerLimitDateView: DateView!
    @IBOutlet weak var runningDateView: DateView!
    @IBOutlet weak var mapView: UIImageView!
    
    // MARK: - Properties
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupGesture()
        self.setupDateView()
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupGesture() {
        
        self.addGestureForEndEditting()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapForSetRunningCourse(_:)))
        self.mapView.addGestureRecognizer(tapGesture)
    }
    
    func setupDateView() {
        
        self.registerLimitDateView.delegate = self
        self.registerLimitDateView.dateLabelPlaceholder = "신청기간 설정"
        
        self.runningDateView.delegate = self
        self.runningDateView.dateLabelPlaceholder = "달리는 날 설정"
    }
    
    @objc func tapForSetRunningCourse(_ gesture: UIGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: StoryboardName.map, bundle: nil)
        let viewController = storyboard.viewController(MapViewController.self)
        viewController.modalPresentationStyle = .custom
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func unwindToRegisterRunningViewController(segue: UIStoryboardSegue) {
        
    }
    
}

extension RegisterRunningViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

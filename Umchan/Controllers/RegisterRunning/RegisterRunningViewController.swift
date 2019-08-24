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
    
    // MARK: - Properties
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGestureForEndEditting()
        self.setupNavigationBar()
        self.setupDateView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupDateView() {
        
        self.registerLimitDateView.delegate = self
        self.registerLimitDateView.dateLabelPlaceholder = "신청기간 설정"
        
        self.runningDateView.delegate = self
        self.runningDateView.dateLabelPlaceholder = "달리는 날 설정"
    }
    
    
    @IBAction func unwindToRegisterRunningViewController(segue: UIStoryboardSegue) {
        
    }
    
}

extension RegisterRunningViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

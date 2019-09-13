//
//  LoginViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NibLodable {

    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    func setup() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        let mainTabbarViewController = MainTabBarController()
        
        self.dismiss(animated: true, completion: nil)
        self.present(mainTabbarViewController, animated: true)
        
        self.activityIndicator.stopAnimating()
    }
}

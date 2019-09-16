//
//  LoginViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, NibLodable {

    // MARK: Outlets
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }
    
    // MARK: Functions
    func setup() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func dismissSelfAndPresenetMain() {
        
        let mainTabbarViewController = MainTabBarController()
        
        self.dismiss(animated: true, completion: nil)
        self.present(mainTabbarViewController, animated: true)
    }
    
    func presenetFailAlertController(with message: String) {
        
        let alertController = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "예", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func authorizeCompletion(_ response: Result<Bool, AuthAPIError>){
        
        self.activityIndicator.stopAnimating()
        self.loginButton.isEnabled = true
        self.signUpButton.isEnabled = true

        switch response {
        case .success(_):
            
            self.dismissSelfAndPresenetMain()
        case .failure(AuthAPIError.login(let message)):
            
            self.presenetFailAlertController(with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }
    
    // MARK: Actions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        guard let email = emailLabel.text, let password = passwordLabel.text else {
            debugPrint("email or password is nil")
            return
        }

        self.loginButton.isEnabled = false
        self.signUpButton.isEnabled = false
        
        AuthService.shared.authorize(email: email, password: password, completion: authorizeCompletion(_:))
    }
    
    @IBAction func unwindToLoginViewController(_ segue: UIStoryboardSegue) {
        
        self.dismissSelfAndPresenetMain()
    }
}

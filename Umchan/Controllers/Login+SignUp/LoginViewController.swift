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
        
        guard let email = emailLabel.text, let password = passwordLabel.text else {
            debugPrint("email or password is nil")
            return
        }
        
        AuthService.shared.loginUser(email: email, password: password) { (response) in
            
            self.activityIndicator.stopAnimating()
            
            switch response {
            case .success(_):
                do {
                    print(try Keychain.loadValue(for: "user_name"))
                } catch (let error) {
                    print(error)
                }
                
//                let mainTabbarViewController = MainTabBarController()
//
//                self.dismiss(animated: true, completion: nil)
//                self.present(mainTabbarViewController, animated: true)
                
            case .failure(APIError.login):
                
                let alertController = UIAlertController(title: "로그인 실패", message: "로그인실패", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "예", style: .destructive) { (action) in
                    self.dismiss(animated: true, completion: nil)
                }
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

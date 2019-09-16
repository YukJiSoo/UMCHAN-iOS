//
//  SignUpViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var nicknameLabel: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupNavigationBar()
    }
    
    func setup() {
        
        let tapForEndEditingGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapForEndEditingGesture)
        
        let tapForSelectImageGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectImagePressed(_:)))
        self.userImageView.addGestureRecognizer(tapForSelectImageGesture)
        
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .right, type: .close)
    }
    
    func presenetSuccessAlertAndUnwind() {
        
        let alertController = self.createBasicAlertViewController(title: "회원가입", message: "회원가입이 완료되었습니다")  {
            self.performSegue(withIdentifier: Segue.unwindToLoginViewController, sender: nil)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presenetFailAlertController(with message: String) {
        
        let alertController = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "예", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func registerCompletion(_ response: Result<Bool, AuthAPIError>) -> Void {
        
        self.activityIndicator.stopAnimating()
        self.signUpButton.isEnabled = true
        
        switch response {
        case .success(_):
            
            self.presenetSuccessAlertAndUnwind()
        case .failure(AuthAPIError.login(let message)):
            
            self.presenetFailAlertController(with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()

        guard
            let email = self.emailLabel.text, !email.isEmpty,
            let password = self.passwordLabel.text, !password.isEmpty,
            let name = self.nameLabel.text, !name.isEmpty,
            let nickname = self.nicknameLabel.text, !nickname.isEmpty
            else {
                
                debugPrint("All field is not filled")
                return
        }

        self.signUpButton.isEnabled = false

        AuthService.shared.register(email: email, password: password, name: name, nickname: nickname, completion: registerCompletion(_:))
    }
}
    
extension SignUpViewController: CustomNavigationBarDelegate {
        
    func rightBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.userImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

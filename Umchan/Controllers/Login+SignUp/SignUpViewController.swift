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
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        self.activityIndicator.startAnimating()
        
        // todo: - refactoring createCheckAlertViewController(title:message:) add completionHandler
        let alertController = self.createBasicAlertViewController(title: "회원가입", message: "회원가입이 완료되었습니다")  {
            self.performSegue(withIdentifier: Segue.unwindToLoginViewController, sender: nil)
        }
        
        self.activityIndicator.stopAnimating()
        self.present(alertController, animated: true, completion: nil)
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

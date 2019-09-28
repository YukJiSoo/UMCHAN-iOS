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
    @IBOutlet weak var districtPickerView: CustomPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: - Properties
    var districts = [String]()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
        self.setupNavigationBar()
        self.setupDistrictPickerView()
    }
    
    func setup() {
        
        let tapForEndEditingGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapForEndEditingGesture)
        
    }

    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .right, type: .close)
    }

    func setupDistrictPickerView() {

        self.districtPickerView.delegate = self
        self.districtPickerView.dataSource = self

        self.districts = DistrictInfoService.shared.districtCoordinates.map { $0.name ?? "" }
        self.districts.remove(at: 0)

        self.districtPickerView.reloadAllComponents()
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
        case .failure(AuthAPIError.register(let message)):

            self.presenetFailAlertController(with: message)
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

        let disctrictSelectedIndex = self.districtPickerView.selectedRow(inComponent: 0)
        let district = self.districts[disctrictSelectedIndex]

        self.signUpButton.isEnabled = false

        AuthService.shared.register(email: email, password: password, name: name, nickname: nickname, district: district, completion: registerCompletion(_:))
    }
}
    
extension SignUpViewController: CustomNavigationBarDelegate {
        
    func rightBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpViewController: UIPickerViewDataSource, UIPickerViewDelegate {


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.districts.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.districts[row]
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = view as? UILabel ?? UILabel()

        label.font = UIFont.umchanFont(size: CGFloat(22), boldState: .bold)!
        label.textColor = Color.symbol
        label.textAlignment = .center
        label.text = self.districts[row]

        return label
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(30)
    }
}

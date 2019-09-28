//
//  ProfileViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
//    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.setupProfile()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }

    func setupProfile() {
        guard let user = UserDataService.shared.user else {
            debugPrint("Fail: user info is nil")
            return
        }
        self.nameLabel.text = user.name
        self.nicknameLabel.text = user.nickname
        self.addressLabel.text = user.district
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        if Keychain.deleteValue(for: "access_token") {
            self.performSegue(withIdentifier: Segue.unwindToMainViewController, sender: nil)
        } else {
            print("fail to logout")
        }
    }
    
}

extension ProfileViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

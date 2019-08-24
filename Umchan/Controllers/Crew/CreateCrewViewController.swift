//
//  CreateCrewViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CreateCrewViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var crewNameTextField: UITextField!
    @IBOutlet weak var oneLineTextField: UITextField!
    @IBOutlet weak var crewImageView: UIImageView!
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupImageView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupImageView() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImagePressed(_:)))
        self.crewImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func selectImagePressed(_ sender: Any) {
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func createButtonPressed(_ sender: UIButton) {
    }
    

}

extension CreateCrewViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateCrewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            self.crewImageView.image = image
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

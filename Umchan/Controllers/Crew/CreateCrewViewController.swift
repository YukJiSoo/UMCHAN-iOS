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
        
        self.addGestureForEndEditting()
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

    func createCrewCompletion(_ response: Result<Bool, CrewAPIError>){

        switch response {
        case .success(_):

            let alertController = self.createBasicAlertViewController(title: "크루생성", message: "크루가 생성되었습니다.")  {
                self.dismiss(animated: true, completion: nil)
            }

            self.present(alertController, animated: true, completion: nil)
        case .failure(CrewAPIError.createCrew(let message)):

            self.presentFailAlertController("크루 생성 실패", with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    // MARK: - Actions
    @IBAction func createButtonPressed(_ sender: UIButton) {

        guard
            let name = self.crewNameTextField.text, !name.isEmpty,
            let oneLine = self.oneLineTextField.text, !oneLine.isEmpty
            else {
                debugPrint("All field is not filled")
                return
        }

        CrewService.shared.createCrew(
            name: name,
            oneLine: oneLine,
            completion: self.createCrewCompletion(_: )
        )
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

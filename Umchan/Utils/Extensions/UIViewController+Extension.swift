//
//  UIViewController+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/17/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    var imagePicker: UIImagePickerController {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        guard let delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate else {
            fatalError("fail to load UIImagePickerController")
        }
        imagePickerController.delegate = delegate
        
        return imagePickerController
    }
    
    func addGestureForEndEditting() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func createBasicAlertViewController(title: String, message: String, completion: @escaping () -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
//            self.dismiss(animated: true, completion: nil)
//        }
        let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            completion()
        }
        
        alertController.addAction(okAction)
        
        return alertController
    }
    
    @objc func closeButtonPressed(_ sender: Any) {
        print("close")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapForEndEditting(_ gesture: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func selectImagePressed(_ sender: Any) {
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }

    func presentFailAlertController(_ title: String, with message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "예", style: .destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
}

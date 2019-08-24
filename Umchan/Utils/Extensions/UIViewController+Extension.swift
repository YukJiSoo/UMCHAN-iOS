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
    
    @objc func closeButtonPressed(_ sender: Any) {
        print("close")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapForEndEditting(_ gesture: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
}

//
//  RegisterRunningViewController+DateViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension RegisterRunningViewController: DateViewDelegate {
    
    func presentDatePickerViewController(_ sender: DateView) {
        
        let viewController = DatePickerViewController()
        
        viewController.modalPresentationStyle = .custom
        viewController.title = "날짜선택"
        viewController.delegate = sender
        
        self.present(viewController, animated: true, completion: nil)
    }
    
}

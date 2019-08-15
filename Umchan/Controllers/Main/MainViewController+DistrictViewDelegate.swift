//
//  MainViewController+DistrictViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: DistrictViewDelegate {
    
    func districtView(selectedDistrict name: String) {
        
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .custom
        self.present(modalViewController, animated: true, completion: nil)
        
    }
    
}

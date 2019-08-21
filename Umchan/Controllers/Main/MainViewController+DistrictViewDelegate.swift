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
        let viewController = ModalViewController.viewController(RunningInDistrictViewController.self, titleName: name)

        self.present(viewController, animated: true, completion: nil)
    }
    
}

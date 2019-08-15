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
        
        // TODO: - 새로운 뷰컨트롤러 modal 로 띄워주기
        self.present(UIViewController(), animated: true, completion: nil)
    }
    
}

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
    
    @objc func closeButtonPressed(_ sender: Any) {
        print("close")
        self.dismiss(animated: true, completion: nil)
    }
}

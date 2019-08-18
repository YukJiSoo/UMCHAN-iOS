//
//  CustomNavigationBarDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/17/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

@objc protocol CustomNavigationBarDelegate {
    @objc optional func rightBarButtonPressed(_ sender: UIButton)
    @objc optional func leftBarButtonPressed(_ sender: UIButton)
}

//protocol CustomNavigationBarDelegate {
////    func rightBarButtonPressed()
//    func leftBarButtonPressed()
//}

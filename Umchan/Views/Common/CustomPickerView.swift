//
//  CustomPickerView.swift
//  Umchan
//
//  Created by 육지수 on 9/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView {

    override func didAddSubview(_ subview: UIView) {
        super.didAddSubview(subview)
        if subview.bounds.height <= 1.0 {
            subview.backgroundColor = UIColor.clear
        }
    }
}

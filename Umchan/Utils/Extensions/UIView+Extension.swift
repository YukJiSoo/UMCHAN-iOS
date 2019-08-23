//
//  UIView+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

extension UIView {
    
    func configureViewEdgeRounded(by value: CGFloat) {
        
        self.layer.cornerRadius = value
        self.layoutIfNeeded()
    }
}

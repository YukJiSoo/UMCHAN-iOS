//
//  RoundedView.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var roundedDegree: CGFloat = 5 {
        
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 5 {
        
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.roundedDegree
        self.layer.borderColor = self.borderColor.cgColor
        self.layer.borderWidth = self.borderWidth
    }

}

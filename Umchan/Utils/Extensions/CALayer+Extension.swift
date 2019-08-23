//
//  CALayer+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setBorder(_ edges: [UIRectEdge], width: CGFloat, color: CGColor) {
        
        for edge in edges {
            
            let border = CALayer()
            
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
                break
            default:
                debugPrint("not correct type")
                break
            }
            
            border.backgroundColor = color
            self.addSublayer(border)
        }
    }
}

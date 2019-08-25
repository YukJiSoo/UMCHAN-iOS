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
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: width)
                break
            case .bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
                break
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
                break
            case .right:
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
    
    func setShadow(_ edge: UIRectEdge, color: CGColor, opacity: Float, radius: CGFloat) {
        self.masksToBounds = false
        
        self.shadowColor = color
        self.shadowOpacity = opacity
        self.shadowRadius = radius
        
        switch edge {
        case .top:
            self.shadowOffset = CGSize(width: 0, height: -1)
            break
        case .bottom:
            self.shadowOffset = CGSize(width: 0, height: 1)
            break
        case .left:
            self.shadowOffset = CGSize(width: -1, height: 0)
            break
        case .right:
            self.shadowOffset = CGSize(width: 1, height: 0)
            break
        default:
            debugPrint("not correct type")
            break
        }
        
    }
}

//
//  CloseButton.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class CloseButton: UIButton {
    
    // MARK: - Properties
    let xLayer = CAShapeLayer()
    
    @IBInspectable var customBackgroundColor: UIColor = SYMBOL_COLOR {
        didSet {
            self.layer.backgroundColor = self.customBackgroundColor.cgColor
        }
    }
    
    @IBInspectable var customXColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            self.xLayer.strokeColor = self.customXColor.cgColor
        }
    }
    
    @IBInspectable var xLineWidth: CGFloat = 3 {
        didSet {
            self.xLayer.lineWidth = self.xLineWidth
        }
    }
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 버튼의 전체적인 윤곽과 색상설정
        self.layer.backgroundColor = self.customBackgroundColor.cgColor
        self.layer.cornerRadius = self.bounds.width * 0.5
        
        self.setXLayer()
    }
    
    
    // MARK: - Functions
    func setXLayer() {
        self.layer.addSublayer(self.xLayer)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width / 4, y: bounds.width / 4))
        path.addLine(to: CGPoint(x: bounds.width / 4 * 3, y: bounds.width / 4 * 3))
        path.move(to: CGPoint(x: bounds.width / 4 * 3, y: bounds.width / 4))
        path.addLine(to: CGPoint(x: bounds.width / 4, y: bounds.width / 4 * 3))
        
        self.xLayer.strokeColor = self.customXColor.cgColor
        self.xLayer.path = path.cgPath
        self.xLayer.lineWidth = self.xLineWidth
        
    }
    
}

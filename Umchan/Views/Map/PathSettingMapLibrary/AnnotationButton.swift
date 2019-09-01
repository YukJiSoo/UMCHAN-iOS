//
//  AnnotationButton.swift
//  Umchan
//
//  Created by 육지수 on 8/27/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class AnnotationButton: UIButton {
    
    // MARK: - Properties
    weak var delegate: AnnotationButtonDelegate?
    
    var annotiationColor: UIColor = .white {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    var isCheckMode: Bool = false {
        didSet {
            swap(&self.tintColor, &self.backgroundColor)
            self.annotiationColor = self.tintColor
        }
    }
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setup()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = self.annotiationColor.cgColor
        self.layer.borderWidth = 2
    }
    
    // MARK: - Functions
    func setup() {
        
        if let image = UIImage(named: AssetName.annotation)?.withRenderingMode(.alwaysTemplate) {
            self.tintColor = self.annotiationColor
            self.setImage(image, for: .normal)
        }
        self.backgroundColor = Color.symbol
        
        self.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let widthAnchor = self.widthAnchor.constraint(equalToConstant: 35)
        let heightAnchor = self.heightAnchor.constraint(equalToConstant: 40)
        
        NSLayoutConstraint.activate([ widthAnchor, heightAnchor ])
    }
    
    func reverseColor() {
        swap(&self.tintColor, &self.backgroundColor)
        
    }
    
    @objc func pressed(_ sender: UIButton) {
        
        self.isCheckMode = !self.isCheckMode
        self.delegate?.pressed(isCheckMode: self.isCheckMode)
    }
}

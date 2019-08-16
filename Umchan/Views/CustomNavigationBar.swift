//
//  CustomNavigationBar.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    var titleLabel: UILabel!
    var rightButton: UIButton?
    var leftButton: UIButton?
    
    @IBInspectable var barItemSize: CGFloat = 30
    @IBInspectable var padding: CGFloat = 15
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        self.setupViews()
        print("2")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupViews()
        print("3")
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    // MARK: - Functions
    func setupViews() {
        
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.titleLabel.text = "움찬러너"
        self.titleLabel.font = UIFont(name: "NanumSquareOTF_ac", size: CGFloat(20))
        self.titleLabel.textColor = SYMBOL_COLOR
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.rightButton = UIButton(frame: CGRect.zero)
        self.rightButton?.setImage(UIImage(named: "user"), for: .normal)
        self.rightButton?.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.titleLabel)
        if let rightButton = self.rightButton {
            self.addSubview(rightButton)
        }
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20).isActive = true
        
        if let rightButtonTrailingAnchor = self.rightButton?.trailingAnchor {
            self.trailingAnchor.constraint(equalTo: rightButtonTrailingAnchor, constant: self.padding).isActive = true
        }
        self.rightButton?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 20).isActive = true
        self.rightButton?.widthAnchor.constraint(equalToConstant: barItemSize).isActive = true
        self.rightButton?.heightAnchor.constraint(equalToConstant: barItemSize).isActive = true
        
    }
}

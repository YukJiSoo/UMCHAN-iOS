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
    
    // MARK: - Constants
    enum BarType {
        case start, modalStart, navigationing
    }
    
    enum BarButtonType {
        case back, close, profile
    }
    
    enum BarButtonLocation {
        case left, right
    }
    
    // MARK: - SubViews
    var titleLabel = UILabel()
    var bottomLineView = UIView()
    var rightButton: UIButton?
    var leftButton: UIButton?
    
    // MARK: - Properties
    @IBInspectable var barItemSize: CGFloat = 30
    @IBInspectable var padding: CGFloat = 15
    @IBInspectable var bottomLineHeight: CGFloat = 1
    @IBInspectable var title: String = "Title" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    
    // Todo: @IBInspectable 이용해서 enum Type 처리
    var barType: BarType = .start
    
    var delegate: CustomNavigationBarDelegate?
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureBottomLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.configureBottomLineView()
        self.configureTitleLabel(with: self.title)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.configureBottomLineView()
        self.configureTitleLabel(with: self.title)
    }
    
    // MARK: - Functions
    func configure(title: String, rightBarButtonType: BarButtonType?, leftBarButtonType: BarButtonType?) {
        
        self.configureTitleLabel(with: title)
        
        if let rightBarButtonType = rightBarButtonType {
            self.configureButton(location: .right, type: rightBarButtonType)
        }
        
        if let leftBarButtonType = leftBarButtonType {
            self.configureButton(location: .left, type: leftBarButtonType)
        }
        
    }
    
    func configureBottomLineView() {
        
        self.bottomLineView.backgroundColor = Color.symbol
        
        self.addSubview(self.bottomLineView)
        
        self.bottomLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.bottomLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.bottomLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.bottomLineView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.bottomLineView.heightAnchor.constraint(equalToConstant: self.bottomLineHeight).isActive = true
    }
    
    func configureTitleLabel(with title: String?) {
        
        self.titleLabel.text = title ?? self.title
        self.titleLabel.font = UIFont.umchanFont(size: 20, boldState: .bold)
        self.titleLabel.textColor = Color.symbol
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.titleLabel)
        
        // set constraint
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func configureButton(location: BarButtonLocation, type: BarButtonType) {
        
        var button: UIButton
        switch type {
        case .back:
            button = UIButton()
            button.setImage(UIImage(named: AssetName.back), for: .normal)
        case .close:
            button = CloseButton()
        case .profile:
            button = UIButton()
            button.setImage(UIImage(named: AssetName.user), for: .normal)
        }
        
        self.addSubview(button)
        
        // set constraint
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: self.barItemSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: self.barItemSize).isActive = true
        
        switch location {
        case .left:
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.padding).isActive = true
            button.addTarget(self, action: #selector(self.leftBarButtonPressed(_:)), for: .touchUpInside)
            
            self.leftButton = button
        case .right:
            self.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: self.padding).isActive = true
            button.addTarget(self, action: #selector(self.rightBarButtonPressed(_:)), for: .touchUpInside)
            
            self.rightButton = button
        }
        
    }
    
    @objc func leftBarButtonPressed(_ sender: UIButton) {
        self.delegate?.leftBarButtonPressed?(sender)
    }
    
    @objc func rightBarButtonPressed(_ sender: UIButton) {
        
        self.delegate?.rightBarButtonPressed?(sender)
    }
}

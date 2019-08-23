//
//  CrewView.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class CrewView: UIStackView {
    
    // MARK: - SubViews
    var imageView: UIImageView!
    var nameLabel: PaddingLabel!
    var numberOfPeopleLabel: PaddingLabel!
    
    // MARK: - Properties
    var widthOfView: CGFloat = 150 {
        didSet {
            self.widthAnchor.constraint(equalToConstant: self.widthOfView)
        }
    }
    
    var heightOfView: CGFloat = 180 {
        didSet {
            self.heightAnchor.constraint(equalToConstant: self.heightOfView)
        }
    }
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupStackView()
        self.setupSubView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupStackView()
        self.setupSubView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setupStackView()
        self.setupSubView()
    }
    
    // MARK: - Functions
    func setupStackView() {
        
        self.configure(axis: .vertical, spacing: 10)
        self.widthAnchor.constraint(equalToConstant: self.widthOfView).isActive = true
        self.heightAnchor.constraint(equalToConstant: self.heightOfView).isActive = true
    }
    
    func setupSubView() {
        
        self.setupImageView()
        self.setupLabel()
    }
    
    func setupImageView() {
        
        self.imageView = UIImageView(frame: .zero)
        self.imageView.configureViewEdgeRounded(by: 5)
        self.imageView.backgroundColor = .orange
        self.addArrangedSubview(self.imageView)
    }
    
    func setupLabel() {
        
        self.nameLabel = PaddingLabel(frame: .zero)
        self.nameLabel.text = "Initialize"
        self.nameLabel.font = UIFont.umchanFont(size: CGFloat(13), boldState: .light)
        self.nameLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        self.numberOfPeopleLabel = PaddingLabel(frame: .zero)
        self.numberOfPeopleLabel.text = "Initialize"
        self.numberOfPeopleLabel.font = UIFont.umchanFont(size: CGFloat(13), boldState: .light)
        self.numberOfPeopleLabel.padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        self.addArrangedSubview(self.nameLabel)
        self.addArrangedSubview(self.numberOfPeopleLabel)
        
    }
    
    func configure(crew: Crew) {
        
        self.imageView.image = UIImage(named: crew.image)
        self.nameLabel.text = crew.name
        self.numberOfPeopleLabel.text = "\(crew.numberOfPeople)"
    }
    
}

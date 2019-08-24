//
//  ScrollableStackView.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ScrollableStackView: UIScrollView {

    // MARK: - SubViews
    var contentView = UIStackView(frame: .zero)
    
    // MARK: - Life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setContentView()
    }
    
    // MARK: - Functions
    func setContentView() {
        
        self.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        self.contentView.isLayoutMarginsRelativeArrangement = true
        
        self.contentView.configure(axis: .vertical, distribution: .fillEqually, alignment: .fill, spacing: CGFloat(20))
        
        self.addSubview(self.contentView)
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = self.contentView.topAnchor.constraint(equalTo: self.topAnchor)
        let bottomAnchor = self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let leadingAnchor = self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let trailingAnchor = self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let widthAnchor = self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor, widthAnchor ])
        
    }
    
    func configureSubViews(subViews: [UIView]) {
        
        for view in subViews {
            self.contentView.addArrangedSubview(view)
        }
    }
    
    func initializeSubViews() {
        
        for subView in self.contentView.arrangedSubviews {
            self.contentView.removeArrangedSubview(subView)
        }
    }

}

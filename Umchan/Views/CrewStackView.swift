//
//  ScrollableStackView.swift
//  Umchan
//
//  Created by 육지수 on 8/18/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CrewStackView: UIStackView {

    // MARK: - SubViews
    var contentView = UIView()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupItems()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupItems()
    }
    
    // MARK: - Functions
    func setupItems() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        
        let a = UIView(frame: .zero)
        a.backgroundColor = .blue
        self.addArrangedSubview(a)
        
        let b = UIView(frame: .zero)
        b.backgroundColor = .red
        self.addArrangedSubview(b)
        
        let c = UIView(frame: .zero)
        c.backgroundColor = .gray
        self.addArrangedSubview(c)
        
    }
}

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
        print("스택")
        
        let a = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        a.backgroundColor = .blue
        self.addArrangedSubview(a)
        
    }
}

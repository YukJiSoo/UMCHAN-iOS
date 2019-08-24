//
//  UmchanCreateButtom.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class UmchanCreateButtom: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(title: String) {
        
        self.setImage(UIImage(named: AssetName.shoes), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        self.setTitleColor(Color.symbol, for: .normal)
    }
    

}

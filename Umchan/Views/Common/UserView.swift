//
//  UserView.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

@IBDesignable
class UserView: UIView, NibLodable {
    
    @IBOutlet weak var nameLabel: UILabel!

    class func instanceFromNib() -> UserView {
        return UINib(nibName: UserView.nibId, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserView
    }
    
    func configure(user: User) {
        
        self.nameLabel.text = user.nickname
    }
    
}

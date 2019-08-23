//
//  TabBarController.swift
//  Umchan
//
//  Created by 육지수 on 8/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(UIFont.fontNames(forFamilyName: "NanumSquareOTF_ac"))
        self.selectedIndex = 1
    }

}

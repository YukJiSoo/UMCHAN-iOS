//
//  CustomSearchBarDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

protocol CustomSearchBarDelegate {
    
    func backButtonPressed()
    func searchButtonPressed(wantToSearch: String)
}

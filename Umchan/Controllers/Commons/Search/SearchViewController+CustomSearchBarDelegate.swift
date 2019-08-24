//
//  SearchViewController+CustomSearchBarDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

extension SearchViewController: CustomSearchBarDelegate {
    
    func backButtonPressed() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchButtonPressed(wantToSearch: String) {
        // todo
        self.loadData()
    }
    
    
}

//
//  SearchRunningViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class SearchRunningViewController: SearchViewController {

    override var searchType: CustomSearchBar.SearchType {
        return .running
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupSearchBar() {
        super.setupSearchBar()
        self.searchBar.configure(searchType: self.searchType)
    }

}

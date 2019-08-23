//
//  SearchViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - SubViews
    var searchBar = CustomSearchBar(frame: .zero)
    
    // MARK: - Properties
    var searchType: CustomSearchBar.SearchType {
        return .none
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.setupSearchBar()
    }
    
    // MARK: - Functions
    func setupSearchBar() {
        
        self.searchBar.delegate = self
        
        self.view.addSubview(self.searchBar)
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
    }
    
    
}

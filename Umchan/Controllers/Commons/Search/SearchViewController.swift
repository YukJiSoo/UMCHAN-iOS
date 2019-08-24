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
    var activityIndicator = UIActivityIndicatorView(frame: .zero)
    
    // MARK: - Properties
    var searchType: CustomSearchBar.SearchType {
        return .none
    }
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.view.endEditing(true)
            }
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.setupSearchBar()
        self.setGestureRecognoizer()
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
    
    func setGestureRecognoizer() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapForEndEditting(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func setupActivityIndicator() {
        
        self.activityIndicator.style = .whiteLarge
        self.activityIndicator.color = Color.symbol
        self.activityIndicator.hidesWhenStopped = true
        
        self.view.addSubview(self.activityIndicator)
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXAnchor = self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let centerYAnchor = self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        
        NSLayoutConstraint.activate([ centerXAnchor, centerYAnchor ])
    }
    
    func loadData() {
    }
    
}

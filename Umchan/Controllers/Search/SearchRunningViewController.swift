//
//  SearchRunningViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class SearchRunningViewController: SearchViewController {

    // MARK: - SubViews
    var tableView = UITableView(frame: .zero)
    
    // MARK: - Properties
//    var runnings = [Running]()
    var runnings = [Running]()
    
    // MARK: - Life cycles
    override var searchType: CustomSearchBar.SearchType {
        return .running
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.setupXib()
        self.setupActivityIndicator()
    }
    
    // MARK: - Functions
    override func setupSearchBar() {
        super.setupSearchBar()
        
        self.searchBar.delegate = self
        self.searchBar.configure(searchType: self.searchType)
    }
    
    override func loadData() {
        
        self.isLoading = true
        
        // get data from api server
        // reload tableView
        // set tableView visible
        self.tableView.isHidden = false
        self.tableView.reloadData()
        
        self.isLoading = false
    }
    
    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.isHidden = true
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
        
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
    }
    
    func setupXib() {
        
        let runningCellNib = UINib(nibName: RunningTableViewCell.nibId, bundle: nil)
        let emptyNoticeCellNib = UINib(nibName: EmptyTableViewCell.nibId, bundle: nil)
        
        self.tableView.register(runningCellNib, forCellReuseIdentifier: RunningTableViewCell.nibId)
        self.tableView.register(emptyNoticeCellNib, forCellReuseIdentifier: EmptyTableViewCell.nibId)
        
    }

}


extension SearchRunningViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.runnings.count == 0 ? 1 : self.runnings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.runnings.count == 0 {
            guard let emptyNoticeCell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.nibId, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            
            emptyNoticeCell.configure(stateText: Statement.hsaNoRunning, state: .running)
            return emptyNoticeCell
        }
        
        guard let runningCell = tableView.dequeueReusableCell(withIdentifier: RunningTableViewCell.nibId, for: indexPath) as? RunningTableViewCell else {
            return UITableViewCell()
        }
        
//        runningCell.configure(running: self.runnings[indexPath.row])
        return runningCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
}

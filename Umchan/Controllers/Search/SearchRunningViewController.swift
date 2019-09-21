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
    var tableView = UITableView()
    
    // MARK: - Properties
    var runnings = [RunningListQueryType]()
    
    // MARK: - Life cycles
    override var searchType: CustomSearchBar.SearchType {
        return .running
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupActivityIndicator()
        self.setupTableView()
        self.setupXib()
    }
    
    // MARK: - Functions
    override func setupSearchBar() {
        super.setupSearchBar()
        
        self.searchBar.delegate = self
        self.searchBar.configure(searchType: self.searchType)
    }
    
    override func loadData() {
        
        self.isLoading = true
        
        guard let writedText = self.searchBar.writedText, writedText != "" else {
            debugPrint("text is nil")
            return
        }

        RunningService.shared.runningList(name: writedText, completion: self.loadRunningListCompletion(_:))
    }

    func loadRunningListCompletion(_ response: Result<[RunningListQueryType], RunningAPIError>) {
        self.isLoading = false

        switch response {
        case .success(_):

            guard let data = try? response.get() else {
                debugPrint("cannot get data")
                return
            }

            self.runnings = data

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .failure(RunningAPIError.runningList(let message)):

            self.presentFailAlertController("러닝 검색 실패", with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)

        self.tableView.isUserInteractionEnabled = true
        self.tableView.allowsSelection = true
        self.tableView.allowsSelectionDuringEditing = true

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

extension SearchRunningViewController: UITableViewDataSource {
    
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

        runningCell.configure(running: self.runnings[indexPath.row])
        return runningCell
    }

}

extension SearchRunningViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hi")
        let storyboard = UIStoryboard(name: StoryboardName.running, bundle: nil)
        let viewController = storyboard.viewController(RunningViewController.self)

        if let runningID = self.runnings[indexPath.row].id {
            viewController.id = runningID
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }
}

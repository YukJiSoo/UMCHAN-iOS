//
//  RunningHistoryViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningHistoryListViewController: UIViewController, NibLodable {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    // MARK: - SubViews
    var tableView: UITableView?
    
    // MARK: - Properties
    var runningHistorys = [
        Running(name: "test1", oneLine: "test1", runningDate: Date(), registerDate: Date()),
        Running(name: "test1", oneLine: "test1", runningDate: Date(), registerDate: Date()),
        Running(name: "test1", oneLine: "test1", runningDate: Date(), registerDate: Date()),
    ]
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    // MARK: - Functions
    func setup() {
        
        self.setupNavigationBar()
        
        guard !runningHistorys.isEmpty else {
            self.setupEmptyCase()
            return
        }
        
        self.setupTableView()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.configureButton(location: .right, type: .profile)
        self.navigationBar.configureBottomLineView(color: Color.symbol.cgColor, opacity: 0.5, radius: 0.1)
    }
    
    func setupEmptyCase() {
        
        // add views
        let emptyImageView = UIImageView(frame: .zero)
        
        emptyImageView.image = UIImage(named: AssetName.empty)
        emptyImageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(emptyImageView)
        
        let emptyLabel = UILabel(frame: .zero)
        
        emptyLabel.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        emptyLabel.text = "러닝기록이 없습니다"
        emptyLabel.textColor = Color.symbolTransparent
        
        self.view.addSubview(emptyLabel)
        
        // set Constraint
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let emptyImageViewCenterXAnchor = emptyImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let emptyImageViewCenterYAnchor = emptyImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let emptyImageViewWidthAnchor = emptyImageView.widthAnchor.constraint(equalToConstant: 200)
        let emptyImageViewHeightAnchor = emptyImageView.heightAnchor.constraint(equalToConstant: 200)
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let emptyLabelTopAnchor = emptyLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor, constant: 30)
        let emptyLabelCenterXAnchor = emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        NSLayoutConstraint.activate([
            emptyImageViewCenterXAnchor,
            emptyImageViewCenterYAnchor,
            emptyImageViewWidthAnchor,
            emptyImageViewHeightAnchor,
            emptyLabelTopAnchor,
            emptyLabelCenterXAnchor
        ])
    }
    
    func setupTableView() {
        
        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let topAnchor = tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
        
        self.tableView = tableView
        
        let runningHistoryCellNib = UINib(nibName: RunningHistoryListTableViewCell.nibId, bundle: nil)
        self.tableView?.register(runningHistoryCellNib, forCellReuseIdentifier: RunningHistoryListTableViewCell.nibId)
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }

}

extension RunningHistoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.runningHistorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RunningHistoryListTableViewCell.nibId, for: indexPath) as? RunningHistoryListTableViewCell else {
            debugPrint("err: fail to convert \(RunningHistoryListTableViewCell.nibId)")
            return UITableViewCell()
        }
        
        cell.configure(running: runningHistorys[indexPath.row])
        
        return cell
    }
    
    
}

extension RunningHistoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: StoryboardName.runningHistory, bundle: nil)
        let viewController = storyboard.viewController(RunningHistoryViewController.self)
        viewController.running = self.runningHistorys[indexPath.row]
        
        self.present(viewController, animated: true, completion: nil)
    }
}

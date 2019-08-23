//
//  RunningHistoryViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningHistoryViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    
    // MARK: - SubViews
    var tableView: UITableView?
    
    // MARK: - Properties
    var runningHistorys = [Running]()
    
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
        
    }
    

}

//
//  RunningHistoryViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningHistoryViewController: UIViewController, NibLodable {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var leaderView: UIStackView!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var runningDateLabel: UILabel!
    @IBOutlet weak var membersView: UIStackView!
    
    // MARK: - Properties
    var running: Running?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupSubViews()
        self.setupNavigationBar()
        self.setupParticipatingLeaderAndMembers()
    }
    
    // MARK: - Functions
    func setupSubViews() {
        
        self.oneLineLabel.text = self.running?.oneLine
        
        if let running = running {
            let dateFormatter = DateFormatter.basicFormatter(format: DateFormat.date, locale: DateFormat.locale)
            self.runningDateLabel.text = dateFormatter.string(from: running.runningDate)
        }
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        
        if let title = self.running?.name {
            self.navigationBar.title = title
        }
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupParticipatingLeaderAndMembers() {
        
        let captinViewNib = UserView.instanceFromNib()
        let firstMemberViewNib = UserView.instanceFromNib()
        let secondMemberViewNib = UserView.instanceFromNib()
        
        self.leaderView.addArrangedSubview(captinViewNib)
        self.membersView.addArrangedSubview(firstMemberViewNib)
        self.membersView.addArrangedSubview(secondMemberViewNib)
    }

}

extension RunningHistoryViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

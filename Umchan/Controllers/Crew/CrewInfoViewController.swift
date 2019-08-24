//
//  CrewInfoViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CrewInfoViewController: UIViewController, NibLodable {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var CrewCaptinView: UIStackView!
    @IBOutlet weak var CrewMembersView: UIStackView!
    
    // MARK: - Properties
    var crew: Crew?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupData()
        self.setupNavigationBar()
        self.setupCaptinAndMembers()
    }
    
    // MARK: - Functions
    func setupData() {
        
        self.nameLabel.text = crew?.name
        self.oneLineLabel.text = crew?.oneLine
        self.creationDateLabel.text = crew?.creationDate
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        
        if let title = self.crew?.name {
            self.navigationBar.title = title
        }
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupCaptinAndMembers() {
        
        let captinViewNib = UserView.instanceFromNib()
        captinViewNib.configure(user: User(name: "크루장"))
        let firstMemberViewNib = UserView.instanceFromNib()
        firstMemberViewNib.configure(user: User(name: "크루원1"))
        let secondMemberViewNib = UserView.instanceFromNib()
        secondMemberViewNib.configure(user: User(name: "크루원2"))
        
        self.CrewCaptinView.addArrangedSubview(captinViewNib)
        self.CrewMembersView.addArrangedSubview(firstMemberViewNib)
        self.CrewMembersView.addArrangedSubview(secondMemberViewNib)
    }
    
    @IBAction func requestButtonPressed(_ sender: UIButton) {
        
        let alertController = self.createCheckAlertViewController(title: "참가신청", message: "크루장에게 참가 신청을 보냈습니다")
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension CrewInfoViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

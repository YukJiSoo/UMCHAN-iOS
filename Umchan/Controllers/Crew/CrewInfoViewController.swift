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
    var crew: CrewListQueryResult?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSubViews()
        self.setupNavigationBar()
        self.setupCaptinAndMembers()
    }
    
    // MARK: - Functions
    func setupSubViews() {

        self.nameLabel.text = crew?.name
        self.oneLineLabel.text = crew?.oneLine
//        self.creationDateLabel.text = crew?.creationDate
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
        captinViewNib.configure(user: User(name: "크루장", nickname: "별명", imagePath: "이미지", location: Location(latitude: 20.0, longitude: 10.2)))
        let firstMemberViewNib = UserView.instanceFromNib()
        firstMemberViewNib.configure(user: User(name: "크루월1", nickname: "별명", imagePath: "이미지", location: Location(latitude: 20.0, longitude: 10.2)))
        let secondMemberViewNib = UserView.instanceFromNib()
        secondMemberViewNib.configure(user: User(name: "크루월2", nickname: "별명", imagePath: "이미지", location: Location(latitude: 20.0, longitude: 10.2)))
        
        self.CrewCaptinView.addArrangedSubview(captinViewNib)
        self.CrewMembersView.addArrangedSubview(firstMemberViewNib)
        self.CrewMembersView.addArrangedSubview(secondMemberViewNib)
    }
    
    @IBAction func requestButtonPressed(_ sender: UIButton) {
        
        let alertController = self.createBasicAlertViewController(title: "참가신청", message: "크루장에게 참가 신청을 보냈습니다") {
            self.dismiss(animated: true, completion: nil)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension CrewInfoViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

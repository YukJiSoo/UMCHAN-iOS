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
    var crew: CrewQueryType?
    var memberState: MemberStateType?
    var id: String?
    var district: String?

    var captinViews = [UserView]()
    var memberViews = [UserView]()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.setupData()
    }
    
    // MARK: - Functions
    func setupData() {
        guard let id = self.id, let district = self.district else {
            return
        }

        CrewService.shared.crew(id: id, district: district) { (response) in

            switch response {
            case .success(_):

                guard let data = try? response.get() else {
                    debugPrint("cannot get data")
                    return
                }

                self.crew = data.0
                self.memberState = data.1
                DispatchQueue.main.async {
                    self.setupSubViews()
                }
            case .failure(CrewAPIError.crew(let message)):

                print(message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    func setupSubViews() {

        self.nameLabel.text = crew?.name
        self.oneLineLabel.text = crew?.oneLine

        if let crew = self.crew {
            self.navigationBar.title = crew.name ?? "크루"

            let creationDate = convertCreationDateString(crew: crew)
            self.creationDateLabel.text = creationDate
        }

        self.setupLeaderAndMembers()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        
        if let title = self.crew?.name {
            self.navigationBar.title = title
        }
        self.navigationBar.configureButton(location: .left, type: .close)
    }
    
    func setupLeaderAndMembers() {
        guard
            let leaderNickname = self.crew?.leader?.nickname,
            let leaderID = self.crew?.leader?.userId
            else {
                return
        }

        self.captinViews.forEach { (view) in
            view.removeFromSuperview()
        }

        for view in self.memberViews {
            view.removeFromSuperview()
        }

        let captinViewNib = UserView.instanceFromNib()
        captinViewNib.configure(user: User(id: leaderID, name: "leaderName", nickname: leaderNickname, district: "leaderDistrict"))

        self.captinViews.append(captinViewNib)
        self.CrewCaptinView.addArrangedSubview(captinViewNib)

        self.crew?.members?.forEach({ (member) in
            guard
                let memberNickname = member?.nickname,
                let memberID = member?.userId
                else {
                    return
            }

            let memberViewNib = UserView.instanceFromNib()
            memberViewNib.configure(user: User(id: memberID, name: "memberName", nickname: memberNickname, district: "memberDistrict"))

            self.memberViews.append(memberViewNib)
            self.CrewMembersView.addArrangedSubview(memberViewNib)
        })
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

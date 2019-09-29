//
//  CrewInfoViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MyCrewViewController: UIViewController, NibLodable {
    
    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var CrewCaptinView: UIStackView!
    @IBOutlet weak var CrewMembersView: UIStackView!
    // member 전용
    @IBOutlet weak var goOutCrewButton: UIButton!
    // leader 전용
    @IBOutlet weak var manageCrewButton: UIButton!
    @IBOutlet weak var disassempleCrewButton: UIButton!

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
        self.setupButtons()
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

    func setupButtons() {
        guard
            let leaderID = self.crew?.leader?.userId,
            let myID = UserDataService.shared.user?.id,
            leaderID == myID
            else {
                if self.manageCrewButton != nil {
                    self.manageCrewButton.removeFromSuperview()
                    self.disassempleCrewButton.removeFromSuperview()
                }
                return
        }

        if self.goOutCrewButton != nil {
            self.goOutCrewButton.removeFromSuperview()
        }
    }

    @IBAction func goOutCrewButtonPressed(_ sender: UIButton) {
        guard
            let id = self.id,
            let district = self.district
            else {
                debugPrint("id, district is nil")
                return
        }

        CrewService.shared.goOutCrew(id: id, district: district) { (response) in

            switch response {
            case .success(_):

                let alertController = self.createBasicAlertViewController(title: "크루탈퇴", message: "크루에서 탈퇴했습니다")  {
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(alertController, animated: true, completion: nil)
            case .failure(CrewAPIError.goOutCrew(let message)):

                self.presentFailAlertController("탈퇴 실패", with: message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    @IBAction func manageCrewButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: StoryboardName.crewInfo, bundle: nil)
        let viewController = storyboard.viewController(ManageCrewMemberViewController.self)

        if
            let id = self.id,
            let district = self.district,
            let awaitMembers = self.crew?.awaitMembers,
            let members = self.crew?.members {

            viewController.id = id
            viewController.district = district
            viewController.awaitMembers = awaitMembers as? [CrewQueryType.AwaitMember]
            viewController.members = members as? [CrewQueryType.Member]
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func disassempleCrewButtonPressed(_ sender: UIButton) {
        guard
            let id = self.id,
            let district = self.district
            else {
                debugPrint("id, district is nil")
                return
        }

        CrewService.shared.disassembleCrew(id: id, district: district) { (response) in

            switch response {
            case .success(_):

                let alertController = self.createBasicAlertViewController(title: "크루해체", message: "크루를 해체했습니다")  {
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(alertController, animated: true, completion: nil)
            case .failure(CrewAPIError.disassembleCrew(let message)):

                self.presentFailAlertController("해체 실패", with: message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }
}

extension MyCrewViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

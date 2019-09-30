//
//  CrewViewController.swift
//  Umchan
//
//  Created by 육지수 on 9/30/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import CoreLocation

class CrewViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var leaderView: UIStackView!
    @IBOutlet weak var membersView: UIStackView!
    @IBOutlet weak var bottomButton: UIButton!

    var loadingView = UIView(frame: .zero)
    var indicatorView = UIActivityIndicatorView(style: .whiteLarge)

    // MARK: - Properties
    var id: String?
    var district: String?
    var crew: CrewQueryType?
    var memberState: MemberStateType?

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // white back ground
        self.view.addSubview(self.loadingView)
        self.loadingView.backgroundColor = .white
        self.loadingView.translatesAutoresizingMaskIntoConstraints = false
        self.loadingView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        self.loadingView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

        // indicator
        self.indicatorView.color = Color.symbol
        self.view.addSubview(self.indicatorView)

        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        self.indicatorView.startAnimating()
        
        self.setupData()
        self.setupNavigationBar()
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

                    self.loadingView.isHidden = true
                    self.indicatorView.stopAnimating()
                }
            case .failure(CrewAPIError.crewList(let message)):

                print(message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    func setupSubViews() {

        self.oneLineLabel.text = self.crew?.oneLine

        if let crew = self.crew {
            self.navigationBar.title = crew.name ?? "크루"

            let creationDate = convertCreationDateString(crew: crew)
            self.creationDateLabel.text = creationDate
        }

        self.setupLeaderAndMembers()
        self.setupBottomButton()
    }

    func setupNavigationBar() {

        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
    }

    func setupLeaderAndMembers() {

        guard
            let leaderNickname = self.crew?.leader?.nickname,
            let leaderID = self.crew?.leader?.userId
            else {
                return
        }

        let captinViewNib = UserView.instanceFromNib()
        captinViewNib.configure(user: User(id: leaderID, name: "leaderName", nickname: leaderNickname, district: "leaderDistrict"))

        self.leaderView.addArrangedSubview(captinViewNib)

        self.crew?.members?.forEach({ (member) in
            guard
                let memberNickname = member?.nickname,
                let memberID = member?.userId
                else {
                    return
            }

            let memberViewNib = UserView.instanceFromNib()
            memberViewNib.configure(user: User(id: memberID, name: "memberName", nickname: memberNickname, district: "memberDistrict"))

            self.membersView.addArrangedSubview(memberViewNib)
        })
    }

    func setupBottomButton() {
        guard
            let userNickname = UserDataService.shared.user?.nickname,
            let leaderNickname = self.crew?.leader?.nickname,
            userNickname != leaderNickname
            else {
                self.bottomButton.isHidden = true
                return
        }

        guard let memberState = self.memberState else {
            return
        }

        self.bottomButton.isHidden = false

        if memberState == .none {
            self.bottomButton.isEnabled = true
        } else {
            self.bottomButton.isEnabled = false
            self.bottomButton.backgroundColor = memberState == .wait ? .lightGray : #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.bottomButton.setTitleColor(.white, for: .normal)

            let buttonTitle = memberState == .wait ? "수락 대기중" : "참가중"
            self.bottomButton.setTitle(buttonTitle, for: .normal)
        }
    }

    func applyRunningCompletion(_ response: Result<Bool, CrewAPIError>) {

        switch response {
        case .success(_):

            let alertController = self.createBasicAlertViewController(title: "참가신청", message: "리더에게 참가 신청을 보냈습니다")  {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alertController, animated: true, completion: nil)
        case .failure(CrewAPIError.applyCrew(let message)):

            self.presentFailAlertController("참가 신청 실패", with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    @IBAction func requestButtonPressed(_ sender: UIButton) {

        if let id = self.id, let district = self.district {
            CrewService.shared.applyCrew(id: id, district: district, completion: self.applyRunningCompletion(_:))
        }
    }

}

extension CrewViewController: CustomNavigationBarDelegate {

    func leftBarButtonPressed(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
}

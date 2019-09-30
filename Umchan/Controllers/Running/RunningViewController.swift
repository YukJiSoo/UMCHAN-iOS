//
//  RunningViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import CoreLocation

class RunningViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var registerDateLabel: UILabel!
    @IBOutlet weak var runningDateLabel: UILabel!
    @IBOutlet weak var leaderView: UIStackView!
    @IBOutlet weak var membersView: UIStackView!
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var bottomButton: UIButton!

    var loadingView = UIView(frame: .zero)
    var indicatorView = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Properties
    var id: String?
    var district: String?
    var running: RunningQueryType?
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
        RunningService.shared.running(id: id, district: district) { (response) in

            switch response {
            case .success(_):

                guard let data = try? response.get() else {
                    debugPrint("cannot get data")
                    return
                }

                self.running = data.0
                self.memberState = data.1
                DispatchQueue.main.async {
                    self.setupSubViews()
                    
                    self.loadingView.isHidden = true
                    self.indicatorView.stopAnimating()
                }
            case .failure(RunningAPIError.runningList(let message)):

                print(message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

    func setupSubViews() {
        
        self.oneLineLabel.text = self.running?.oneLine

        if let running = self.running {
            self.navigationBar.title = running.name ?? "러닝"

            let (runningDate, registerDate) = convertRunningDateString(running: running)
            self.registerDateLabel.text = registerDate
            self.runningDateLabel.text = runningDate
        }

        self.setupLeaderAndMembers()
        self.setupMapView()
        self.setupBottomButton()
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
    }
    
    func setupLeaderAndMembers() {

        guard
            let leaderName = self.running?.leader?.name,
            let leaderNickname = self.running?.leader?.nickname,
            let leaderDistrict = self.running?.leader?.district,
            let leaderID = self.running?.leader?.userId
        else {
            return
        }

        let captinViewNib = UserView.instanceFromNib()
        captinViewNib.configure(user: User(id: leaderID, name: leaderName, nickname: leaderNickname, district: leaderDistrict))

        self.leaderView.addArrangedSubview(captinViewNib)

        self.running?.members?.forEach({ (member) in
            guard
                let memberName = member?.name,
                let memberNickname = member?.nickname,
                let memberDistrict = member?.district,
                let memberID = member?.userId
            else {
                    return
            }

            let memberViewNib = UserView.instanceFromNib()
            memberViewNib.configure(user: User(id: memberID, name: memberName, nickname: memberNickname, district: memberDistrict))

            self.membersView.addArrangedSubview(memberViewNib)
        })
    }

    func setupMapView() {

        guard let runningPointDatas = self.running?.runningPoints else {
            return
        }

        var index = 0
        runningPointDatas.forEach { (data) in
            guard let latitude = data?.latitude, let longitude = data?.longitude else {
                return
            }

            index += 1
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let runningPoint = RunningPoint(coordinate: coordinate, order: index)
            self.mapView.annotationList.append(runningPoint)
        }

        self.mapView.reloadAnnotation()
        self.mapView.drawRunningCourse()
    }

    func setupBottomButton() {
        guard
            let userNickname = UserDataService.shared.user?.nickname,
            let leaderNickname = self.running?.leader?.nickname,
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

    func applyRunningCompletion(_ response: Result<Bool, RunningAPIError>) {

        switch response {
        case .success(_):

            let alertController = self.createBasicAlertViewController(title: "참가신청", message: "리더에게 참가 신청을 보냈습니다")  {
                self.dismiss(animated: true, completion: nil)
            }
            self.present(alertController, animated: true, completion: nil)
        case .failure(RunningAPIError.createRunning(let message)):

            self.presentFailAlertController("참가 신청 실패", with: message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    @IBAction func requestButtonPressed(_ sender: UIButton) {

        if let id = self.id, let district = self.district {
            RunningService.shared.applyRunning(id: id, district: district, completion: applyRunningCompletion)
        }
    }
    
}

extension RunningViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

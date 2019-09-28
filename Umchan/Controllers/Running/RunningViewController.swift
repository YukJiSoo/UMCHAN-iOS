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
    
    // MARK: - Properties
    var id: String?
    var district: String?
    var running: RunningQueryType?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

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

                self.running = data
                DispatchQueue.main.async {
                    self.setupSubViews()
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
    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
    }
    
    func setupLeaderAndMembers() {

        guard
            let leaderName = self.running?.leader?.name,
            let leaderNickname = self.running?.leader?.nickname,
            let leaderDistrict = self.running?.leader?.district else {
            return
        }

        let captinViewNib = UserView.instanceFromNib()
        captinViewNib.configure(user: User(name: leaderName, nickname: leaderNickname, district: leaderDistrict))

        self.leaderView.addArrangedSubview(captinViewNib)

        self.running?.members?.forEach({ (member) in
            guard
                let memberName = member?.name,
                let memberNickname = member?.nickname,
                let memberDistrict = member?.district else {
                    return
            }

            let memberViewNib = UserView.instanceFromNib()
            memberViewNib.configure(user: User(name: memberName, nickname: memberNickname, district: memberDistrict))

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
    
    @IBAction func requestButtonPressed(_ sender: UIButton) {
        
        let alertController = self.createBasicAlertViewController(title: "참가신청", message: "리더에게 참가 신청을 보냈습니다")  {
            self.dismiss(animated: true, completion: nil)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}

extension RunningViewController: CustomNavigationBarDelegate {
    
    func leftBarButtonPressed(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

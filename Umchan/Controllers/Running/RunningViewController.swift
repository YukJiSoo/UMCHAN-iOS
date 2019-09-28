//
//  RunningViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/25/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var oneLineLabel: UILabel!
    @IBOutlet weak var registerDateLabel: UILabel!
    @IBOutlet weak var runningDateLabel: UILabel!
    @IBOutlet weak var leaderView: UIStackView!
    @IBOutlet weak var membersView: UIStackView!
    
    // MARK: - Properties
    var id: String?
    var running: RunningQueryType?
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
        self.setupNavigationBar()
        self.setupParticipatingLeaderAndMembers()
    }
    
    // MARK: - Functions
    func setupData() {

        guard let id = self.id else {
            return
        }
        RunningService.shared.running(id: id) { (response) in

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

    }
    
    func setupNavigationBar() {
        
        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
    }
    
    func setupParticipatingLeaderAndMembers() {
        
        let captinViewNib = UserView.instanceFromNib()
        let firstMemberViewNib = UserView.instanceFromNib()
        let secondMemberViewNib = UserView.instanceFromNib()
        
        self.leaderView.addArrangedSubview(captinViewNib)
        self.membersView.addArrangedSubview(firstMemberViewNib)
        self.membersView.addArrangedSubview(secondMemberViewNib)
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

//
//  RunningInDistrictViewController.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningInDistrictViewController: ModalViewController {
    
    // MARK: - SubViews
    var tableView = UITableView()
    
    // MARK: - Properties
    var district: String?

    var runnings: [RunningListQueryType]? {
        didSet {
            DispatchQueue.main.async {
                if self.runnings?.isEmpty ?? true {
                    self.setupEmptyCase()
                } else {
                    self.setupTableView()
                    self.setupXib()
                }
            }
        }
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupData()
    }

    // MARK: - Functions
    func runningsCompletion(_ response: Result<[RunningListQueryType], RunningAPIError>) {

        switch response {
        case .success(_):

            guard let data = try? response.get() else {
                debugPrint("cannot get data")
                return
            }

            self.runnings = data 
        case .failure(RunningAPIError.runningList(let message)):

            print(message)
        default:
            debugPrint("Uncorrect access")
        }
    }

    func setupData() {
        RunningService.shared.runningList(name: district, completion: self.runningsCompletion(_:))
    }

    func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tableView)
        
        let topAnchor = self.tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])
    }
    
    func setupXib() {
        
        let runningCellNib = UINib(nibName: RunningTableViewCell.nibId, bundle: nil)
        let emptyNoticeCellNib = UINib(nibName: EmptyTableViewCell.nibId, bundle: nil)
        
        self.tableView.register(runningCellNib, forCellReuseIdentifier: RunningTableViewCell.nibId)
        self.tableView.register(emptyNoticeCellNib, forCellReuseIdentifier: EmptyTableViewCell.nibId)
        
    }

    func setupEmptyCase() {

        // add views
        let emptyImageView = UIImageView(frame: .zero)

        emptyImageView.image = UIImage(named: AssetName.empty)
        emptyImageView.contentMode = .scaleAspectFit

        self.view.addSubview(emptyImageView)

        let emptyLabel = UILabel(frame: .zero)

        emptyLabel.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        emptyLabel.text = "참가 가능한 러닝이 없습니다"
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
    
}

extension RunningInDistrictViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let count = self.runnings?.count {
            return count == 0 ? 1 : count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if self.runnings?.count == 0 {
            guard let emptyNoticeCell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.nibId, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }

            emptyNoticeCell.configure(stateText: Statement.hsaNoRunning, state: .running)
            return emptyNoticeCell
        }

        guard let runningCell = tableView.dequeueReusableCell(withIdentifier: RunningTableViewCell.nibId, for: indexPath) as? RunningTableViewCell else {
            return UITableViewCell()
        }

        if let running = self.runnings?[indexPath.row] {
            runningCell.configure(running: running)
        }

        return runningCell
    }

}

extension RunningInDistrictViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: StoryboardName.running, bundle: nil)
        let viewController = storyboard.viewController(RunningViewController.self)

        if let runnings = self.runnings, let district = self.district {
            viewController.id = runnings[indexPath.row].id
            viewController.district = district
        }

        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

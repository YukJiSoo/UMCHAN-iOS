//
//  MyRunningsViewController.swift
//  Umchan
//
//  Created by 육지수 on 9/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class MyRunningsViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!

    // MARK: - SubViews
    var tableView: UITableView?

    // MARK: - Properties
    var runnings = [Running]()

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup()
    }

    // MARK: - Functions
    func setup() {

        self.setupData()

        guard !runnings.isEmpty else {
            self.setupEmptyCase()
            return
        }

        self.setupNavigationBar()
        self.setupTableView()
    }

    func setupData() {
        
    }
    
    func setupNavigationBar() {

        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .close)
    }

    func setupEmptyCase() {

        // add views
        let emptyImageView = UIImageView(frame: .zero)

        emptyImageView.image = UIImage(named: AssetName.empty)
        emptyImageView.contentMode = .scaleAspectFit

        self.view.addSubview(emptyImageView)

        let emptyLabel = UILabel(frame: .zero)

        emptyLabel.font = UIFont.umchanFont(size: CGFloat(20), boldState: .extrabold)
        emptyLabel.text = "참가 예정인 러닝이 없습니다"
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

    func setupTableView() {

        let tableView = UITableView(frame: .zero)
        tableView.separatorStyle = .none

        self.view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        let topAnchor = tableView.topAnchor.constraint(equalTo: self.navigationBar.bottomAnchor)
        let bottomAnchor = tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leadingAnchor = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingAnchor = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)

        NSLayoutConstraint.activate([ topAnchor, bottomAnchor, leadingAnchor, trailingAnchor ])

        self.tableView = tableView

        let runningHistoryCellNib = UINib(nibName: RunningHistoryListTableViewCell.nibId, bundle: nil)
        self.tableView?.register(runningHistoryCellNib, forCellReuseIdentifier: RunningHistoryListTableViewCell.nibId)

        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }

}

extension MyRunningsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.runnings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: RunningHistoryListTableViewCell.nibId, for: indexPath) as? RunningHistoryListTableViewCell else {
            debugPrint("err: fail to convert \(RunningHistoryListTableViewCell.nibId)")
            return UITableViewCell()
        }

        cell.configure(running: runnings[indexPath.row])

        return cell
    }


}

extension MyRunningsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: StoryboardName.runningHistory, bundle: nil)
        let viewController = storyboard.viewController(RunningHistoryViewController.self)
        viewController.running = self.runnings[indexPath.row]

        self.present(viewController, animated: true, completion: nil)
    }
}

extension MyRunningsViewController: CustomNavigationBarDelegate {

    func leftBarButtonPressed(_ sender: UIButton) {

        self.dismiss(animated: true, completion: nil)
    }
}

//
//  ManageRunningMemberViewController.swift
//  Umchan
//
//  Created by 육지수 on 9/29/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class ManageRunningMemberViewController: UIViewController, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var navigationBar: CustomNavigationBar!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var id: String?
    var district: String?
    var awaitMembers: [RunningQueryType.AwaitMember]?
    var members: [RunningQueryType.Member]?

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.setupTableView()
    }

    // MARK: - Functions
    func setupNavigationBar() {

        self.navigationBar.delegate = self
        self.navigationBar.configureButton(location: .left, type: .back)
    }

    func setupTableView() {
        self.tableView.dataSource = self
    }
}

extension ManageRunningMemberViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.awaitMembers?.count ?? 0
        } else {
            return self.members?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ManageMemberTableViewCell.nibId, for: indexPath) as? ManageMemberTableViewCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0, let nickname = self.awaitMembers?[indexPath.row].nickname {
            cell.configure(nickname: nickname, index: indexPath.row, type: .waiter)
        } else if let nickname = self.members?[indexPath.row].nickname {
            cell.configure(nickname: nickname, index: indexPath.row, type: .member)
        }

        cell.delegate = self

        return cell
    }

}

extension ManageRunningMemberViewController: CustomNavigationBarDelegate {

    func leftBarButtonPressed(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
    }
}

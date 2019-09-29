//
//  WaitingPersonTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 9/29/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

enum MemberType {
    case waiter
    case member
}

class ManageMemberTableViewCell: UITableViewCell, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var memberNicknameLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    // MARK: - Properties
    var type: MemberType = .waiter {
        didSet {
            switch self.type {
            case .waiter:
                self.acceptButton.setTitle("수락", for: .normal)
                self.rejectButton.setTitle("거절", for: .normal)
            case .member:
                self.acceptButton.setTitle("참가확인", for: .normal)
                self.rejectButton.setTitle("제외", for: .normal)
            }
        }
    }

    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Funtions
    func configure(nickname: String, type: MemberType) {
        self.memberNicknameLabel.text = nickname
        self.type = type
    }

    @IBAction func userDetailButtonPressed(_ sender: UIButton) {

    }

    @IBAction func acceptButtonPressed(_ sender: UIButton) {

    }

    @IBAction func rejectButtonPressed(_ sender: UIButton) {

    }

}

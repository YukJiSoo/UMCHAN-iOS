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
    var index: Int?
    var delegate: ManageMemberDelegate?

    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Funtions
    func configure(nickname: String, index: Int, type: MemberType) {
        self.memberNicknameLabel.text = nickname
        self.type = type
        self.index = index
    }

    @IBAction func userDetailButtonPressed(_ sender: UIButton) {
        if let index = self.index {
            self.delegate?.userDetailButtonPressed(type: self.type, index: index)
        }
    }

    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        if let index = self.index {
            self.delegate?.acceptButtonPressed(type: self.type, index: index)
        }
    }

    @IBAction func rejectButtonPressed(_ sender: UIButton) {
        if let index = self.index {
            self.delegate?.rejectButtonPressed(type: self.type, index: index)
        }
    }

}

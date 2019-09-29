//
//  WaitingPersonTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 9/29/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class WaitingPersonTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var waiterNameLabel: UILabel!

    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Funtions
    func configure(name: String) {
        self.waiterNameLabel.text = name
    }

    @IBAction func userDetailButtonPressed(_ sender: UIButton) {

    }

    @IBAction func acceptButtonPressed(_ sender: UIButton) {

    }

    @IBAction func rejectButtonPressed(_ sender: UIButton) {

    }

}

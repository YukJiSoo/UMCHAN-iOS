//
//  CrewTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 9/30/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class CrewTableViewCell: UITableViewCell, NibLodable {

    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(crew: CrewListQueryResult) {
        self.nameLabel.text = crew.name
    }

}

//
//  RunningTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 8/22/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningTableViewCell: UITableViewCell, NibLodable {

    // MARK: - Outlets
    @IBOutlet weak var runningNameLabel: UILabel!
    @IBOutlet weak var registerDateLabel: UILabel!
    @IBOutlet weak var runningDateLabel: UILabel!
    @IBOutlet weak var runningOneLineLabel: UILabel!
    
    // MARK: - Properties
    
    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Properties
    func configure() {
        
    }
}

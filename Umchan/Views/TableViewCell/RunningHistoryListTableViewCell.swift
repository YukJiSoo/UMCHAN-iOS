//
//  RunningHistoryTableViewCell.swift
//  Umchan
//
//  Created by 육지수 on 8/24/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

class RunningHistoryListTableViewCell: UITableViewCell, NibLodable {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var dateFormatter: DateFormatter {
        
        return DateFormatter.basicFormatter(format: DateFormat.dotDate, locale: DateFormat.locale)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(running: Running) {
        
        self.selectionStyle = .none
        
        self.dateLabel.text = "\(dateFormatter.string(from: running.runningDate))"
        self.nameLabel.text = "\(running.name)"
    }
    
}

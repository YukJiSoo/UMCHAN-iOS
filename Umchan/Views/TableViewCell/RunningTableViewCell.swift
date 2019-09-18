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
    private var dateFormatter: DateFormatter {
        
        return DateFormatter.basicFormatter(format: DateFormat.dateAndTime, locale: DateFormat.locale)
    }
    
    
    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Properties
    func configure(running: RunningListQueryType) {
        
        self.runningNameLabel.text = running.name
        self.runningOneLineLabel.text = running.oneLine

        let (runningDate, registerDate) = convertRunningDateString(running: running)
        self.runningDateLabel.text = "\(runningDate)에 달리기 시작"
        self.registerDateLabel.text = "\(registerDate)까지 등록"
    }
}

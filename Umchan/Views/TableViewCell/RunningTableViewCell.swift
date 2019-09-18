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
    func configure(running: RunningType) {
        
        self.runningNameLabel.text = running.name
        self.runningOneLineLabel.text = running.oneLine

        let runningDate = running.runningDate
        if
            let year = runningDate?.year,
            let month = runningDate?.month,
            let date = runningDate?.date,
            let hour = runningDate?.hour,
            let minute = runningDate?.minute {

            self.runningDateLabel.text = "\(year)년 \(month)월 \(date)일 \(hour)시 \(minute)분에 달리기 시작"
        }

        if
            let year = runningDate?.year,
            let month = runningDate?.month,
            let date = runningDate?.date,
            let hour = runningDate?.hour,
            let minute = runningDate?.minute {

            self.registerDateLabel.text = "\(year)년 \(month)월 \(date)일 \(hour)시 \(minute)분까지 등록"
        }
        
    }

    func convertDataString() {

    }
}

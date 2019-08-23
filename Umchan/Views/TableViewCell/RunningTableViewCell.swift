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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일 h시 m분"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter
    }
    
    
    // MARK: - Life cycles
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Properties
    func configure(running: Running) {
        
        self.runningNameLabel.text = running.name
        self.runningOneLineLabel.text = running.oneLine
        
        self.runningDateLabel.text = "\(dateFormatter.string(from: running.runningDate))에 달리기 시작"
        self.registerDateLabel.text = "\(dateFormatter.string(from: running.registerDate))까지 등록"
        
    }
}

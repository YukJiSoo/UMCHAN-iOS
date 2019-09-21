//
//  DateView.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit
import Foundation

class DateView: UIStackView {
    
    // MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var dateLabelPlaceholder: String?
    var pickedDate: String? {
        
        didSet {
            self.dateLabel.text = self.pickedDate
        }
    }

    var date: Date?
    var time: Date?
    
    var delegate: DateViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.setupGesture()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.isUserInteractionEnabled = true
        self.setupGesture()
    }
    
    func setupGesture() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateViewPressed(_:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func dateViewPressed(_ gesture: UIGestureRecognizer) {

        self.delegate?.presentDatePickerViewController(self)
    }

    func getDateAndTimeComponents() -> (Year, Month, Day, Hour, Minute)? {

        guard let date = self.date, let time = self.time else {
            debugPrint("date and time is nil")
            return nil
        }

        return Date.convertToUCDateType(date: date, time: time)
    }
}

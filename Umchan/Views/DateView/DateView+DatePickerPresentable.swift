//
//  DateView+DatePickerPresentable.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension DateView: DatePickerPresentable {
    
    func datePicked(date: String, time: String) {
        
        self.dateLabel.text = "\(date) \(time)"
    }
    
}
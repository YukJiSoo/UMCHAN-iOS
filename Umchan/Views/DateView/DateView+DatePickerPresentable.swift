//
//  DateView+DatePickerPresentable.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension DateView: DatePickerPresentable {

    var dateFormatter: DateFormatter {
        return DateFormatter.basicFormatter(format: DateFormat.date, locale: DateFormat.locale)
    }

    var timeFormatter: DateFormatter {
        return DateFormatter.basicFormatter(format: DateFormat.time, locale: DateFormat.locale)
    }
    
    func datePicked(date: Date, time: Date) {
        
        let dateString = self.dateFormatter.string(from: date)
        let timeString = self.timeFormatter.string(from: time)

        self.dateLabel.text = "\(dateString) \(timeString)"
    }
    
}

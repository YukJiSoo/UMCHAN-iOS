//
//  Date+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

typealias Year = Int
typealias Month = Int
typealias Day = Int
typealias Hour = Int
typealias Minute = Int
typealias UCDateType = (Year, Month, Day, Hour, Minute)

extension Date {
    static func convertToUCDateType(date: Date, time: Date? = nil) -> UCDateType {
        let calendar = Calendar.current

        return (
            calendar.component(.year, from: date),
            calendar.component(.month, from: date),
            calendar.component(.day, from: date),
            calendar.component(.hour, from: time ?? date),
            calendar.component(.minute, from: time ?? date)
        )
    }

    static func convertToDateInput(date: Date, time: Date? = nil) -> DateInput {
        let calendar = Calendar.current

        return DateInput(
            year: calendar.component(.year, from: date),
            month: calendar.component(.month, from: date),
            date: calendar.component(.day, from: date),
            hour: calendar.component(.hour, from: time ?? date),
            minute: calendar.component(.minute, from: time ?? date)
        )
    }
}

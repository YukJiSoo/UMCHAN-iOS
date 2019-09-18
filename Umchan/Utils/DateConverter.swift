//
//  DateConverter.swift
//  Umchan
//
//  Created by 육지수 on 9/19/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

func convertRunningDateString(running: RunningType) -> (String, String){
    var runningDateString: String = ""
    var registerDateString: String = ""

    let runningDate = running.runningDate
    if
        let year = runningDate?.year,
        let month = runningDate?.month,
        let date = runningDate?.date,
        let hour = runningDate?.hour,
        let minute = runningDate?.minute {

        runningDateString = "\(year)년 \(month)월 \(date)일 \(hour)시 \(minute)분"
    }

    let registerDate = running.registerLimitDate
    if
        let year = registerDate?.year,
        let month = registerDate?.month,
        let date = registerDate?.date,
        let hour = registerDate?.hour,
        let minute = registerDate?.minute {

        registerDateString = "\(year)년 \(month)월 \(date)일 \(hour)시 \(minute)분"
    }

    return (runningDateString, registerDateString)
}

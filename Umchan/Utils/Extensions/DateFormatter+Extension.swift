//
//  DateFormatter+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func basicFormatter(format: String, locale: String) -> DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: locale)
        
        return dateFormatter
    }
}

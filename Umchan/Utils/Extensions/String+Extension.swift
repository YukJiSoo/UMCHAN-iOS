//
//  String+Extension.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension String {
    
    var isSuccessfulResponse: Bool {
        return self.hasPrefix("2")
    }
}

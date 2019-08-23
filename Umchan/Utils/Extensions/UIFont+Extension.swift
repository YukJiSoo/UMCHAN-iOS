//
//  UIFont+Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/23/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import UIKit

extension UIFont {
    
    static let umchanFontName = "NanumSquareOTF_ac"
    
    enum BoldState: String {
        case light = ""
        case regular = "R"
        case bold = "B"
        case extrabold = "EB"
    }
    
    class func umchanFont(size: CGFloat, boldState: BoldState) -> UIFont? {
        
        return UIFont(name: "\(self.umchanFontName)\(boldState.rawValue)", size: size)
    }
}

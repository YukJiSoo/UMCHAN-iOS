//
//  NibLodable.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

protocol NibLodable: class {
    static var nibId: String { get }
    
}

extension NibLodable {
    
    static var nibId: String {
        return String(describing: self)
    }
    
    var nibId: String {
        return String(describing: type(of: self))
    }
    
}

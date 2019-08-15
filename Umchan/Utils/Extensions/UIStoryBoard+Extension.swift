//
//  Extension.swift
//  Umchan
//
//  Created by 육지수 on 8/15/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    func viewController<T>(_ type: T.Type) -> T where T : NibLodable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.nibId) as? T else {
            fatalError("Could not find viewController \(T.nibId)")
        }
        
        return viewController
    }
    
}

//
//  MapViewDelegate.swift
//  Umchan
//
//  Created by 육지수 on 8/31/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import MapKit

protocol MapViewDelegate: class {
    
    func annotationButtonDelegate(isCheckMode: Bool)
    func answerAnnotationRemoveDelegate(didSelect view: MKAnnotationView)
}

//
//  Constants.swift
//  Umchan
//
//  Created by 육지수 on 8/13/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Colors
class Color {
    
    private init() {
    }
    
    static let symbol = #colorLiteral(red: 0.5968999267, green: 0.1244353876, blue: 0.1686562896, alpha: 1)
    static let symbolTransparent = #colorLiteral(red: 0.5968999267, green: 0.1244353876, blue: 0.1686562896, alpha: 0.6979612586)
}

// MARK: - Seoul map info
let ORIGINAL_MAP_WIDTH: CGFloat = 335
let ORIGINAL_MAP_HEIGHT: CGFloat = 240

// MARK: - Assets
let DISTRICTS = "districts"

// MARK: - Constraints
var navigationBarHeight: CGFloat = 64

// MARK: - print Statement
class Statement {
    
    private init() {
    }
    
    static let hsaNoRunning = "참가 가능한 러닝이 없습니다"
}

// MARK: - story board name
class StoryboardName {
    
    private init() {
    }
    
    static let main = "Main"
    static let registerRunning = "RegisterRunning"
    static let createCrew = "CreateCrew"
    static let crewInfo = "CrewInfo"
}

// MARK: - date format
class DateFormat {
    
    private init() {
    }
    
    static let locale = "ko_KR"
    
    static let time = "h시 m분"
    static let date = "yyyy년 M월 d일"
    static let dotDate = "yy.MM.dd"
    static let dateAndTime = "\(date) \(time)"
}

// MARK: - image asset name
class AssetName {
    
    private init() {
    }
    
    static let empty = "empty"
    static let shoes = "shoes"
    static let back = "back"
    static let search = "search"
}

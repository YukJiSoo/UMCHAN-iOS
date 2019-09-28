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
    
    static let symbol = #colorLiteral(red: 0.5960784314, green: 0.1254901961, blue: 0.168627451, alpha: 1)
    static let symbolTransparent = #colorLiteral(red: 0.5968999267, green: 0.1244353876, blue: 0.1686562896, alpha: 0.6979612586)
}

// MARK: - Seoul map info
let ORIGINAL_MAP_WIDTH: CGFloat = 335
let ORIGINAL_MAP_HEIGHT: CGFloat = 240

// MARK: - Assets
let DISTRICTS = "districts"

// MARK: - Constraints
var navigationBarHeight: CGFloat = 64

// MARK: - segue
class Segue {
    
    static let segueToModifyProfile = "segueToModifyProfile"
    
    // unwind
    static let unwindToLoginViewController = "unwindToLoginViewController"
    static let unwindToMainViewController = "unwindToMainViewController"
    static let unwindToRegisterRunningViewController = "unwindToRegisterRunningViewController"
    
}

// MARK: - print Statement
class Statement {
    
    static let hsaNoRunning = "참가 가능한 러닝이 없습니다"
}

// MARK: - story board name
class StoryboardName {
    
    static let main = "Main"
    static let registerRunning = "RegisterRunning"
    static let createCrew = "CreateCrew"
    static let crewInfo = "CrewInfo"
    static let running = "Running"
    static let runningHistory = "RunningHistory"
    static let profile = "Profile"
    static let loginAndSignUp = "LoginAndSignup"
    static let map = "Map"
}

// MARK: - date format
class DateFormat {
    
    static let locale = "ko_KR"
    static let time = "h시 m분"
    static let date = "yyyy년 M월 d일"
    static let dotDate = "yy.MM.dd"
    static let dateAndTime = "\(date) \(time)"
}

// MARK: - image asset name
class AssetName {
    
    // tabBarItem image
    static let main = "main"
    static let crew = "crew"
    static let history = "history"
    
    static let user = "user"
    static let empty = "empty"
    static let shoes = "shoes"
    static let back = "back"
    static let search = "search"
    static let mainLogo = "mainLogo"
    static let annotation = "annotation"
}

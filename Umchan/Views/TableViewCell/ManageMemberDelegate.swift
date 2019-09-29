//
//  ManageMemberDelegate.swift
//  Umchan
//
//  Created by 육지수 on 9/29/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

protocol ManageMemberDelegate {
    func userDetailButtonPressed(type: MemberType, index: Int)
    func acceptButtonPressed(type: MemberType, index: Int)
    func rejectButtonPressed(type: MemberType, index: Int)
}

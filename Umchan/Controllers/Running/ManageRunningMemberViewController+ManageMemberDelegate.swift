//
//  ManageRunningMemberViewController+Manage.swift
//  Umchan
//
//  Created by 육지수 on 9/29/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension ManageRunningMemberViewController: ManageMemberDelegate {
    func userDetailButtonPressed(type: MemberType, index: Int) {
    }

    func acceptButtonPressed(type: MemberType, index: Int) {

        if
            let memberID = type == .waiter ? self.awaitMembers?[index].userId : self.members?[index].userId,
            let id = self.id,
            let district = self.district {
            RunningService.shared.acceptMember(id: id, district: district, memberID: memberID) { (response) in
                switch response {
                case .success(_):
                    if type == .waiter {
                        let member = RunningQueryType.Member(
                            userId: memberID,
                            name: self.awaitMembers?[index].name,
                            nickname: self.awaitMembers?[index].nickname,
                            district: self.district
                        )
                        self.members?.append(member)
                        self.awaitMembers?.remove(at: index)
                    } else {
                        self.members?.remove(at: index)
                    }

                    let alertController = self.createBasicAlertViewController(title: "참가수락", message: "러닝참가를 수락했습니다")  {

                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        self.tableView.reloadData()
                    }
                    self.present(alertController, animated: true, completion: nil)
                case .failure(RunningAPIError.goOutRunning(let message)):

                    self.presentFailAlertController("수락 실패", with: message)
                default:
                    debugPrint("Uncorrect access")
                }
            }
        }
    }

    func rejectButtonPressed(type: MemberType, index: Int) {
    }

}

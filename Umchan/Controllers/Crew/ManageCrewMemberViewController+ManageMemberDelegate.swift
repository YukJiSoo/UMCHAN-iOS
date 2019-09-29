//
//  ManageCrewMemberViewController+.swift
//  Umchan
//
//  Created by 육지수 on 9/30/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

extension ManageCrewMemberViewController: ManageMemberDelegate {
    func userDetailButtonPressed(type: MemberType, index: Int) {
    }

    func acceptButtonPressed(type: MemberType, index: Int) {
        guard
            let memberID = type == .waiter ? self.awaitMembers?[index].userId : self.members?[index].userId,
            let id = self.id,
            let district = self.district
            else {
                return
        }

        if type == .waiter {
            CrewService.shared.acceptMember(id: id, district: district, memberID: memberID) { (response) in
                switch response {
                case .success(_):
                    let title = "참가수락"
                    let message = "크루 참가를 수락했습니다"
                    let member = CrewQueryType.Member(
                        userId: memberID,
                        name: self.awaitMembers?[index].name,
                        nickname: self.awaitMembers?[index].nickname,
                        district: self.district
                    )
                    self.members?.append(member)
                    self.awaitMembers?.remove(at: index)

                    let alertController = self.createBasicAlertViewController(title: title, message: message)  {

                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    self.present(alertController, animated: true, completion: nil)
                case .failure(CrewAPIError.acceptCrewMember(let message)):

                    self.presentFailAlertController("수락 실패", with: message)
                default:
                    debugPrint("Uncorrect access")
                }
            }

            return
        }
    }

    func rejectButtonPressed(type: MemberType, index: Int) {
        guard
            let memberID = type == .waiter ? self.awaitMembers?[index].userId : self.members?[index].userId,
            let id = self.id,
            let district = self.district
            else {
                return
        }

        if type == .waiter {
            CrewService.shared.rejectMember(id: id, district: district, memberID: memberID) { (response) in
                switch response {
                case .success(_):
                    let title = "참가거절"
                    let message = "참가를 거절했습니다"

                    self.awaitMembers?.remove(at: index)

                    let alertController = self.createBasicAlertViewController(title: title, message: message)  {

                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    self.present(alertController, animated: true, completion: nil)
                case .failure(CrewAPIError.rejectCrewMember(let message)):

                    self.presentFailAlertController("거절 실패", with: message)
                default:
                    debugPrint("Uncorrect access")
                }
            }

            return
        }

        CrewService.shared.exceptMember(id: id, district: district, memberID: memberID) { (response) in
            switch response {
            case .success(_):
                let title: String = "크루원 탈퇴"
                let message: String = "참여자를 크루에서 탈퇴시켰습니다"

                self.members?.remove(at: index)

                let alertController = self.createBasicAlertViewController(title: title, message: message)  {

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                self.present(alertController, animated: true, completion: nil)
            case .failure(CrewAPIError.exceptCrewMember(let message)):

                self.presentFailAlertController("탈퇴 실패", with: message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

}

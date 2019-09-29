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
        guard
            let memberID = type == .waiter ? self.awaitMembers?[index].userId : self.members?[index].userId,
            let id = self.id,
            let district = self.district
            else {
                return
        }

        if type == .waiter {
            RunningService.shared.acceptMember(id: id, district: district, memberID: memberID) { (response) in
                switch response {
                case .success(_):
                    let title = "참가수락"
                    let message = "러닝 참가를 수락했습니다"
                    let member = RunningQueryType.Member(
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
                case .failure(RunningAPIError.goOutRunning(let message)):

                    self.presentFailAlertController("수락 실패", with: message)
                default:
                    debugPrint("Uncorrect access")
                }
            }

            return
        }

        RunningService.shared.acceptMember(id: id, district: district, memberID: memberID) { (response) in
            switch response {
            case .success(_):
                let title = "러닝확인"
                let message = "러닝 참여를 확인했습니다"
                self.members?.remove(at: index)

                let alertController = self.createBasicAlertViewController(title: title, message: message)  {

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                self.present(alertController, animated: true, completion: nil)
            case .failure(RunningAPIError.goOutRunning(let message)):

                self.presentFailAlertController("확인 실패", with: message)
            default:
                debugPrint("Uncorrect access")
            }
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
            RunningService.shared.rejectMember(id: id, district: district, memberID: memberID) { (response) in
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
                case .failure(RunningAPIError.goOutRunning(let message)):

                    self.presentFailAlertController("거절 실패", with: message)
                default:
                    debugPrint("Uncorrect access")
                }
            }

            return
        }

        RunningService.shared.exceptMember(id: id, district: district, memberID: memberID) { (response) in
            switch response {
            case .success(_):
                let title: String = "참가제외"
                let message: String = "참여자를 러닝에서 제외시켰습니다"

                self.members?.remove(at: index)

                let alertController = self.createBasicAlertViewController(title: title, message: message)  {

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                self.present(alertController, animated: true, completion: nil)
            case .failure(RunningAPIError.goOutRunning(let message)):

                self.presentFailAlertController("제외 실패", with: message)
            default:
                debugPrint("Uncorrect access")
            }
        }
    }

}

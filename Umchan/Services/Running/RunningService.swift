//
//  RunningAPI.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

enum MemberStateType {
    case none
    case wait
    case member
}

typealias RunningQueryType = RunningQuery.Data.Running.Running
typealias RunningListQueryType = RunningListQuery.Data.Running.Running

typealias GetRunningCompletion = (_ Response: Result<(RunningQuery.Data.Running.Running, MemberStateType), RunningAPIError>) -> Void
typealias GetRunningListCompletion = (_ Response: Result<[RunningListQueryType], RunningAPIError>) -> Void
typealias RunningCompletion = (_ Response: Result<Bool, RunningAPIError>) -> Void

protocol RunningServiceType {

    func running(id: String, district: String, completion: @escaping GetRunningCompletion)
    func runningList(name: String?, completion: @escaping GetRunningListCompletion)
    func registerRunning(name: String, oneLine: String, runningDate: UCDateType, registerLimitDate: UCDateType, runningPoint: [LocationType], district: String, completion: @escaping RunningCompletion)
    func applyRunning(id: String, district: String, completion: @escaping RunningCompletion)
    func goOutRunning(id: String, district: String, completion: @escaping RunningCompletion)
}

final class RunningService: RunningServiceType {

    static let shared = RunningService()

    func running(id: String, district: String, completion: @escaping GetRunningCompletion) {

        let runningInput = RunningInput(id: id, district: district)
        Apollo.shared.client.fetch(query: RunningQuery(input: runningInput), cachePolicy: .fetchIgnoringCacheData) { result in

            guard
                let data = try? result.get().data,
                let code = data.running?.code,
                let message = data.running?.message
                else {
                    completion(.failure(.running(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.running(message)))
                return
            }

            // response from server
            guard let running = data.running?.running else {
                completion(.failure(.running("Fail Convert json data")))
                return
            }

            var memberState: MemberStateType = .none
            if let isApplied = data.running?.isApplied {
                memberState = isApplied ? .wait : memberState
            }
            if let isMember = data.running?.isMember {
                memberState = isMember ? .member : memberState
            }

            completion(.success((running, memberState)))
        }

    }

    func runningList(name: String? = nil, completion: @escaping GetRunningListCompletion) {

        Apollo.shared.client.fetch(query: RunningListQuery(name: name), cachePolicy: .fetchIgnoringCacheData) { result in

            guard
                let data = try? result.get().data,
                let code = data.runnings?.code,
                let message = data.runnings?.message
                else {
                    completion(.failure(.runningList(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.runningList(message)))
                return
            }

            // response from server
            guard let runnings = data.runnings?.runnings else {
                completion(.failure(.runningList("Fail Convert json data")))
                return
            }

            completion(.success(runnings))
        }
    }

    func registerRunning(name: String, oneLine: String, runningDate: UCDateType, registerLimitDate: UCDateType, runningPoint: [LocationType], district: String, completion: @escaping RunningCompletion) {

        let runningDateInput = DateInput(
            year: runningDate.0,
            month: runningDate.1,
            date: runningDate.2,
            hour: runningDate.3,
            minute: runningDate.4
        )
        let registerLimitDateInput = DateInput(
            year: registerLimitDate.0,
            month: registerLimitDate.1,
            date: registerLimitDate.2,
            hour: registerLimitDate.3,
            minute: registerLimitDate.4
        )
        let locationInput = runningPoint.map { LocationInput(latitude: $0.0, longitude: $0.1) }

        guard let nickname = UserDataService.shared.user?.nickname else {
            completion(.failure(.createRunning(("Nickname is nil"))))
            return
        }

        let createRunningInput = CreateRunningInput(name: name, oneLine: oneLine, runningDate: runningDateInput, registerLimitDate: registerLimitDateInput, runningPoints: locationInput, district: district)
        let createRunningMutation = CreateRunningMutation(nickname: nickname, running: createRunningInput)
        Apollo.shared.client.perform(mutation: createRunningMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.createRunning?.code,
                let message = data.createRunning?.message
                else {
                    completion(.failure(.createRunning(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.createRunning(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }

    func applyRunning(id: String, district: String, completion: @escaping RunningCompletion) {

        guard let user = UserDataService.shared.user else {
            completion(.failure(.applyRunning(("User data is nil"))))
            return
        }

        let memberInput = MemberInput(name: user.name, nickname: user.nickname, district: user.district)
        let applyRunningInput = ApplyRunningInput(id: id, district: district, user: memberInput)
        let applyRunningMutation = ApplyRunningMutation(input: applyRunningInput)

        Apollo.shared.client.perform(mutation: applyRunningMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.applyRunning?.code,
                let message = data.applyRunning?.message
                else {
                    completion(.failure(.applyRunning(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.applyRunning(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }

    func goOutRunning(id: String, district: String, completion: @escaping RunningCompletion) {

        let goOutInput = GoOutInput(id: id, district: district)
        let goOutRunningMutation = GoOutRunningMutation(input: goOutInput)

        Apollo.shared.client.perform(mutation: goOutRunningMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.goOutRunning?.code,
                let message = data.goOutRunning?.message
                else {
                    completion(.failure(.goOutRunning(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.goOutRunning(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }

    func acceptMember(id: String, district: String, memberID: String, completion: @escaping RunningCompletion) {

        let acceptRunningMemberInput = AcceptRunningMemberInput(id: id, district: district, memberId: memberID)
        let acceptRunningMemberMutation = AcceptRunningMemeberMutation(input: acceptRunningMemberInput)

        Apollo.shared.client.perform(mutation: acceptRunningMemberMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.acceptRunningMember?.code,
                let message = data.acceptRunningMember?.message
                else {
                    completion(.failure(.acceptRunningMember(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.acceptRunningMember(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }

    func rejectMember(id: String, district: String, memberID: String, completion: @escaping RunningCompletion) {

        let rejectRunningMemberInput = RejectRunningMemberInput(id: id, district: district, memberId: memberID)
        let rejectRunningMemberMutation = RejectRunningMemeberMutation(input: rejectRunningMemberInput)

        Apollo.shared.client.perform(mutation: rejectRunningMemberMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.rejectRunningMember?.code,
                let message = data.rejectRunningMember?.message
                else {
                    completion(.failure(.rejectRunningMember(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.rejectRunningMember(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }

    func exceptMember(id: String, district: String, memberID: String, completion: @escaping RunningCompletion) {

        let exceptRunningMemberInput = ExceptRunningMemberInput(id: id, district: district, memberId: memberID)
        let exceptRunningMemberMutation = ExceptRunningMemeberMutation(input: exceptRunningMemberInput)

        Apollo.shared.client.perform(mutation: exceptRunningMemberMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.exceptRunningMember?.code,
                let message = data.exceptRunningMember?.message
                else {
                    completion(.failure(.exceptRunningMember(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.exceptRunningMember(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
    }
}

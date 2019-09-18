//
//  RunningAPI.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

typealias RunningQueryType = RunningQuery.Data.Running.Running
typealias RunningListQueryType = RunningListQuery.Data.Running.Running

typealias GetRunningCompletion = (_ Response: Result<RunningQuery.Data.Running.Running, RunningAPIError>) -> Void
typealias GetRunningListCompletion = (_ Response: Result<[RunningListQuery.Data.Running.Running], RunningAPIError>) -> Void
typealias RunningCompletion = (_ Response: Result<Bool, RunningAPIError>) -> Void

protocol RunningServiceType {

    func running(id: String, completion: @escaping GetRunningCompletion)
    func runningList(completion: @escaping GetRunningListCompletion)
    func registerRunning(name: String, oneLine: String, runningDate: RunningDateType, registerLimitDate: RunningDateType, runningPoint: [LocationType], completion: @escaping RunningCompletion)
}

final class RunningService: RunningServiceType {

    static let shared = RunningService()

    func running(id: String, completion: @escaping GetRunningCompletion) {

        Apollo.shared.client.fetch(query: RunningQuery(id: id)) { result in

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

            completion(.success(running))
        }

    }

    func runningList(completion: @escaping GetRunningListCompletion) {

        Apollo.shared.client.fetch(query: RunningListQuery()) { result in

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

    func registerRunning(name: String, oneLine: String, runningDate: RunningDateType, registerLimitDate: RunningDateType, runningPoint: [LocationType], completion: @escaping RunningCompletion) {

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

        let createRunningInput = CreateRunningInput(name: name, oneLine: oneLine, runningDate: runningDateInput, registerLimitDate: registerLimitDateInput, runningPoints: locationInput)
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

}

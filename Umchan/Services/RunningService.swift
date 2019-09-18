//
//  RunningAPI.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

typealias GetRunningCompletion = (_ Response: Result<[RunningListQuery.Data.Running.Running], RunningAPIError>) -> Void
typealias RunningCompletion = (_ Response: Result<Bool, RunningAPIError>) -> Void

protocol RunningServiceType {

    func runningList(completion: @escaping GetRunningCompletion)
    func registerRunning(name: String, oneLine: String, runningDate: RunningDateType, registerLimitDate: RunningDateType, runningPoint: [LocationType], completion: @escaping RunningCompletion)
}

final class RunningService: RunningServiceType {

    static let shared = RunningService()

    func runningList(completion: @escaping GetRunningCompletion) {

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

//            var result = [Running]()
//            for item in runnings {
//                guard let object = try? Running(item.jsonObject) else {
//                    completion(.failure(.runningList("Fail Convert swift object data")))
//                    return
//                }
//                result.append(object)
//            }
//
//            completion(.success(result))

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

        let createRunningInput = CreateRunningInput(name: name, oneLine: oneLine, runningDate: runningDateInput, registerLimitDate: registerLimitDateInput, runningPoints: locationInput)
        Apollo.shared.client.perform(mutation: CreateRunningMutation(running: createRunningInput)) { result in

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

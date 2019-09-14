//
//  RunningAPI.swift
//  Umchan
//
//  Created by 육지수 on 9/14/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//

import Foundation

typealias RunningCompletion = (_ Response: Result<Bool, RunningAPIError>) -> Void

protocol RunningServiceType {

    func registerRunning(name: String, oneLine: String, runningDate: RunningDateType, registerLimitDate: RunningDateType, runningPoint: [LocationType], completion: @escaping RunningCompletion)
}

final class RunningService: RunningServiceType {

    static let shared = RunningService()

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

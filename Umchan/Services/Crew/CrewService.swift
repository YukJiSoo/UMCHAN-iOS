//
//  CrewService.swift
//  Umchan
//
//  Created by 육지수 on 9/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//
//

import Foundation

typealias CrewCompletion = (_ Response: Result<Bool, CrewAPIError>) -> Void

protocol CrewServiceType {

    func createCrew(name: String, oneLine: String, creationDate: UCDateType, completion: @escaping CrewCompletion)
}

final class CrewService: CrewServiceType {

    static let shared = CrewService()

    func createCrew(name: String, oneLine: String, creationDate: UCDateType, completion: @escaping CrewCompletion) {

        let crewDateInput = DateInput(
            year: 0,
            month: 1,
            date: 2,
            hour: 3,
            minute: 4
        )

        guard let nickname = UserDataService.shared.user?.nickname else {
            completion(.failure(.createCrew(("Nickname is nil"))))
            return
        }

        let createCrewInput = CreateCrewInput(name: name, oneLine: oneLine, creationDate: crewDateInput)
        let createCrewMutation = CreateCrewMutation(nickname: nickname, crew: createCrewInput)
        Apollo.shared.client.perform(mutation: createCrewMutation) { result in

            guard
                let data = try? result.get().data,
                let code = data.createCrew?.code,
                let message = data.createCrew?.message
                else {
                    completion(.failure(.createCrew(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.createCrew(message)))
                return
            }

            // response from server
            completion(.success(true))
        }
        
    }
}

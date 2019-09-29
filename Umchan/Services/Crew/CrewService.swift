//
//  CrewService.swift
//  Umchan
//
//  Created by 육지수 on 9/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//
//

import Foundation

typealias CrewListQueryResult = CrewListQuery.Data.Crew.Crew

typealias GetCrewListCompletion = (_ Response: Result<[CrewListQueryResult], CrewAPIError>) -> Void
typealias CrewCompletion = (_ Response: Result<Bool, CrewAPIError>) -> Void

protocol CrewServiceType {

    func crewList(name: String?, completion: @escaping GetCrewListCompletion)
    func createCrew(name: String, oneLine: String, completion: @escaping CrewCompletion)
}

final class CrewService: CrewServiceType {

    static let shared = CrewService()

    func crewList(name: String? = nil, completion: @escaping GetCrewListCompletion) {

        Apollo.shared.client.fetch(query: CrewListQuery(name: name), cachePolicy: .fetchIgnoringCacheData) { result in

            guard
                let data = try? result.get().data,
                let code = data.crews?.code,
                let message = data.crews?.message
                else {
                    completion(.failure(.crewList(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.crewList(message)))
                return
            }

            // response from server
            guard let crews = data.crews?.crews else {
                completion(.failure(.crewList("Fail Convert json data")))
                return
            }

            completion(.success(crews))
        }
    }

    func createCrew(name: String, oneLine: String, completion: @escaping CrewCompletion) {

        let crewDateInput = Date.convertToDateInput(date: Date())

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

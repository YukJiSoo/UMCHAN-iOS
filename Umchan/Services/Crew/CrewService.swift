//
//  CrewService.swift
//  Umchan
//
//  Created by 육지수 on 9/21/19.
//  Copyright © 2019 JSYuk. All rights reserved.
//
//

import Foundation

typealias CrewQueryType = CrewQuery.Data.Crew.Crew
typealias CrewListQueryResult = CrewListQuery.Data.Crew.Crew

typealias GetCrewCompletion = (_ Response: Result<(CrewQuery.Data.Crew.Crew, MemberStateType), CrewAPIError>) -> Void
typealias GetCrewListCompletion = (_ Response: Result<[CrewListQueryResult], CrewAPIError>) -> Void
typealias CrewCompletion = (_ Response: Result<Bool, CrewAPIError>) -> Void

protocol CrewServiceType {

    func crew(id: String, district: String, completion: @escaping GetCrewCompletion)
    func crewList(name: String?, completion: @escaping GetCrewListCompletion)
    func createCrew(name: String, oneLine: String, district: String, completion: @escaping CrewCompletion)
}

final class CrewService: CrewServiceType {

    static let shared = CrewService()

    func crew(id: String, district: String, completion: @escaping GetCrewCompletion) {

        let crewInput = CrewInput(id: id, district: district)
        Apollo.shared.client.fetch(query: CrewQuery(input: crewInput), cachePolicy: .fetchIgnoringCacheData) { result in

            guard
                let data = try? result.get().data,
                let code = data.crew?.code,
                let message = data.crew?.message
                else {
                    completion(.failure(.crew(("Internal server error"))))
                    return
            }

            // check reseponse HTTP code
            guard code.isSuccessfulResponse else {
                completion(.failure(.crew(message)))
                return
            }

            // response from server
            guard let crew = data.crew?.crew else {
                completion(.failure(.crew("Fail Convert json data")))
                return
            }

            var memberState: MemberStateType = .none
            if let isApplied = data.crew?.isApplied {
                memberState = isApplied ? .wait : memberState
            }
            if let isMember = data.crew?.isMember {
                memberState = isMember ? .member : memberState
            }

            completion(.success((crew, memberState)))
        }
    }

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

    func createCrew(name: String, oneLine: String, district: String, completion: @escaping CrewCompletion) {

        guard let nickname = UserDataService.shared.user?.nickname else {
            completion(.failure(.createCrew(("Nickname is nil"))))
            return
        }

        let crewDateInput = Date.convertToDateInput(date: Date())
        let createCrewInput = CreateCrewInput(nickname: nickname, name: name, oneLine: oneLine, district: district, creationDate: crewDateInput)
        let createCrewMutation = CreateCrewMutation(input: createCrewInput)
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

//
//  BuildingsManager.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 07.07.23.
//

import Foundation

// MARK: - BuildingsManager

class BuildingsManager {

    let mapper = BuildingsMapper()

    func getBuildings() async throws -> [Building] {

        let result = await MIAClient.fetch(API.request(for: API.buildings))
        
        switch result {
        case .success(let data):
            do {
                let jsonData = try JSONDecoder().decode(APIBuildings.self, from: data.data)
                return mapper.map(jsonData)
            } catch {
                throw ManagerError.unknownError
            }

        case .failure(let error):
            throw ManagerError(clientError: error)
        }
    }
    
    func getBuildingDetail(for id: Int) async throws -> BuildingDetail {
        
        let result = await MIAClient.fetch(API.request(for: API.building(for: id)))
        
        switch result {
        case .success(let data):
            do {
                let jsonData = try JSONDecoder().decode(APIBuildingDetail.self, from: data.data)
//                let mappedData = mapper.map(jsonData)
//                return mappedData
                return mapper.map(jsonData)
            } catch {
                throw ManagerError.unknownError
            }

        case .failure(let error):
            throw ManagerError(clientError: error)
        }
    }
}

// MARK: - ManagerError

enum ManagerError: Error {

    case networkError
    case unknownError
    case notImplementedError

    init(clientError: ClientError) {
        switch clientError {

        case .HTTPClientError(_),
             .HTTPServerError:
            self = .networkError
        case .DecodingError(_),
             .InternalError:
            self = .unknownError
        }
    }
}

//
//  ArchitectsManager.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 16.07.23.
//

import Foundation
import MIACore

public class ArchitectsManager {
    
    let mapper = ArchitectsMapper()
    
    public init() {}
    
    public func getArchitects() async throws(ManagerError) -> [Architect] {
        
        let result = await MIAClient.fetch(.architects)
        
        switch result {
        case let .success(data):
            do {
                
                let jsonData = try JSONDecoder().decode(APIArchitects.self, from: data.data)
                return mapper.map(jsonData)
            } catch {
                throw ManagerError.unknownError
            }
            
        case .failure(let error):
            throw ManagerError(clientError: error)
        }
    }
    
    public func getArchitectDetail(for id: Int) async throws -> ArchitectDetail {
        
        let result = await MIAClient.fetch(.architect(id: id))
        
        switch result {
        case .success(let data):
            do {
                
                let jsonData = try JSONDecoder().decode(APIArchitectDetail.self, from: data.data)
                return mapper.map(jsonData)
            } catch {
                throw ManagerError.unknownError
            }

        case .failure(let error):
            throw ManagerError(clientError: error)
        }
    }
    
}

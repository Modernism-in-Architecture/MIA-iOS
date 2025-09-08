//
//  APIArchitectDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

// MARK: - APIWelcome

public struct APIArchitectDetail: Decodable {
    
    let data: APIArchitect
}

// MARK: - APIArchitect

extension APIArchitectDetail {
    
    struct APIArchitect: Decodable {
        
        let id: Int
        let lastName: String
        let firstName: String
        let birthDay: String?
        let birthPlace: String
        let birthCountry: String
        let deathDay: String?
        let deathPlace: String
        let deathCountry: String
        let description: String
        let descriptionMarkdown: String
        let relatedBuildings: [APIRelatedBuilding]
        let absoluteURL: String
    }
}
    
// MARK: - APIRelatedBuilding

extension APIArchitectDetail {
    
    struct APIRelatedBuilding: Decodable {
        
        let id: Int
        let name: String
        let yearOfConstruction: String
        let city: String
        let country: String
        let latitude: Double
        let longitude: Double
        let feedImage: String
    }
}

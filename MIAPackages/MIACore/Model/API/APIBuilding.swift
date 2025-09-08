//
//  APIBuilding.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 08.07.23.
//

import Foundation

public struct APIBuildings: Decodable {
    
    var data: [APIBuilding]
}

extension APIBuildings {
    
    public struct APIBuilding: Decodable, Identifiable, Hashable {
        
        public let id: Int
        let name: String
        let yearOfConstruction: String
        let city: String
        let country: String
        let latitude: Double
        let longitude: Double
        let feedImage: URL
        let previewImage: URL
    }
}

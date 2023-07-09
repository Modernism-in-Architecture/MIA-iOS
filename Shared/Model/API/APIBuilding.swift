//
//  APIBuilding.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 08.07.23.
//

import Foundation

struct APIBuildings: Decodable {
    var data: [APIBuilding]
}

struct APIBuilding: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let yearOfConstruction: String
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let feedImage: URL
}

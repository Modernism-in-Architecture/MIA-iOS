//
//  APIBuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 09.07.23.
//

import Foundation

// MARK: - APIBuildingDetail

struct APIBuildingDetail: Decodable {
    let data: APIData
}

// MARK: - APIData

struct APIData: Decodable {
    let id: Int
    let name: String
    let yearOfConstruction: String
    let isProtected: Bool
    let address: String
    let zipCode: String
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let galleryImages: [String]
    let subtitle: String
    let todaysUse: String
    let buildingType: String
    let history: String
    let description: String
    let directions: String
    let sourceUrls: [APISourceURL]
    let architects: [APIArchitect]
    let developers: [APIArchitect]
    let absoluteURL: String
}

// MARK: - APIArchitect

struct APIArchitect: Decodable {
    let id: Int
    let lastName: String
    let firstName: String
}

// MARK: - APISourceURL

struct APISourceURL: Decodable {
    let id: Int
    let title: String
    let url: String
}

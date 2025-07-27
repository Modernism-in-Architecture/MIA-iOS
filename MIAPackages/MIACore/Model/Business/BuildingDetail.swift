//
//  BuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 09.07.23.
//

import MapKit

public struct BuildingDetail: Sendable {
    
    public init(
        id: Int,
        name: String,
        yearOfConstruction: String,
        address: String,
        zipCode: String,
        city: String,
        country: String,
        cityCountry: String,
        latitude: Double,
        longitude: Double,
        feedImageURL: URL?,
        galleryImages: [IdentifiableURL],
        subtitle: String,
        todaysUse: String,
        description: String,
        history: String,
        architects: [Architect],
        absoluteURL: URL,
        buildingType: String,
        attributedDescription: AttributedString,
        attributedHistory: AttributedString
    ) {
        
        self.id = id
        self.name = name
        self.yearOfConstruction = yearOfConstruction
        self.address = address
        self.zipCode = zipCode
        self.city = city
        self.country = country
        self.cityCountry = cityCountry
        self.latitude = latitude
        self.longitude = longitude
        self.feedImageURL = feedImageURL
        self.galleryImages = galleryImages
        self.subtitle = subtitle
        self.todaysUse = todaysUse
        self.description = description
        self.history = history
        self.architects = architects
        self.absoluteURL = absoluteURL
        self.buildingType = buildingType
        self.attributedDescription = attributedDescription
        self.attributedHistory = attributedHistory
    }
    
    public let id: Int
    public let name: String
    public let yearOfConstruction: String
    public let address: String
    public let zipCode: String
    public let city: String
    public let country: String
    public let cityCountry: String
    public let latitude: Double
    public let longitude: Double
    public let feedImageURL: URL?
    public let galleryImages: [IdentifiableURL]
    public let subtitle: String
    public let todaysUse: String
    public let description: String
    public let history: String
    public let architects: [Architect]
    public let absoluteURL: URL
    public let buildingType: String
    
    public let attributedDescription: AttributedString
    public let attributedHistory: AttributedString
}

extension BuildingDetail: MapItemProtocol {
    
    public var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

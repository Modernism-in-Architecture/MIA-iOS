//
//  BuildingsMapper.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 08.07.23.
//

import MapKit

// MARK: - BuildingsMapper

public final class BuildingsMapper {
    
    public init() {}
    
    public func map(_ model: APIBuildings) -> [Building] {
        model.data.map(map)
    }

    public func map(_ model: APIBuildings.APIBuilding) -> Building {
        
        Building(
            id: model.id,
            name: model.name,
            yearOfConstruction: model.yearOfConstruction,
            city: model.city,
            country: model.country,
            feedImage: model.feedImage,
            previewImage: model.previewImage,
            coordinate: CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        )
    }
}

// MARK: - BuildingDetail

extension BuildingsMapper {

    public func map(_ model: APIBuildingDetail) -> BuildingDetail {
        
        let data = model.data
        
        return BuildingDetail(
            id: data.id,
            name: data.name,
            yearOfConstruction: data.yearOfConstruction,
            address: data.address,
            zipCode: data.zipCode,
            city: data.city,
            country: data.country,
            cityCountry: [data.city, data.country].filter{ !$0.isEmpty }.joined(separator: ", "),
            latitude: data.latitude,
            longitude: data.longitude, 
            feedImageURL: URL(string: data.feedImage),
            galleryImages: data.galleryImages.compactMap { (URL(string: $0)).map(IdentifiableURL.init(url:)) },
            subtitle: data.subtitle,
            todaysUse: data.todaysUse,
            description: data.description,
            history: data.history,
            architects: data.architects.map(map),
            absoluteURL: URL(string: data.absoluteURL)!,
            buildingType: data.buildingType,
            attributedDescription: data.descriptionMarkdown.fromMarkdownToAttributedString,
            attributedHistory: data.historyMarkdown.fromMarkdownToAttributedString
        )
    }
    
    public func map(_ model: APIBuildingDetail.APIArchitect) -> Architect {
        
        return Architect (
            id: model.id,
            lastName: model.lastName,
            firstName: model.firstName,
            fullName: [model.lastName, model.firstName].filter{ !$0.isEmpty }.joined(separator: ", ")
        )
    }
}

//
//  BuildingsMapper.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 08.07.23.
//

import MapKit

// MARK: - BuildingsMapper

class BuildingsMapper {
    
    func map(_ model: APIBuildings) -> [Building] {
        model.data.map(map)
    }

    func map(_ model: APIBuildings.APIBuilding) -> Building {
        
        Building(
            id: model.id,
            name: model.name,
            yearOfConstruction: model.yearOfConstruction,
            city: model.city,
            country: model.country,
            latitude: model.latitude,
            longitude: model.longitude,
            feedImage: model.feedImage,
            previewImage: model.previewImage,
            coordinate: CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
        )
    }
}

// MARK: - BuildingDetail

extension BuildingsMapper {

    func map(_ model: APIBuildingDetail) -> BuildingDetail {
        
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
            galleryImages: data.galleryImages.compactMap(URL.init(string:)),
            subtitle: data.subtitle,
            todaysUse: data.todaysUse,
            description: data.description,
            history: data.history,
            architects: data.architects.map(map),
            absoluteURL: URL(string: data.absoluteURL)!,
            buildingType: data.buildingType,
            attributedDescription: data.description.fromHtmlToAttributed(),
            attributedHistory: data.history.fromHtmlToAttributed()
        )
    }
    
    func map(_ model: APIBuildingDetail.APIArchitect) -> BuildingDetail.Architect {
        
        return BuildingDetail.Architect (
            id: model.id,
            lastName: model.lastName,
            firstName: model.firstName,
            fullName: [model.firstName, model.lastName].filter{ !$0.isEmpty }.joined(separator: ", ")
        )
    }
    
}

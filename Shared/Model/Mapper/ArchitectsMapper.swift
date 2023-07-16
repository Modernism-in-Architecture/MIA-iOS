//
//  ArchitectsMapper.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation
import MapKit

class ArchitectsMapper {
    
    let buildingsMapper = BuildingsMapper()
    
    func map(_ model: APIArchitects) -> [Architect] {
        model.data.map(map)
    }
    
    func map(_ model: APIArchitects.APIArchitect) -> Architect {
        
        Architect(
            id: model.id,
            lastName: model.lastName,
            firstName: model.firstName,
            fullName: [model.lastName, model.firstName].filter{ !$0.isEmpty }.joined(separator: ", ")
        )
    }
}

// MARK: - ArchitectDetail

extension ArchitectsMapper {
    
    func map(_ model: APIArchitectDetail) -> ArchitectDetail {
        
        let data = model.data
        
        return ArchitectDetail(
            id: data.id,
            lastName: data.lastName,
            firstName: data.firstName,
            fullName: [data.lastName, data.firstName].filter{ !$0.isEmpty }.joined(separator: ", "),
            birthDay: data.birthDay ?? "",
            birthPlace: data.birthPlace,
            birthCountry: data.birthCountry,
            deathDay: data.deathDay ?? "",
            deathPlace: data.deathPlace,
            deathCountry: data.deathCountry,
            description: data.description,
            relatedBuildings: data.relatedBuildings.map(map), // TODO: Fill
            attributedDescription: data.description.fromHtmlToAttributed(),
            birth: dateAndPlace(date: formatDate(data.birthDay ?? ""), place: data.birthPlace, country: data.birthCountry),
            death: dateAndPlace(date: formatDate(data.deathDay ?? ""), place: data.deathPlace, country: data.deathCountry),
            absoluteURL: URL(string: data.absoluteURL)!)
    }
}

extension ArchitectsMapper {
    
    func map(_ model: APIArchitectDetail.APIRelatedBuilding) -> Building {
        
        return Building(
            id: model.id,
            name: model.name,
            yearOfConstruction: model.yearOfConstruction,
            city: model.city,
            country: model.country,
            latitude: model.latitude,
            longitude: model.longitude,
            // TODO replace exclamation mark
            feedImage: URL(string: model.feedImage)!,
            coordinate: CLLocationCoordinate2D(latitude: model.longitude, longitude: model.latitude))
    }
}

private extension ArchitectsMapper {
    
    func dateAndPlace(date: String, place: String, country: String) -> String {
        let location = [place, country].filter{ !$0.isEmpty }.joined(separator: ", ")
        guard !(location.isEmpty && date.isEmpty) else{ return "" }
        return "\(date) \(location.isEmpty ? "" : " in \(location)")"
    }

    func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd"
        formatter.locale = Locale(identifier: "en_US")
        guard let date = formatter.date(from: dateString) else { return "" }
        return date.formatted(date: .abbreviated, time: .omitted)
    }
}

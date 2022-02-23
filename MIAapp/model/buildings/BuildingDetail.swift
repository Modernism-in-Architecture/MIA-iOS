//
//  BuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import Foundation
import UIKit

struct BuildingDetail: Decodable {
    
    let data: Detail

    struct Detail: Decodable {
        let id: Int
        let name: String
        let yearOfConstruction: String
        let address: String
        let zipCode: String
        let city: String
        let country: String
        let cityCountry: String
        let latitude: Double
        let longitude: Double
        let galleryImages: [URL]
        let subtitle: String
        let todaysUse: String
        let description: String
        let history: String
        let architects: [Architect]
        let absoluteURL: URL
        let buildingType: String
        
        let attributedDescription: AttributedString
        let attributedHistory: AttributedString
        
        struct Architect: Decodable, Identifiable {
            let id: Int
            let lastName: String
            let firstName: String
            let fullName: String
            
            enum ArchitectCodingKeys: CodingKey {
                case id, lastName, firstName
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: ArchitectCodingKeys.self)
                self.id = try container.decode(Int.self, forKey: .id)
                self.firstName = try container.decode(String.self, forKey: .firstName)
                self.lastName = try container.decode(String.self, forKey: .lastName)
                self.fullName = [firstName, lastName].filter{ !$0.isEmpty }.joined(separator: ", ")
            }
        }
        
        enum CodingKeys: CodingKey {
           case id, name, yearOfConstruction,
                address, zipCode, city, country,
                latitude, longitude, galleryImages, subtitle,
                todaysUse, description, history, architects,
                absoluteURL, buildingType
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.yearOfConstruction = try container.decode(String.self, forKey: .yearOfConstruction)
            self.address = try container.decode(String.self, forKey: .address)
            self.zipCode = try container.decode(String.self, forKey: .zipCode)
            self.city = try container.decode(String.self, forKey: .city)
            self.country = try container.decode(String.self, forKey: .country)
            self.cityCountry = [city, country].filter{ !$0.isEmpty }.joined(separator: ", ")
            self.latitude = try container.decode(Double.self, forKey: .latitude)
            self.longitude = try container.decode(Double.self, forKey: .longitude)
            self.galleryImages = try container.decode([URL].self, forKey: .galleryImages)
            self.subtitle = try container.decode(String.self, forKey: .subtitle)
            self.todaysUse = try container.decode(String.self, forKey: .todaysUse)
            self.description = try container.decode(String.self, forKey: .description)
            self.history = try container.decode(String.self, forKey: .history)
            self.architects = try container.decode([Detail.Architect].self, forKey: .architects)
            self.absoluteURL = try container.decode(URL.self, forKey: .absoluteURL)
            self.buildingType = try container.decode(String.self, forKey: .buildingType)
            
            self.attributedDescription = description.fromHtmlToAttributed()
            self.attributedHistory = history.fromHtmlToAttributed()
        }
    }
}

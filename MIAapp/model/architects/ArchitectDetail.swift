//
//  ArchitectDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation
import UIKit

struct ArchitectDetail: Decodable {
    
    let data: Details
    
    struct Details: Decodable {
        let id: Int
        let lastName: String
        let firstName: String
        let fullName: String
        let birthDay: String
        let birthPlace: String
        let birthCountry: String
        let deathDay: String
        let deathPlace: String
        let deathCountry: String
        let description: String
        let relatedBuildings: [Building]
        let attributedDescription: AttributedString
        let birth: String
        let death: String
        
        enum CodingKeys: CodingKey {
            case id, lastName, firstName,
                 birthDay, birthPlace, birthCountry,
                 deathDay, deathPlace, deathCountry,
                 description, relatedBuildings
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(Int.self, forKey: .id)
            self.firstName = try container.decode(String.self, forKey: .firstName)
            self.lastName = try container.decode(String.self, forKey: .lastName)
            self.fullName = [lastName, firstName].filter{ !$0.isEmpty }.joined(separator: ", ")
            
            if let birthDay = try container.decodeIfPresent(String.self, forKey: .birthDay) {
                self.birthDay = birthDay
            } else {
                self.birthDay = ""
            }
            
            if let deathDay = try container.decodeIfPresent(String.self, forKey: .deathDay) {
                self.deathDay = deathDay
            } else {
                self.deathDay = ""
            }

            self.birthPlace = try container.decode(String.self, forKey: .birthPlace)
            self.birthCountry = try container.decode(String.self, forKey: .birthCountry)
            self.deathPlace = try container.decode(String.self, forKey: .deathPlace)
            self.deathCountry = try container.decode(String.self, forKey: .deathCountry)
            self.description = try container.decode(String.self, forKey: .description)
            self.attributedDescription = description.fromHtmlToAttributed()
            self.relatedBuildings = try container.decode([Building].self, forKey: .relatedBuildings)
            self.birth = dateAndPlace(type: "born", date: birthDay, place: birthPlace, country: birthCountry)
            self.death = dateAndPlace(type: "died", date: deathDay, place: deathPlace, country: deathCountry)
        }
    }
}

func dateAndPlace(type: String, date: String, place: String, country: String) -> String {
    let location = [place, country].filter{ !$0.isEmpty }.joined(separator: ", ")
    guard !(location.isEmpty && date.isEmpty) else{ return "" }
    return "\(type) \(date) \(location.isEmpty ? "" : " in \(location)")"
}

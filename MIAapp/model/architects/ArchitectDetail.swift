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
        let absoluteURL: URL
        
        enum CodingKeys: CodingKey {
            case id, lastName, firstName,
                 birthDay, birthPlace, birthCountry,
                 deathDay, deathPlace, deathCountry,
                 description, relatedBuildings,
                 absoluteURL
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
            self.birth = dateAndPlace(date: formatDate(birthDay), place: birthPlace, country: birthCountry)
            self.death = dateAndPlace(date: formatDate(deathDay), place: deathPlace, country: deathCountry)
            self.absoluteURL = try container.decode(URL.self, forKey: .absoluteURL)
        }
    }
}

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

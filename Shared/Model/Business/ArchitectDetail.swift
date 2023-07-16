//
//  ArchitectDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 10.07.23.
//

import Foundation

struct ArchitectDetail {
    
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
}

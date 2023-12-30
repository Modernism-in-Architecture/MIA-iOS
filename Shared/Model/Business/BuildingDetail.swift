//
//  BuildingDetail.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 09.07.23.
//

import Foundation
import UIKit

struct BuildingDetail: Decodable {
    
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
    }
}

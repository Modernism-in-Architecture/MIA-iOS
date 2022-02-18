//
//  MIAData.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import MapKit

struct Buildings: Decodable {
    var data: [Building]
}

struct Building: Decodable, Identifiable {
    let id: Int
    let name: String
    let yearOfConstruction: String
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let feedImage: URL
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

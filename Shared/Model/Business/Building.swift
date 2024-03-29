//
//  MIAData.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import MapKit

struct Building: Identifiable {
    
    let id: Int
    let name: String
    let yearOfConstruction: String
    let city: String
    let country: String
    let latitude: Double
    let longitude: Double
    let feedImage: URL?
    let previewImage: URL?
    let coordinate: CLLocationCoordinate2D
}

// MARK: - Building empty

extension Building {
    
    static let empty = Building(
        id: 0,
        name: "",
        yearOfConstruction: "",
        city: "",
        country: "",
        latitude: 0.0,
        longitude: 0.0,
        feedImage: URL(string: "https://modernism-in-architecture.org"),
        previewImage: URL(string: "https://modernism-in-architecture.org"),
        coordinate: CLLocation.leipzig.coordinate
    )
}

//
//  Building+Mock.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 24.12.23.
//

import Foundation
import MapKit

extension Building {
    
    static let schunck = Self(
        id: 1,
        name: "Department store (Modehuis) Schunck (1934)",
        yearOfConstruction: "1934",
        city: "Heerlen",
        country: "Netherlands",
        latitude: 50.88785218450188,
        longitude: 5.979353076537301,
        feedImage: Bundle.main.url(forResource: "Schunck", withExtension: "jpg")!,
        coordinate: CLLocationCoordinate2D(latitude: 50.88785218450188, longitude: 5.979353076537301)
    )
}

//
//  Extensions.swift
//  MIAapp
//
//  Created by Sören Kirchner on 30.01.22.
//

import MapKit

extension CLLocation {
    
    convenience init(_ location: CLLocationCoordinate2D) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}

extension CLLocationCoordinate2D {
    
    var debugDescription: String {
        "coordinate latitude: \(self.latitude), longitude: \(self.longitude)"
    }
}

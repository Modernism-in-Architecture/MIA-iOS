//
//  Extensions.swift
//  MIAapp
//
//  Created by Sören Kirchner on 30.01.22.
//

import Foundation
import MapKit
import SwiftUI
import UIKit

// MARK: - URL + Identifiable

extension URL: Identifiable {
    public var id: Self { self }
}



extension CLLocation {
    convenience init(_ location: CLLocationCoordinate2D) {
        self.init(latitude: location.latitude, longitude: location.longitude)
    }
}

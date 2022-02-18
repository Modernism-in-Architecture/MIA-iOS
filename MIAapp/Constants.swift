//
//  constants.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import SwiftUI
import MapKit

extension Color {
    static let shadow = Color("shadow")
    static let cellBackground = Color("cellBackground")
}

extension CLLocationCoordinate2D {
    static let leipzig = CLLocationCoordinate2D(latitude: 51.378277, longitude: 12.362067)
}

extension MKCoordinateSpan {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

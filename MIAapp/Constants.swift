//
//  constants.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI
import MapKit

extension Color {
    
    static let shadow = Color("shadow")
    static let bookmarkShadow = Color("bookmarkShadow")
    static let cellBackground = Color("cellBackground")
    static let closeButtonForeground = Color("closeButtonForeground")
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
}

extension Double {
    
    static let defaultCameraDistance = 1_000.0
    static let shadowDistanceLimit = 5_000.0
}

extension CLLocation {
    static let leipzig = CLLocation(latitude: 51.378277, longitude: 12.362067)
}

extension MapCameraPosition {
    static let leipzig = MapCameraPosition.camera(.init(centerCoordinate: .leipzig, distance: .defaultCameraDistance))
}

extension CLLocationCoordinate2D {
    static let leipzig = CLLocation.leipzig.coordinate
}

extension CGPoint {
    static let center = CGPoint(x: 0.5, y: 0.5)
}

enum MIADefaults {
    
    enum ImageCache {
        
        static let maxAge: TimeInterval = 24 * 60 * 60 // one day
        static let countLimit = 50
        static let totalCostLimit = 250 * 1024 * 1024 // 0.25 GB
    }
}

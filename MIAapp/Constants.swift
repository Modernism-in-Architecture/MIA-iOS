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
    static let bookmarkShadow = Color("bookmarkShadow")
    static let cellBackground = Color("cellBackground")
    static let closeButtonForeground = Color("closeButtonForeground")
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let tertiaryBackground = Color(UIColor.tertiarySystemBackground)
}

extension CLLocationCoordinate2D {
    static let leipzig = CLLocationCoordinate2D(latitude: 51.378277, longitude: 12.362067)
}

extension MKCoordinateSpan {
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

extension MKCoordinateRegion {
    static let leipzig = MKCoordinateRegion(center: .leipzig, span: .defaultSpan)
}

extension CGPoint {
    static let center = CGPoint(x: 0.5, y: 0.5)
}



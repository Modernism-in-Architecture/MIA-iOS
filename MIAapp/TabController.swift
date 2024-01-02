//
//  TabController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 19.02.22.
//

import Foundation
import SwiftUI
import MapKit

class TabController: ObservableObject {
    
    enum Tab {
        
        case buildings
        case map
        case architects
        case bookmarks
    }
    
    
    @Published 
    var selection: Tab = .buildings
    
    @Published
    private(set) var location: CLLocation = .leipzig
    
    @Published 
    var mapSubviewsVisible: Bool = false
    
    @Published
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .leipzig)
    
    func setCameraPosition(to location: CLLocationCoordinate2D) {
        cameraPosition = .camera(.init(centerCoordinate: location, distance: .defaultCameraDistance))
    }

}

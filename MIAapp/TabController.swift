//
//  TabController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 19.02.22.
//

import Foundation
import MapKit

class TabController: ObservableObject {
    
    enum Tab {
        case buildings
        case map
        case architects
        case bookmarks
    }
    
    @Published var selection: Tab = .buildings
    @Published var region: MKCoordinateRegion = .leipzig
    @Published var mapSubviewsVisible: Bool = false
    
}

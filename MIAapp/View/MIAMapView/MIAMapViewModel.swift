//
//  MIAMapViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.10.21.
//

import MapKit
import SwiftUI

class MIAMapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @EnvironmentObject
    var tabController: TabController
    
    @Published
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .leipzig)
}

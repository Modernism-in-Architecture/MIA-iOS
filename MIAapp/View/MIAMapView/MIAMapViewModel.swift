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
    var region: MKCoordinateRegion = .leipzig
    
    private var initialRun = true
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        checkLocationServiceIsEnabled()
        home()
    }
}

// MARK: - Private Methods

private extension MIAMapViewModel {
    
    func checkLocationServiceIsEnabled() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func currentPosition() -> MKCoordinateRegion {
        
        guard let locationManager = locationManager else { return .leipzig }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("restricted")
            
        case .denied:
            print("denied. Change Settings")
            
        case .authorizedAlways, .authorizedWhenInUse:
            return MKCoordinateRegion(
                center: locationManager.location?.coordinate ?? .leipzig,
                span: .defaultSpan
            )
            
        @unknown default:
            return .leipzig
        }
        return .leipzig
    }

}

// MARK: - Public Methods

extension MIAMapViewModel {
    
    func home() {
        region = currentPosition()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        home()
    }
    
    func distance() -> CLLocationDistance {
        return CLLocation(region.center).distance(from: CLLocation(currentPosition().center))
    }
}

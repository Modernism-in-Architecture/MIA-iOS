//
//  MIAMapController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.10.21.
//

import MapKit
import SwiftUI

class MIAMapController: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region: MKCoordinateRegion = .leipzig
    @EnvironmentObject var tabController: TabController
    
    var initialRun = true
    var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        region = currentPosition()
    }
    
    func checkLocationServiceIsEnabled() {
        guard CLLocationManager.locationServicesEnabled() else { return }
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
            break
        }
        return .leipzig
    }
    
    func home() {
        region = currentPosition()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        _ = currentPosition()
    }
    
    func distance() -> CLLocationDistance {
        return CLLocation(region.center).distance(from: CLLocation(currentPosition().center))
    }
    
}

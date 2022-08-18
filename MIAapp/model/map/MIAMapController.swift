//
//  MIAMapController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.10.21.
//

import MapKit
import SwiftUI
import Combine

class MIAMapController: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @EnvironmentObject var tabController: TabController

    @Published var region: MKCoordinateRegion = .leipzig { didSet { updateZoomLevel() } }
    @Published var zoomLevel = 0
    
    private var initialRun = true
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        checkLocationServiceIsEnabled()
        home()
    }
    
    private func checkLocationServiceIsEnabled() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func currentPosition() -> MKCoordinateRegion {
        
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
    
    func home() {
        region = currentPosition()
    }
    
    func zoom(to location: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: location, span: .defaultSpan)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        home()
    }
    
    func distance() -> CLLocationDistance {
        return CLLocation(region.center).distance(from: CLLocation(currentPosition().center))
    }
    
    private func updateZoomLevel() {
        if region.span.latitudeDelta > 0.05 { zoomLevel = 1 }
        else { zoomLevel = 0 }
    }
    
}



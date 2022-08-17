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

    @Published var region: MKCoordinateRegion = .leipzig {
        didSet {
            if region.span.latitudeDelta > 0.05 { zoomLevel = 1 }
            else { zoomLevel = 0 }
        }
    }
    @Published var zoomLevel = 0
    
    var initialRun = true
    var locationManager: CLLocationManager?
//    var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        checkLocationServiceIsEnabled()
//        $region
//            .throttle(for: .seconds(1.0), scheduler: RunLoop.main, latest: true)
//            .map{ region -> Int in
//                if region.span.latitudeDelta > 0.12 { return 1 }
//                return 0
//            }
//            .receive(on: RunLoop.main)
//            .sink{ zoomLevel in
//                print(zoomLevel)
//                self.zoomLevel = zoomLevel
//            }
//
//            .store(in: &cancellables)
        home()
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
            return .leipzig
        }
        return .leipzig
    }
    
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



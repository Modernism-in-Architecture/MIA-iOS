//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import SwiftUI
import MapKit

struct MIAMapView: View {

    @EnvironmentObject var mia: BuildingsController
    @StateObject var mapController = MIAMapController()

    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapController.region, showsUserLocation: true, annotationItems: mia.buildings) {item in
                MapAnnotation(
                    coordinate: item.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 0.5)
                ) {
                    NavigationLink(destination: BuildingDetailView(item: item)) {
                       MIAMapPinView()
                    }
                    .buttonStyle(.plain)
                }
            }
            .accentColor(Color(.systemRed))
            .onAppear {
                mapController.checkLocationServiceIsEnabled()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Orte")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct MIAMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapView(mia: <#T##BuildingsController#>)
//    }
//}

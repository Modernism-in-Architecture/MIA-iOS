//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import MapKit
import SwiftUI

// MARK: - MIAMapView

struct MIAMapView: View {
    
    @EnvironmentObject
    var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject 
    var tabController: TabController
    
    @EnvironmentObject 
    var mapController: MIAMapViewModel
    
    @State var selectedItem: Building = .empty
    
    var body: some View {
        NavigationView {
            ZStack {
                
                map
                
                homeButton
                    .padding()
                    .background(
                        NavigationLink(destination: BuildingView(item: selectedItem), isActive: $tabController.mapSubviewsVisible) { EmptyView() }
                            .isDetailLink(false)
                    )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    MIAToolBarLogo()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var map: some View {

        return Map {
            
            ForEach(buildingsViewModel.buildings) { building in
                
                Annotation(building.name, coordinate: building.coordinate) {
                    
                    MIAMapPinView(building: building)
                    
                        .onTapGesture {
                            selectedItem = building
                            tabController.mapSubviewsVisible = true
                        }
                }
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControls {
            MapPitchToggle()
            MapUserLocationButton()
            MapCompass()
//            MapScaleView()
        }
        .accentColor(Color(.systemRed))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Places")
    }
    
    //    var oldmap: some View {
    //
    //        let zoomLevel = mapController.zoomLevel
    //        return Map(coordinateRegion: $mapController.region,
    //            showsUserLocation: true,
    //            annotationItems: mapItems) { mapItem in
    //            MapAnnotation(coordinate: mapItem.coordinate, anchorPoint: .center) {
    //                MIAMapPinView(zoomLevel: zoomLevel, mapItem: mapItem)
    //                    .onTapGesture {
    //                        if let building = mapItem.building {
    //                            selectedItem = building
    //                            tabController.mapSubviewsVisible = true
    //                        } else {
    //                            withAnimation {
    //                                mapController.zoom(to: mapItem.coordinate, on: zoomLevel)
    //                            }
    //                        }
    //                    }
    //            }
    //        }
    //            .accentColor(Color(.systemRed))
    //            .navigationBarTitleDisplayMode(.inline)
    //            .navigationTitle("Places")
    //    }
    
    var homeButton: some View {
        
        VStack(alignment: .trailing) {
            
            if mapController.distance() > 1000 {
                
                HStack {
                    
                    Spacer()
                    Button(action: {
                        withAnimation {
                            mapController.home()
                        }
                    }) {
                        Image(systemName: "location")
                            .font(.title3)
                            .padding(8)
                            .background(Color.secondaryBackground)
                            .cornerRadius(5)
                            .shadow(radius: 3)
                    }
                    .buttonStyle(.plain)
                }
                .transition(.opacity.animation(.easeInOut(duration: 0.5)))
            }
            Spacer()
        }
    }
}
// struct MIAMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapView(mia: <#T##BuildingsListViewModel#>)
//    }
// }

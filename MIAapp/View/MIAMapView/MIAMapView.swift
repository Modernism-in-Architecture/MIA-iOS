//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import MapKit
import SwiftUI
import OSLog

// MARK: - MIAMapView

struct MIAMapView: View {
    
    @EnvironmentObject
    var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject 
    var tabController: TabController
    
    @EnvironmentObject 
    var mapViewModel: MIAMapViewModel
    
    @State 
    var selectedItem: Building = .empty
    
    @State
    var showPinShadow = true
    
    @Namespace
    var mapScope
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                map
                    .background(
                        NavigationLink(destination: BuildingView(building: selectedItem), isActive: $tabController.mapSubviewsVisible) { EmptyView() }
                            .isDetailLink(false)
                    )
            }
            .mapScope(mapScope)
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    MIAToolBarLogo()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var map: some View {

        return Map(
            position: $mapViewModel.cameraPosition,
            bounds: MapCameraBounds(minimumDistance: 1000),
            scope: mapScope)
        {
            
            UserAnnotation()
            ForEach(buildingsViewModel.buildings) { building in
                
                Annotation(building.name, coordinate: building.coordinate) {
                    
                    MIAMapPinView(building: building, showShadow: showPinShadow)
                    
                        .onTapGesture {
                            
                            Logger.map.debug("Building \(building.id) selected.")
                            selectedItem = building
                            tabController.mapSubviewsVisible = true
                        }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            
            MapPitchToggle()
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Places")
        .onMapCameraChange(frequency: .continuous) { context in
            
            self.showPinShadow = context.camera.distance < 5_000
            Logger.map.debug("Update Map \(context.camera.distance)")
        }
    }
}

 struct MIAMapView_Previews: PreviewProvider {
    static var previews: some View {
        MIAMapView()
            .environmentObject(BuildingsListViewModel())
            .environmentObject(TabController())
            .environmentObject(MIAMapViewModel())
    }
 }

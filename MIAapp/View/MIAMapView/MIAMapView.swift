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
    
    // MARK: - Properties
    
    @EnvironmentObject
    private var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject 
    private var tabController: TabController
    
    @State 
    private var selectedItem: Building = .empty
    
    @State
    private var showPinShadow = true
    
    @Namespace
    private var mapScope
    
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
            position: $tabController.cameraPosition,
            bounds: MapCameraBounds(minimumDistance: .defaultCameraDistance),
            scope: mapScope
        ) {
            
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
            
            self.showPinShadow = context.camera.distance < .shadowDistanceLimit
            Logger.map.debug("Update Map \(context.camera.distance)")
        }
    }
}

#Preview {
    
    MIAMapView()
        .environmentObject(BuildingsListViewModel())
        .environmentObject(TabController())
}

//
//  MIAMapSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import MapKit
import OSLog
import SwiftUI
import MIACore
import MIACoreUI

// MARK: - MIAMapView

// TODO: Cleanup and Format this File
struct MIAMapSuccessView: View {
    
    // MARK: - Properties

    @EnvironmentObject
    private var mapViewModel: MIAMapViewModel
    
    @EnvironmentObject
    private var router: MIARouter
    
    @State
    var buildings: [Building]
    
    @State
    private var showPinShadow = true
    
    @Namespace
    private var mapScope

    
    var body: some View {
        content
    }
    
    var content: some View {
        
        ZStack {
            map
        }
        .mapScope(mapScope)
        .toolbar {
                
            ToolbarItem(placement: .navigationBarLeading) {
                MIAToolBarLogo()
            }
        }
    }
    
    var map: some View {
        
        Map(
            position: $mapViewModel.cameraPosition,
            bounds: MapCameraBounds(minimumDistance: .defaultCameraDistance),
            scope: mapScope
        ) {
            
            UserAnnotation()
            
            ForEach(self.buildings) { building in
                
                Annotation(building.name, coordinate: building.coordinate) {
                    
                    MIAMapPinView(previewImageURL: building.feedImage, showShadow: showPinShadow)
                    
                        .onTapGesture {
                            router.showBuildingDetail(id: building.id)
                        }
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .ignoresSafeArea(edges: .bottom)
        .mapControls {

            VStack {
                
                MapPitchToggle()
                MapUserLocationButton()
                MapCompass()
                MapScaleView()
            }
            .background(.brown)
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Places")
        .onMapCameraChange(frequency: .continuous) { context in
            
            self.showPinShadow = context.camera.distance < .shadowDistanceLimit
        }
    }
}

#Preview {
    
    MIAMapSuccessView(buildings: [])
        .environmentObject(BuildingsListViewModel())
        .environmentObject(TabController())
}

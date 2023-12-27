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
    var mapViewModel: MIAMapViewModel
    
    @State 
    var selectedItem: Building = .empty
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                map
                    .background(
                        NavigationLink(destination: BuildingView(building: selectedItem), isActive: $tabController.mapSubviewsVisible) { EmptyView() }
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

        return Map(position: $mapViewModel.cameraPosition) {
            
            ForEach(buildingsViewModel.buildings) { building in
                
                Annotation(building.name, coordinate: building.coordinate) {
                    
                    MIAMapPinView(building: building)
                    
                        .onTapGesture {
                            print("### Tapped")
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
            MapScaleView()
        }
        .accentColor(Color(.systemRed))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Places")
    }
}



// struct MIAMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapView(mia: <#T##BuildingsListViewModel#>)
//    }
// }

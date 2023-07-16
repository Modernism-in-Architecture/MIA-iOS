//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import SwiftUI
import MapKit

struct MIAMapView: View {

    @EnvironmentObject var buildingsController: BuildingsListViewModel
    @EnvironmentObject var tabController: TabController
    @EnvironmentObject var mapController: MIAMapViewModel
    
    @State var selectedItem: Building = .empty
    
    var mapItems: [MapItem] {
        buildingsController.levelContent.reversed().filter { $0.level == mapController.zoomLevel }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                let zoomLevel = mapController.zoomLevel
                Map(coordinateRegion: $mapController.region,
                    showsUserLocation: true,
                    annotationItems: mapItems) { mapItem in
                    MapAnnotation(coordinate: mapItem.coordinate, anchorPoint: .center) {
                        MIAMapPinView(zoomLevel: zoomLevel, mapItem: mapItem)
                            .onTapGesture {
                                if let building = mapItem.building {
                                    selectedItem = building
                                    tabController.mapSubviewsVisible = true
                                } else {
                                    withAnimation {
                                        mapController.zoom(to: mapItem.coordinate, on: zoomLevel)
                                    }
                                }
                            }
                    }
                }
                    .accentColor(Color(.systemRed))
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Places")
                
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
    
    var homeButton: some View {
        VStack(alignment: .trailing) {
            if mapController.distance() > 1000 {
                HStack {
                    Spacer()
                    Button (action: {
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

//struct MIAMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapView(mia: <#T##BuildingsListViewModel#>)
//    }
//}

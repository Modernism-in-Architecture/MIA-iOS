//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import SwiftUI
import MapKit

struct MIAMapView: View {

    @EnvironmentObject var buildingsController: BuildingsController
    @EnvironmentObject var tabController: TabController
    @EnvironmentObject var mapController: MIAMapController
    
    @State var selectedItem: Building = .empty
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $mapController.region,
                    showsUserLocation: true,
                    annotationItems: mapController.zoomLevel == 0 ? buildingsController.annotations : buildingsController.groupedBuildings) { item in
                    MapAnnotation(coordinate: item.coordinate, anchorPoint: .center) {
                        if mapController.zoomLevel == 0 {
                            MIAMapPinView(color: .green)
                                .onTapGesture {
                                    selectedItem = item.building
                                    tabController.mapSubviewsVisible = true
                                }
                                .buttonStyle(.plain)
                        } else {
                            MIAMapPinView(color: .red)
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
//        MIAMapView(mia: <#T##BuildingsController#>)
//    }
//}

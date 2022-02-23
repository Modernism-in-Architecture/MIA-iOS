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
                Map(coordinateRegion: $mapController.region, showsUserLocation: true, annotationItems: buildingsController.buildings) {item in
                    MapAnnotation(
                        coordinate: item.coordinate,
                        anchorPoint: .center
                    ) {
                        //                        NavigationLink(destination: BuildingDetailView(item: item), isActive: $subviewIsActive)
                        MIAMapPinView()
                            .onTapGesture {
                                selectedItem = item
                                tabController.mapSubviewsVisible = true
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
//                    Text("\(mapController.distance())")
                }
                .padding()
                .background(
                    NavigationLink(destination: BuildingDetailView(item: selectedItem), isActive: $tabController.mapSubviewsVisible) {EmptyView()}
                        .isDetailLink(false)//,
//                                   isActive: $isActivated) {EmptyView()}
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct MIAMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapView(mia: <#T##BuildingsController#>)
//    }
//}

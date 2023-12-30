//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI
import MapKit


struct BuildingDetailView: View {
    
    @EnvironmentObject var mapController: MIAMapViewModel
    @EnvironmentObject var tabController: TabController
    
    @State var building: Building
    @State var buildingDetail: BuildingDetail
    
    @State var showShareSheet = false
    @State var sharedItems = []
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                MIAAsyncHeaderImage(url: building.feedImage)
                VStack (alignment: .leading, spacing: 15) {
                    MIASection("Building") {
                        buildingDetails
                    }
                    MIASection("Architects", ignoreIf: buildingDetail.architects.isEmpty) {
                        architectsDetails
                    }
                    MIASection("Description", ignoreIf: buildingDetail.description.isEmpty) {
                        MIAFoldableText(text: buildingDetail.attributedDescription)
                    }
                    MIASection("History", ignoreIf: buildingDetail.description.isEmpty) {
                        MIAFoldableText(text: buildingDetail.attributedHistory)
                    }
                    MIASection("Location") {
                        locationDetail
                    }
                    MIASection("Impressions", ignoreIf: buildingDetail.galleryImages.isEmpty) {
                        BuildingDetailGridGalleryView(images: buildingDetail.galleryImages)
                            .padding(.top, 5)
                    }
                }
                .padding()
            }
        }
        .padding(.top, 10)
        .navigationTitle(building.name)
        .toolbar {
            HStack {
                BookmarkToolbarView(id: building.id)
                MIAShareView(url: buildingDetail.absoluteURL)
            }
        }
    }
    
    var buildingDetails: some View {
        VStack(alignment: .leading) {
            Text(buildingDetail.name)
                .font(.headline)
                .padding(.bottom, 5)
            if !buildingDetail.buildingType.isEmpty {
                Text(buildingDetail.buildingType)
                    .padding(.bottom, 5)
            }
            Text(buildingDetail.address)
            Text(buildingDetail.cityCountry)
            VStack(alignment: .leading) {
                if !buildingDetail.todaysUse.isEmpty {
                    Text("Today's Use: \(buildingDetail.todaysUse)")
                }
                if !buildingDetail.yearOfConstruction.isEmpty {
                    Text("Year of Construction: \(buildingDetail.yearOfConstruction)")
                }
            }
            .padding(.top, 5)
        }
    }
    
    var architectsDetails: some View {
        ForEach(buildingDetail.architects) { architect in
            NavigationLink(destination: ArchitectView(id: architect.id)) {
                Text(architect.fullName)
                    .underline()
            }
            .buttonStyle(.plain)
        }
    }
    
    var locationDetail: some View {
        ZStack {
            BuildingDetailMapView(building: building)
            .frame(height: 250)
            .mask(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 5)
            .allowsHitTesting(false) // No Interaction
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    mapController.setLocation(to: building.coordinate)
                    self.tabController.mapSubviewsVisible = false
                    tabController.selection = .map
                }
        }
    }
}

#Preview {
    BuildingDetailView(building: .schunckMock, buildingDetail: .schunckMock)
}

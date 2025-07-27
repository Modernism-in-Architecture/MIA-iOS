//
//  BuildingDetailSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import MapKit
import OSLog
import SwiftUI
import MIACore
import MIACoreUI

// MARK: - BuildingDetailSuccessView

struct BuildingDetailSuccessView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject
    var router: MIARouter
  
    @EnvironmentObject
    var mapViewModel: MIAMapViewModel
    
    @State
    var buildingDetail: BuildingDetail
    
    @State
    private var showShareSheet = false
    
    @State
    private var sharedItems = []
    
    var body: some View {
        
        content
    }
}

// MARK: - Body

private extension BuildingDetailSuccessView {
    
    var content: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                MIAAsyncHeaderImage(url: buildingDetail.feedImageURL, background: .background)
                details
                    .padding()
            }
        }
        .padding(.top, 10)
        .navigationTitle(buildingDetail.name)
        .toolbar {
            
            HStack {
                
                BookmarkToolbarView(id: buildingDetail.id)
                MIAShareView(url: buildingDetail.absoluteURL)
            }
        }
    }
    
    var details: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            
            MIASection("Building") {
                buildingDetails
            }
            MIASection("Architects", ignoreIf: buildingDetail.architects.isEmpty) {
                architectsDetails
            }
            MIASection("Description", ignoreIf: buildingDetail.description.isEmpty) {
                MIAFoldableText(text: buildingDetail.attributedDescription)
            }
            MIASection("History", ignoreIf: buildingDetail.history.isEmpty) {
                MIAFoldableText(text: buildingDetail.attributedHistory)
            }
            MIASection("Location") {
                locationDetail
            }
            MIASection("Impressions", ignoreIf: buildingDetail.galleryImages.isEmpty) {
                
                BuildingDetailGridGalleryView(identifiableImageUrls: buildingDetail.galleryImages)
                    .padding(.top, 5)
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
            
            Text(architect.fullName)
                .underline()
                .onTapGesture {
                    router.showArchitectDetail(id: architect.id)
                }
                .buttonStyle(.plain)
        }
    }
    
    var locationDetail: some View {
        
        ZStack {
            
            BuildingDetailMapView(mapItem: buildingDetail)
                .frame(height: 250)
                .mask(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 5)
                .allowsHitTesting(false) // No Interaction
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture(perform: showItemOnMap)
        }
    }
}

private extension BuildingDetailSuccessView {
    
    func showItemOnMap() {
        
        mapViewModel.setCameraPosition(to: buildingDetail)
        router.toRoot()
        router.showMap(with: buildingDetail)
    }
}

//#Preview {
//    BuildingDetailSuccessView(building: .schunckMock, buildingDetail: .schunckMock)
//}

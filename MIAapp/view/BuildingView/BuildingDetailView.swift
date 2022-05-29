//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI
import MapKit


struct BuildingDetailView: View {
    
    @EnvironmentObject var mapController: MIAMapController
    @EnvironmentObject var tabController: TabController
    
    @State var item: Building
    @State var detail: BuildingDetail.Detail
    
    @State var showShareSheet = false
    @State var sharedItems = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MIAAsyncHeaderImage(url: item.feedImage)
                VStack (alignment: .leading, spacing: 15) {
                    MIASection("Building") {
                        buildingDetails
                    }
                    MIASection("Architects", ignoreIf: detail.architects.isEmpty) {
                        architectsDetails
                    }
                    MIASection("Description", ignoreIf: detail.description.isEmpty) {
                        MIAFoldableText(text: detail.attributedDescription)
                    }
                    MIASection("History", ignoreIf: detail.description.isEmpty) {
                        MIAFoldableText(text: detail.attributedHistory)
                    }
                    MIASection("Location") {
                        locationDetail
                    }
                    MIASection("Impressions", ignoreIf: detail.galleryImages.isEmpty) {
                        BuildingDetailGridGalleryView(images: detail.galleryImages)
                            .padding(.top, 5)
                    }
                }
                .padding()
            }
        }
        .padding(.top, 10)
        .navigationTitle(item.name)
        .toolbar {
            Button(action: shareBuilding) {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
    
    var buildingDetails: some View {
        VStack(alignment: .leading) {
            Text(detail.name)
                .font(.headline)
                .padding(.bottom, 5)
            if !detail.buildingType.isEmpty {
                Text(detail.buildingType)
                    .padding(.bottom, 5)
            }
            Text(detail.address)
            Text(detail.cityCountry)
            VStack(alignment: .leading) {
                if !detail.todaysUse.isEmpty {
                    Text("Today's Use: \(detail.todaysUse)")
                }
                if !detail.yearOfConstruction.isEmpty {
                    Text("Year of Construction: \(detail.yearOfConstruction)")
                }
            }
            .padding(.top, 5)
        }
    }
    
    var architectsDetails: some View {
        ForEach(detail.architects) { architect in
            NavigationLink(destination: ArchitectDetailView(id: architect.id)) {
                Text(architect.fullName)
                    .underline()
            }
            .buttonStyle(.plain)
        }
    }
    
    var locationDetail: some View {
        ZStack {
            BuildingDetailMapView(item: item, region: MKCoordinateRegion(
                center: item.coordinate, span: .defaultSpan
            ))
            .frame(height: 250)
            .mask(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 5)
            .allowsHitTesting(false) // No Interaction
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    let region = MKCoordinateRegion(center: item.coordinate, span: .defaultSpan)
                    mapController.region = region
                    self.tabController.mapSubviewsVisible = false
                    tabController.selection = .map
                }
        }
    }
    
    private func shareBuilding() {
        let sharedText = "Sent with ❤️ from your MIA App."
        let sharedItems = [detail.absoluteURL, sharedText] as [Any]
        let ac = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
        
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        if let windowScene = scene as? UIWindowScene {
            windowScene.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
        }
    }
}

//struct BuildingDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView()
//    }
//}

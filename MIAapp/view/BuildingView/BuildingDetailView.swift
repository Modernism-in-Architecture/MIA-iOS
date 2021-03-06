//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import SwiftUI
import MapKit

struct BuildingDetailView: View {
    
    @EnvironmentObject var mapController: MIAMapController
    @EnvironmentObject var tabController: TabController

    @StateObject var detailController = BuildingDetailController()

    @State var item: Building
    @State var showShareSheet = false
    
    @State var sharedItems = []
        
    var body: some View {
        switch detailController.detail {
        case .success(let detail):
            ScrollView {
                LazyVStack(alignment: .leading) {
                    // MARK: - Image
                    Rectangle()
                        .aspectRatio(1.3, contentMode: .fill)
                        .overlay{
                            MIAAsyncImage(url: item.feedImage)
                        }
                        .clipped()

                    VStack (alignment: .leading, spacing: 15) {
                        // MARK: - Details
                        MIASection("Building") {
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
                        MIASection("Architects") {
                            ForEach(detail.architects) { architect in
                                NavigationLink(destination: ArchitectDetailView(id: architect.id)) {
                                    Text(architect.fullName)
                                        .underline()
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        if !detail.description.isEmpty {
                            MIASection("Description") {
                                MIAFoldableText(text: detail.attributedDescription)
                            }
                        }
                        if !detail.description.isEmpty {
                            MIASection("History") {
                                MIAFoldableText(text: detail.attributedHistory)
                            }
                        }
                        // MARK: - Small Map
                        MIASection("Location") {
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
                        // MARK: - Grid Gallery
                        if !detail.galleryImages.isEmpty {
                            MIASection("Impressions") {
                                BuildingDetailGridGalleryView(images: detail.galleryImages)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(.top, 10)
            .navigationTitle(item.name)
            // MARK: - Share Button
            .toolbar {
                Button(action: {
                    let sharedText = "Sent with ❤️ from your MIA App."
                    let sharedItems = [detail.absoluteURL, sharedText] as [Any]
                    let ac = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
                    
                    let allScenes = UIApplication.shared.connectedScenes
                    let scene = allScenes.first { $0.activationState == .foregroundActive }
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }

        case .loading:
            MIAActivityIndicator().task {
//                try! await Task.sleep(nanoseconds: 5 * NSEC_PER_SEC)
                await detailController.fetchData(for: item.id)
            }
        case .error(let error):
            MIAErrorView(error: error)
        }
    }
}

//struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView(item: .example())
//    }
//}

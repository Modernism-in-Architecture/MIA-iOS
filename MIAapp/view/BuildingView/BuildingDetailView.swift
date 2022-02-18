//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import SwiftUI
import MapKit

struct BuildingDetailView: View {
    
    @State var item: Building
    @StateObject var detailController = BuildingDetailController()
    
    var body: some View {
        switch detailController.detail {
        case .success(let detail):
            ScrollView {
                LazyVStack(alignment: .leading) {
                    // Image
                    Rectangle()
                        .aspectRatio(1.3, contentMode: .fill)
                        .overlay{
                            MIAAsyncImage(url: item.feedImage)
                        }
                        .clipped()

                    // Details
                    VStack (alignment: .leading, spacing: 15) {
                        MIASection("Building") {
                            Text(detail.name)
                                .font(.headline)
                                .padding(.bottom, 5)
                            Text(detail.address)
                            Text(detail.cityCountry)
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
                        MIASection("Location") {
                            BuildingDetailMapView(item: item, region: MKCoordinateRegion(
                                center: item.coordinate, latitudinalMeters: 500, longitudinalMeters: 500
                            ))
                                .frame(height: 250)
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .padding(.top, 5)
                                .allowsHitTesting(false) // No Interaction
                        }
                        if !detail.galleryImages.isEmpty {
                            MIASection("Impressions") {
                                BuildingDetailGridGalleryView(images: detail.galleryImages)
                                    .padding(.top, 5)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle(item.name)
            }
        case .loading:
            LoadingActivityView().task {
//            MIAActivityIndicator().task {
                await detailController.fetchData(for: item.id)
            }
        case .error(let error):
            MIAErrorView(error: error)
        }
    }
}

struct MIADetailView_Previews: PreviewProvider {
    static var previews: some View {
        BuildingDetailView(item: .example())
    }
}

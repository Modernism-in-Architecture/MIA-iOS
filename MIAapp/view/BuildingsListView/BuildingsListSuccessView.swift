//
//  BuildingsListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import MapKit
import SwiftUI

struct BuildingsListSuccessView: View {
    
    @EnvironmentObject var buildingsController: BuildingsController
    
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var showMap = false
    @State private var focusedBuilding: Building = .empty
    
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]

    var body: some View {
        NavigationView {
            VStack {
                if isSearching {
                    MIASearchBar(text: $searchText, isSearching: $isSearching)
                }

                if showMap {
//                    MIALiveMap(focusedBuilding: focusedBuilding)
                    liveMap
                }
                
                Text("\(focusedBuilding.id)")

                buildingScrollView
                    .coordinateSpace(name: "BuildingsScrollView")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Buildings")

                    .navigationViewStyle(StackNavigationViewStyle())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            MIAToolBarLogo()
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: toggleMap) {
                                Image(systemName: showMap ? "map.circle.fill" : "map.circle")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            MIASearchButton(isSearching: $isSearching)
                        }
                    }
            }
            .onPreferenceChange(BuildingOffsetPreferenceKey.self) { value in
                let offset = 150.0
                print("update")
                let newFocusedBuilding = value.first(where: { id, origin in
                    return origin > offset && origin < offset + 355
                })?.key ?? self.focusedBuilding
                if newFocusedBuilding.id != self.focusedBuilding.id {
                    print("set")
                    withAnimation {
                        self.focusedBuilding = newFocusedBuilding
                    }
                }
            }
        }
    }

    var liveMap: some View {

//        let focusedBuilding = buildingsController.focusedBuilding

        return Map(
            coordinateRegion: .constant(MKCoordinateRegion(center: focusedBuilding.coordinate,
                                                           span: .previewSpan)),
            annotationItems: [focusedBuilding]
        ) { building in
            MapAnnotation(coordinate: building.coordinate) {
                MIAMapImagePinView(url: building.feedImage)
            }
        }
        .frame(height: 160)

    }

    var buildingScrollView: some View {
        
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                ForEach(searchResults) { building in
                    BuildingsListCellView(building: building, searchText: searchText)
                        .overlay {
                            GeometryReader { geometry in
                                Text("GEO \(geometry.size.height)")
                                Color.clear
                                    .preference(
                                        key: BuildingOffsetPreferenceKey.self,
                                        value: [building: geometry.frame(in: .named("scrollView")).origin.y]) //geo.frame(in: .named("scrollView")).origin.y
//                                    .onChange(of: geometry.frame(in: .named("BuildingsScrollView"))) { newValue in
//                                        let offset = 150.0
//                                        if newValue.maxY > offset, newValue.maxY < newValue.height + offset {
//                                            print(building.id)
////
//                                        }
//                                    }
                                    
                            }
                        }
                }
//                .onPreferenceChange(BuildingOffsetPreferenceKey.self) { dict in
//                    print(dict.first)
//                }
            }
            .padding()
        }
    }

    var searchResults: [Building] {
        if searchText.isEmpty { return buildingsController.buildings }
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return buildingsController.buildings.filter { building in
            building.name.lowercased().contains(trimmed) ||
                building.city.lowercased().contains(trimmed) ||
                building.country.lowercased().contains(trimmed)
        }
    }

    func toggleMap() {
        withAnimation {
            showMap.toggle()
        }
    }
}

struct BuildingOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [Building: Double] = [:]
    
    static func reduce(value: inout [Building: Double], nextValue: () -> [Building: Double]) {
        value.merge(nextValue()) { $1 }
//        print(value.first.id)
    }
}



// struct BuildingsListSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingsListSuccessView()
//    }
// }

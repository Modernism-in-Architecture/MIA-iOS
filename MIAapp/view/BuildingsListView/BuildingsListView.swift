//
//  BuildingsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

struct BuildingsListView: View {
    
    @EnvironmentObject var buildingsController: BuildingsController
    @State private var searchText = ""
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]
    
    var body: some View {
        switch buildingsController.state {
        case .success:
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                        ForEach(searchResults) { building in
                            NavigationLink(destination: BuildingDetailView(item: building)) {
                                if searchText.isEmpty {
                                    BuildingsListCellView(item: building)
                                } else {
                                    VStack(alignment: .leading) {
                                        Text(building.name)
                                            .lineLimit(1)
                                        Text("\(building.city), \(building.country)")
                                            .font(.caption)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .refreshable {
                        Task {
                            buildingsController.state = .loading
                            await buildingsController.fetchData()
                        }
                    }
                    .padding()
                }
                .searchable(text: $searchText)
                .disableAutocorrection(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Buildings")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        case .loading:
            MIAActivityIndicator()
        case .error(let error):
            MIAErrorView(error: error)
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
    
}

//struct MIAListView_Previews: PreviewProvider {
//
//    @ObservedObject var mia: BuildingsController
//
//    static var previews: some View {
//        MIAListView(mia: mia)
//    }
//}

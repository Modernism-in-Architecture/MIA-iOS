//
//  BuildingsListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI

struct BuildingsListSuccessView: View {
    
    @State private var searchText = ""
    @State var buildings: [Building]
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    ForEach(searchResults) { building in
                        BuildingsListCellView(building: building, searchText: searchText)
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Buildings")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    MIAToolBarLogo()
                }
            }
        }
        .disableAutocorrection(true)
        .searchable(text: $searchText)
    }
    
    var searchResults: [Building] {
        if searchText.isEmpty { return buildings }
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return buildings.filter { building in
            building.name.lowercased().contains(trimmed) ||
            building.city.lowercased().contains(trimmed) ||
            building.country.lowercased().contains(trimmed)
        }
    }
}

//struct BuildingsListSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingsListSuccessView()
//    }
//}

//
//  BookmarksView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.06.22.
//

import SwiftUI

struct BookmarksView: View {
    
    @EnvironmentObject var buildingsController: BuildingsController
    @EnvironmentObject var bookmarksController: BookmarksController
    
    var body: some View {
        NavigationView {
            List {
                ForEach(bookmarkedBuildings) { building in
                    NavigationLink(destination: BuildingView(item: building)) {
                        VStack(alignment: .leading) {
                            Text(building.name)
                                .lineLimit(1)
                            Text("\(building.city), \(building.country)")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(.grouped)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Bookmarks")
            .navigationViewStyle(StackNavigationViewStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    MIAToolBarLogo()
                }
            }
        }
    }
    
    func delete(at indexes: IndexSet) {
        if let index = indexes.first {
            bookmarksController.toggle(id: bookmarkedBuildings[index].id)
        }
    }

    
//    var caption: some View {
//        VStack(alignment: .leading) {
//            Text(building.name)
//                .lineLimit(1)
//            Text("\(building.city), \(building.country)")
//                .font(.caption)
//                .lineLimit(1)
//        }
//    }
    
    var bookmarkedBuildings: [Building] {
        return buildingsController.buildings.filter { building in
            bookmarksController.contains(id: building.id)
        }
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}

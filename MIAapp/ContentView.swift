//
//  ContentView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @EnvironmentObject var tabController: TabController
    @EnvironmentObject var cloudKitBookmarksController: CloudKitBookmarksController

    var body: some View {
        TabView(selection: $tabController.selection) {
            BuildingsListView().tabItem {
                Label("Buildings", systemImage: "building.2")
            }.tag(TabController.Tab.buildings)
            MIAMapView().tabItem {
                Label("Places", systemImage: "map")
            }.tag(TabController.Tab.map)
            ArchitectsListView().tabItem {
                Label("Architects", systemImage: "person.2")
            }.tag(TabController.Tab.architects)
            BookmarksView().tabItem {
                Label("Bookmarks", systemImage: "bookmark")
            }.tag(TabController.Tab.bookmarks)
//                .badge(cloudKitBookmarksController.bookmarks.count)
        }
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

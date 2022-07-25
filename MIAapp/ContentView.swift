//
//  ContentView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var tabController: TabController
    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

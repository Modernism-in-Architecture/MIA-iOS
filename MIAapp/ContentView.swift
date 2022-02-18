//
//  ContentView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

struct ContentView: View {
    
//    @StateObject var mia = BuildingsController()
//    @StateObject var architectsController = ArchitectsController()
    @State private var selection = 1
    
    var body: some View {
        TabView(selection: $selection) {
            BuildingsListView().tabItem {
                Label("Buildings", systemImage: "building.2")
            }.tag(1)
            MIAMapView().tabItem {
                Label("Places", systemImage: "map")
            }.tag(2)
            ArchitectsListView().tabItem {
                Label("Architects", systemImage: "person.2")
            }.tag(3)
            MIAErrorView(error: .NetworkError).tabItem {
                Label("Bookmarks", systemImage: "bookmark")
            }.tag(4)
        }
//        .task {
//            await mia.fetchData()
////            await architectsController.fetchData()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

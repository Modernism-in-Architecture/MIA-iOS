//
//  MIAappApp.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

@main
struct MIAappApp: App {
    
    @StateObject var buildingsController = BuildingsListViewModel()
    @StateObject var architectsController = ArchitectsListViewModel()
    @StateObject var tabController = TabController()
    @StateObject var mapController = MIAMapViewModel()
    @StateObject var cloudKitBookmarksController = BookmarksViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(buildingsController)
                .environmentObject(architectsController)
                .environmentObject(mapController)
                .environmentObject(tabController)
                .environmentObject(cloudKitBookmarksController)
                .task {
                    await buildingsController.fetchData()
                    await architectsController.fetchData()
                }
        }
    }
}

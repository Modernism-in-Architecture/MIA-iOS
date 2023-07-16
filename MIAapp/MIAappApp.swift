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
    @StateObject var architectsController = ArchitectsController()
    @StateObject var tabController = TabController()
    @StateObject var mapController = MIAMapController()
    @StateObject var cloudKitBookmarksController = CloudKitBookmarksController()

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

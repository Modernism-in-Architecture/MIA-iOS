//
//  MIAappApp.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

@main
struct MIAappApp: App {
    
    @StateObject var buildingsController = BuildingsController()
    @StateObject var architectsController = ArchitectsController()
    @StateObject var tabController = TabController()
    @StateObject var mapController = MIAMapController()
    @StateObject var bookmarkController = BookmarksController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(buildingsController)
                .environmentObject(architectsController)
                .environmentObject(mapController)
                .environmentObject(tabController)
                .environmentObject(bookmarkController)
                .task {
                    await buildingsController.fetchData()
                    await architectsController.fetchData()
                }
        }
    }
}

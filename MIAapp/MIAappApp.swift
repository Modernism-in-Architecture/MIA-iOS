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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(buildingsController)
                .environmentObject(architectsController)
                .environmentObject(mapController)
                .environmentObject(tabController)
                .task {
                    await buildingsController.fetchData()
                    await architectsController.fetchData()
                }
        }
    }
}

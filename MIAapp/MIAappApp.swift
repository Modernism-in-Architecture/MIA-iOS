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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(buildingsController)
                .environmentObject(architectsController)
                .task {
                    await buildingsController.fetchData()
                    await architectsController.fetchData()
                }
        }
    }
}

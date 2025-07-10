//
//  MIAappApp.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

@main
struct MIAappApp: App {
    
    @StateObject
    var tabController = TabController()
    
    @StateObject
    var router = MIARouter()
    
    @StateObject
    var buildingsListViewModel = BuildingsListViewModel()
    
    @StateObject
    var mapViewModel = MIAMapViewModel()
    
    @StateObject
    var architectsListViewModel = ArchitectsListViewModel()
    
    @StateObject
    var cloudKitBookmarksController = BookmarksViewModel()
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView()
                .environmentObject(tabController)
                .environmentObject(router)
                .environmentObject(buildingsListViewModel)
                .environmentObject(mapViewModel)
                .environmentObject(architectsListViewModel)
                .environmentObject(cloudKitBookmarksController)
                .task {
                    
                    buildingsListViewModel.fetch()
                    architectsListViewModel.fetch()
                }
                .onOpenURL { url in
                    
                    router.deepLinkTarget = url
                    router.checkDeepLinkTarget()
                }
        }
    }
}

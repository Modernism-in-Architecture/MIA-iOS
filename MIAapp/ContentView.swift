//
//  ContentView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

// MARK: - ContentView

struct ContentView: View {

    @EnvironmentObject var router: MIARouter
    @EnvironmentObject var cloudKitBookmarksController: BookmarksViewModel

    var body: some View {
        
        TabView(selection: $router.selectedTab) {
            
            ForEach(MIARouter.MainScreen.allCases) { tab in
                
                tab.rootView
                    .toolbar(router.tabBarVisibility, for: .tabBar)
                    .tag(tab as MIARouter.MainScreen)
                    .tabItem { tab.label }
            }
        }
        .onChange(of: router.buildingId, { _, deeplinkBuildingId in
            
            guard let deeplinkBuildingId else {
                return
            }
            
            router.showBuildingDetail(id: deeplinkBuildingId)
        })
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

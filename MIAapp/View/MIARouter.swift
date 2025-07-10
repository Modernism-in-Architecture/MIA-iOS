//
//  Router.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 19.05.24.
//

import SwiftUI
import Combine
import OSLog
import MIACoreNetworking
import MIACore

class MIARouter: ObservableObject {
    
    private var buildingsMangager = BuildingsManager()
    
    @Published
    var path = NavigationPath()
    
    @Published
    var selectedTab: MainScreen = .buildings
    
    @Published
    var buildingId: Int? = .none
    
    var deepLinkTarget: URL? = .none
    
    @Published
    private(set) var tabBarVisibility: Visibility = .visible
    
    private(set) var selectedBuildingForMap: MapItemProtocol? = .none
        
    private var subscribers = Set<AnyCancellable>()
    
    init() {
        setup()
    }
    
    func setup() {
        
        self.$path.sink { newPath in
            
            if newPath.isEmpty {
                self.showTabbar()
            }
        }
        .store(in: &subscribers)
    }
        
    enum MainScreen: Identifiable, Hashable, CaseIterable {
        
        case buildings
        case map
        case architects
        case bookmarks
        
        var id: MainScreen {
            self
        }
    }
    
    enum DetailsRoute: Hashable {
        
        case architect(id: Int)
        case building(id: Int)
        
        @ViewBuilder
        var view: some View {
            
            switch self {
            case let .architect(id):
                ArchitectDetailView(id: id)
                
            case let .building(id):
                BuildingDetailView(id: id)
            }
        }
    }
}

extension MIARouter {
    
    var deepLinkBuildingId: Int? {
        (deepLinkTarget?.lastPathComponent).flatMap { Int($0) }
    }
}

private extension MIARouter {
    
    func showTabbar() {
        
        withAnimation{
            self.tabBarVisibility = .visible
        }
    }
        
    func hideTabbar() {
        self.tabBarVisibility = .hidden
    }
}

//@MainActor
extension MIARouter {
    
    func toRoot() {
        
        showTabbar()
        while path.count > 0 {
            path.removeLast()
        }
    }
    
    func showBuildingDetail(id: Int) {
        
        hideTabbar()
        path.append(DetailsRoute.building(id: id))
    }
    
    func showArchitectDetail(id: Int) {
        
        hideTabbar()
        path.append(DetailsRoute.architect(id: id))
    }
    
    func showMap(with item: MapItemProtocol) {
        
        toRoot()
        selectedBuildingForMap = item
        selectedTab = .map
    }
    
    func checkDeepLinkTarget() {
        buildingId = deepLinkBuildingId
    }
}

// MARK: - Root Views

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var rootView: some View {
        
        switch self {
        case .buildings:
            BuildingsHomeView()
            
        case .map:
            MapHomeView()
            
        case .architects:
            ArchitectsHomeView()
            
        case .bookmarks:
            BookmarksHomeView()
        }
    }
}

// MARK: - Labels

extension MIARouter.MainScreen {
    
    @ViewBuilder
    var label: some View {
        
        switch self {
        case .buildings:
            Label("Buildings", systemImage: "building.2")
            
        case .map:
            Label("Places", systemImage: "map")
            
        case .architects:
            Label("Architects", systemImage: "person.2")
            
        case .bookmarks:
            Label("Bookmarks", systemImage: "bookmark")
        }
    }
}

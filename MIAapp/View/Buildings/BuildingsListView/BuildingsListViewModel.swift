//
//  MIADataController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import CoreLocation
import SwiftUI
import MIACore
import MIACoreNetworking

// MARK: - BuildingsListViewModel

class BuildingsListViewModel: ObservableObject {
        
    @Published
    var state: LoadingState<[Building]> = .loading

    private var buildingsMangager = BuildingsManager()
}

// MARK: - Load

extension BuildingsListViewModel {
    
    func fetch() {
        
        state = .loading
        
        Task {
            await fetch()
        }
    }
}

// MARK: - Refresh

@MainActor
extension BuildingsListViewModel {
    
    @Sendable
    func refresh() async {
        await fetch()
    }
}

// MARK: - Load Buildings

@MainActor
private extension BuildingsListViewModel {
    
    func fetch() async {
        
        do {
            
            let buildings = try await buildingsMangager.getBuildings()
            self.handle(buildings: buildings)
        } catch {
            self.handleLoadError(error: error)
        }
    }
    
    private func handle(buildings: [Building]) {
        self.state = .success(buildings)
    }
    
    private func handleLoadError(error: ManagerError) {
        self.state = .error(error)
    }
}

extension BuildingsListViewModel {
    
    func fetchBuildingFor(id: Int) async throws -> BuildingDetail {
        try await buildingsMangager.getBuildingDetail(for: id)
    }
}

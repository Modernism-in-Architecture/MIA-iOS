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
    
    private var fetchTask: Task<Void, Error>?
}

// MARK: - Load

extension BuildingsListViewModel {
    
    func fetch() {
        
        state = .loading
        
        fetchTask?.cancel()
        fetchTask = Task {
            await performFetch()
        }
    }
}

// MARK: - Refresh

extension BuildingsListViewModel {
    
    func refresh() async {
        
        fetchTask?.cancel()
        fetchTask = Task {
            await performFetch()
        }
    }
}

// MARK: - Load Buildings

@MainActor
private extension BuildingsListViewModel {
    
    func performFetch() async {
        
        do {
            
            let buildings = try await buildingsMangager.getBuildings()
            self.handle(buildings: buildings)
        } catch {
            self.handleLoadError(error: error)
        }
    }
    
    private func handle(buildings: [Building]) {
        
        if Task.isCancelled {
            return
        }
        
        self.state = .success(buildings)
    }
    
    private func handleLoadError(error: ManagerError) {
        
        if Task.isCancelled {
            return
        }
        
        self.state = .error(error)
    }
}

extension BuildingsListViewModel {
    
    func fetchBuildingFor(id: Int) async throws -> BuildingDetail {
        try await buildingsMangager.getBuildingDetail(for: id)
    }
}


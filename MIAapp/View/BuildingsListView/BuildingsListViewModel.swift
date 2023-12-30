//
//  MIADataController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import CoreLocation
import SwiftUI

// MARK: - BuildingsListViewModel

class BuildingsListViewModel: ObservableObject {
    
    @EnvironmentObject var mapController: MIAMapViewModel
    
    @Published var state: LoadingState = .loading
    @Published var buildings: [Building] = []
    
    private var buildingsMangager = BuildingsManager()
}

// MARK: - Load Buildings

@MainActor
extension BuildingsListViewModel {
    
    func fetchData() async {
        
        do {
            
            let buildings = try await buildingsMangager.getBuildings()
            self.handle(buildings: buildings)
        } catch {
            self.handleLoadError(error: error)
        }
    }
    
    private func handle(buildings: [Building]) {
        
        self.buildings = buildings
        self.state = .success
    }
    
    private func handleLoadError(error: Error) {
        // TODO: Handle correct Manager error
        self.state = .error(.NetworkError)
    }
}


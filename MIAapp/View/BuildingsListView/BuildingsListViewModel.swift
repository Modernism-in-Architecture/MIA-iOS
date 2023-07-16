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
    
    var levelContent: [MapItem] = []
    
    private let levelDistances = [0.0, 1_000.0, 5_000.0, 40_000.0, 100_000.0, 400_000.0]
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
        self.levelContent = self.buildings.map { building in
            MapItem(coordinate: building.coordinate, count: 0, level: 0, building: building)
        }
        for level in 1 ..< self.levelDistances.count {
            self.levelContent.append(contentsOf: self.createGroups(for: level))
        }
        self.state = .success
    }
    
    private func handleLoadError(error: Error) {
        // TODO: Handle correct Manager error
        self.state = .error(.NetworkError)
    }
}

// MARK: - Private Extensions
    
private extension BuildingsListViewModel {

    func getCenter(for chunk: [Building]) -> CLLocationCoordinate2D {
        let count = Double(chunk.count)
        let sum = chunk.reduce((0.0, 0.0)) { sum, building -> (Double, Double) in
            (sum.0 + building.coordinate.latitude, sum.1 + building.coordinate.longitude)
        }
        return CLLocationCoordinate2D(latitude: sum.0 / count, longitude: sum.1 / count)
    }
    
    func createGroups(for level: Int) -> [MapItem] {
        var groupedBuildings: [MapItem] = []
        var buildingsCopy = self.buildings
        while let building = buildingsCopy.first {
            var chunk: [Building] = []
            buildingsCopy.removeAll { targetBuilding in
                guard CLLocation(building.coordinate).distance(from: CLLocation(targetBuilding.coordinate)) < levelDistances[level] else { return false }
                chunk.append(targetBuilding)
                return true
            }
            groupedBuildings.append(MapItem(coordinate: self.getCenter(for: chunk), count: chunk.count, level: level, building: nil))
        }
        return groupedBuildings
    }
}

// MARK: - MapItem

struct MapItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let count: Int
    let level: Int
    let building: Building?
}

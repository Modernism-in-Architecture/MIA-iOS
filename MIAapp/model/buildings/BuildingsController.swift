//
//  MIADataController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import Foundation
import CoreLocation
import SwiftUI

class BuildingsController: ObservableObject {
    
    @EnvironmentObject var mapController: MIAMapController
    
    @Published var state: LoadingState = .loading
    @Published var buildings: [Building] = []
    @Published var levelContent: [MapItem] = []
    
    private let levelDistances = [0.0, 1000.0, 5_000.0, 40_000.0, 100_000.0, 400_000.0]
    
    func fetchData() async {
        let result = await MIAClient.fetchData(for: API.request(for: API.buildings), of: Buildings.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.buildings = data.data
                self.levelContent = self.buildings.map { building in
                    MapItem(coordinate: building.coordinate, count: 0, level: 0, building: building)
                }
                for level in 1..<self.levelDistances.count {
                    self.levelContent.append(contentsOf: self.createGroups(for: level))
                }
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    private func getCenter(for chunk: [Building]) -> CLLocationCoordinate2D {
        let count = Double(chunk.count)
        let sum = chunk.reduce((0.0, 0.0)) { (sum, building) -> (Double, Double) in
            return (sum.0 + building.coordinate.latitude, sum.1 + building.coordinate.longitude)
        }
        return CLLocationCoordinate2D(latitude: sum.0 / count, longitude: sum.1 / count)
    }
    
    private func createGroups(for level: Int) -> [MapItem] {
        var groupedBuildings: [MapItem] = []
        var buildingsCopy = buildings
        while let building = buildingsCopy.first {
            var chunk: [Building] = []
            buildingsCopy.removeAll { targetBuilding in
                guard CLLocation(building.coordinate).distance(from: CLLocation(targetBuilding.coordinate)) < levelDistances[level] else { return false }
                chunk.append(targetBuilding)
                return true
            }
            groupedBuildings.append(MapItem(coordinate: getCenter(for: chunk), count: chunk.count, level: level, building: nil))
        }
        return groupedBuildings
    }
}

struct MapItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let count: Int
    let level: Int
    let building: Building?
}

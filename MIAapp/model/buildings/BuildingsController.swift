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
    
    @Published var buildings: [Building] = []
    @Published var groupedBuildings: [groupItem] = []
    @Published var annotations: [groupItem] = []
    @Published var state: LoadingState = .loading
    
    func fetchData() async {
        let result = await MIAClient.fetchData(for: API.request(for: API.buildings), of: Buildings.self)
        DispatchQueue.main.async {
            switch result {
            case .success(let data):
                self.buildings = data.data
                let start = Date()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                self.updateGroups()
                let end = Date()
                print("Time: \(end.timeIntervalSince(start))")
                self.updateAnnotations()
                self.state = .success
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    func updateAnnotations() {
//        var annotations: [groupItem] = []
        annotations = buildings.map { building in
            return groupItem(coordinate: building.coordinate, count: 0, building: building)
        }
    }
    
    func updateGroups() {
        var groupedBuildings: [groupItem] = []
        var buildingsCopy = buildings
        while let building = buildingsCopy.first {
            var chunk: [Building] = []
            buildingsCopy.removeAll { targetBuilding in
                guard CLLocation(building.coordinate).distance(from: CLLocation(targetBuilding.coordinate)) < 1000 else { return false }
                chunk.append(targetBuilding)
                return true
            }
            groupedBuildings.append(groupItem(coordinate: building.coordinate, count: chunk.count, building: .empty))
        }
        self.groupedBuildings = groupedBuildings
    }
}
    
struct groupItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let count: Int
    let building: Building
}

protocol MapItem: Identifiable {
    var coordinate: CLLocationCoordinate2D { get }
}
    

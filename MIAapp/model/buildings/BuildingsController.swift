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
    @Published var groupedBuildings: [GroupItem] = []
    @Published var annotations: [GroupItem] = []
    @Published var state: LoadingState = .loading
//    var stuff: [MapItem] = []
    
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
        self.annotations = buildings.map { building in
            return GroupItem(coordinate: building.coordinate, count: 0, building: building)
        }
    }
    
    private func getCenter(for chunk: [Building]) -> CLLocationCoordinate2D {
        let count = Double(chunk.count)
        let sum = chunk.reduce((0.0, 0.0)) { (sum, building) -> (Double, Double) in
            return (sum.0 + building.coordinate.latitude, sum.1 + building.coordinate.longitude)
        }
        return CLLocationCoordinate2D(latitude: sum.0 / count, longitude: sum.1 / count)
    }
    
    private func updateGroups() {
        var groupedBuildings: [GroupItem] = []
        var buildingsCopy = buildings
        while let building = buildingsCopy.first {
            var chunk: [Building] = []
            buildingsCopy.removeAll { targetBuilding in
                guard CLLocation(building.coordinate).distance(from: CLLocation(targetBuilding.coordinate)) < 1000 else { return false }
                chunk.append(targetBuilding)
                return true
            }
            groupedBuildings.append(GroupItem(coordinate: getCenter(for: chunk), count: chunk.count, building: .empty))
        }
        self.groupedBuildings = groupedBuildings
    }
}
    
struct GroupItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let count: Int
    let building: Building
}

protocol MapItem {
    var id: UUID { get }
    var coordinate: CLLocationCoordinate2D { get }
}
    
//typealias MapItem = AnyMapItem & Identifiable

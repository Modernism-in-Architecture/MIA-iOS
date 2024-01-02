//
//  BuildingDetailMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 24.10.21.
//

import SwiftUI
import MapKit

struct BuildingDetailMapView: View {
    
    @State var building: Building
    
    var body: some View {
        
        Map(initialPosition: .camera(MapCamera(centerCoordinate: building.coordinate, distance: 1000))) {
            
            Annotation(
                building.name,
                coordinate: building.coordinate
            ) {
                MIAMapPinView(building: building)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    BuildingDetailMapView(building: .schunckMock)
}

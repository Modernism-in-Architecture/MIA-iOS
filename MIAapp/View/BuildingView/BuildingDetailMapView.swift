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

//struct BuildingDetailMapView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        BuildingDetailMapView(building: .schunck)
//    }
//}

#Preview {
    BuildingDetailMapView(building: .schunckMock)
}

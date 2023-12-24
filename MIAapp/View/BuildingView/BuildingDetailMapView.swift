//
//  BuildingDetailMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 24.10.21.
//

import SwiftUI
import MapKit

struct BuildingDetailMapView: View {
    
    @State var item: Building
    @State var region: MKCoordinateRegion
    
    var body: some View {
        
        Map {
            Annotation(
                item.name,
                coordinate: item.coordinate
            ) {
                MIAMapPinView(building: item)
            }
        }
    }
}

//struct MIADetailMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIADetailMapView()
//    }
//}

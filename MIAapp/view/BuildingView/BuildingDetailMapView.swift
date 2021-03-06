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
        
        Map(coordinateRegion: $region, annotationItems: [item]) {_ in
            MapAnnotation(
                coordinate: item.coordinate,
                anchorPoint: CGPoint(x: 0.5, y: 0.5)
            ) {
                MIAMapPinView()
            }
        }
    }
}

//struct MIADetailMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIADetailMapView()
//    }
//}

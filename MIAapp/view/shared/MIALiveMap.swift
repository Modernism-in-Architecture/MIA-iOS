//
//  MIALiveMap.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 15.04.23.
//

import MapKit
import SwiftUI

struct MIALiveMap: View {
    @State var focusedBuilding: Building = .empty

    var body: some View {
        return Map(
            coordinateRegion: .constant(MKCoordinateRegion(center: focusedBuilding.coordinate,
                                                           span: .previewSpan)),
            annotationItems: [focusedBuilding]
        ) { building in
            MapAnnotation(coordinate: building.coordinate) {
                MIAMapImagePinView(url: building.feedImage)
            }
        }
        .frame(height: 160)
    }
}

struct MIALiveMap_Previews: PreviewProvider {
    static var previews: some View {
        MIALiveMap()
    }
}

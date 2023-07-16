//
//  MIAMapPinView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.10.21.
//

import SwiftUI

struct MIAMapPinView: View {
    
    let zoomLevel: Int
    let mapItem: MapItem
    
    var diameter: CGFloat { 36 + 2 * CGFloat(zoomLevel) }
    var fontSize: CGFloat { CGFloat(20 + zoomLevel) }
    var strokeSize: CGFloat { CGFloat(3 + zoomLevel) }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.green, lineWidth: strokeSize)
            Circle()
                .fill(.background)
            if zoomLevel == 0 {
                Text(Image(systemName: "building.2.fill"))
            } else {
                Text("\(mapItem.count)")
                    .font(.system(size: fontSize))
            }
        }
        .frame(width: diameter, height: diameter)
    }
}

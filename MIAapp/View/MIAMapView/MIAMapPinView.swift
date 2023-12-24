//
//  MIAMapPinView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.10.21.
//

import SwiftUI

struct MIAMapPinView: View {
    
    let building: Building
    
    var diameter: CGFloat = 36
    var fontSize: CGFloat = 20
    var strokeSize: CGFloat = 3
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(.green, lineWidth: strokeSize)
            Circle()
                .fill(.background)
            Text(Image(systemName: "building.2.fill"))
        }
        .frame(width: diameter, height: diameter)
    }
}

//
//  MIAMapPinView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.10.21.
//

import SwiftUI

struct MIAMapPinView: View {
    
    let building: Building
    
    var showShadow = false
    
    var diameter: CGFloat = 36
    var fontSize: CGFloat = 20
    var strokeSize: CGFloat = 1.5
    
    var body: some View {
        
        ZStack {
            
            MIAAsyncImageView(building.previewImage)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color(.imageCircle), lineWidth: strokeSize))
                .shadow(radius: showShadow ? 5 : 0)
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    MIAMapPinView(building: .schunckMock)
}

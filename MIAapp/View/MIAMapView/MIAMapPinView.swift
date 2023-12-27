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
    var strokeSize: CGFloat = 1
    
    var body: some View {
        
        ZStack {
            
            MIAAsyncImageView(building.feedImage)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .overlay(Circle().stroke(Color(.imageCircle), lineWidth: strokeSize))
                .shadow(radius: 3)
        }
        .frame(width: diameter, height: diameter)
    }
}

#Preview {
    MIAMapPinView(building: .schunck)
}

//
//  MIAMapPinView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.10.21.
//

import SwiftUI

struct MIAMapPinView: View {
    
    let diameter: CGFloat = 36
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green, lineWidth: 3)
            Circle()
                .fill(.background)
            Text(Image(systemName: "building.2.fill"))
        }
        .frame(width: diameter, height: diameter)
    }
}

struct MIAMapPinView_Previews: PreviewProvider {
    static var previews: some View {
        MIAMapPinView()
    }
}

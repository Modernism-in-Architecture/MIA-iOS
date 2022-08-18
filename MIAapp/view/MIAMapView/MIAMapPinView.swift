//
//  MIAMapPinView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.10.21.
//

import SwiftUI

struct MIAMapPinView: View {
    
    let diameter: CGFloat = 36
    let color: Color

    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, lineWidth: 3)
            Circle()
                .fill(.background)
            Text(Image(systemName: "building.2.fill"))
        }
        .frame(width: diameter, height: diameter)
    }
}

struct MIAMapGroupPinView: View {
    let diameter: CGFloat = 33
    let value: Int
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .stroke(.green, lineWidth: 3)
            Circle()
                .fill(.background)
            Text("\(value)")
//                .foregroundColor(.white)
                .font(.system(size: 20))
                .bold()
                .offset(x: -0.5)
        }
        .frame(width: diameter, height: diameter)
    }
}

//struct MIAMapPinView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAMapPinView(color: .green)
//    }
//}

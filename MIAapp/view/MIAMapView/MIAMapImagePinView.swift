//
//  MIAMapImagePinView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 12.04.23.
//

import SwiftUI

struct MIAMapImagePinView: View {
    
    let url: URL
    
    private let strokeSize = 2.0
    private let diameter = 40.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.gray, lineWidth: strokeSize)
            Circle()
                .overlay {
                    MIAImageView(url)
                }
                .clipShape(Circle())
        }
        .frame(width: diameter, height: diameter)
    }
}

struct MIAMapImagePinView_Previews: PreviewProvider {
    static var previews: some View {
        MIAMapImagePinView(url: URL(string: "https://picsum.photos/200/300")!)
    }
}

//
//  MIATabGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 13.11.21.
//

import SwiftUI

struct MIATabGalleryView: View {
    var body: some View {
        TabView {
            ForEach(1..<15) { index in
                MIASingleImageView(index: index)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}

struct MIASingleImageView: View {
    
    let index: Int
    @State var currentScale: CGFloat = 1.0
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        Rectangle()
            .overlay {
                Image("\(index)")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(currentScale * scale)
                    .gesture(
                        MagnificationGesture()
                            .updating($scale, body: { (value, scale, transaction) in
                                scale = value.magnitude
                            })
                            .onEnded{ self.currentScale = max(self.currentScale * $0, 1.0) }
                    )
            }
            .clipped()
    }
}

//struct MIATabGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIATabGalleryView()
//    }
//}

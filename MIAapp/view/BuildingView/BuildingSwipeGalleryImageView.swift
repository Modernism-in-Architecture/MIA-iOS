//
//  BuildingSwipeGalleryImageView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 29.05.22.
//

import SwiftUI

struct BuildingSwipeGalleryImageView: View {
    
    @State var galleryImage: URL
    @State var currentScale: CGFloat = 1.0
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        Color.black
            .overlay {
                MIAImageView(galleryImage, background: Color.black)
                    .scaledToFit()
                    .scaleEffect(currentScale * scale)
                    .gesture(
                        MagnificationGesture()
                            .updating($scale, body: { (value, scale, transaction) in
                                scale = value.magnitude
                            })
                            .onEnded{ self.currentScale = max(self.currentScale * $0, 0.25) }
                    )
                    .onTapGesture(count: 2) {
                        self.currentScale = 1.0
                    }
            }
            .clipped()
    }
}

//struct BuildingSwipeGalleryImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingSwipeGalleryImageView()
//    }
//}

//
//  BuildingSwipeGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 13.11.21.
//

import SwiftUI

struct BuildingSwipeGalleryView: View {
    
//    @ObservedObject var detailController: BuildingDetailController
//    @State var tabbedImage: URL
    @State var images: [URL]
    @State var selection: URL
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            TabView(selection: $selection) {
//                ForEach(detailController.detail.galleryImages) { galleryImage in
                ForEach(images) { galleryImage in

                    MIADetailSwipeGalleryImageView(galleryImage: galleryImage)
                        .id(galleryImage.id)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            VStack(alignment: .trailing) {
                Button(action: {
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("schließen")
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                .foregroundColor(.primary)
                .padding([.top, .trailing])

                Spacer()
            }
            .padding()
        }
    }
}

struct MIADetailSwipeGalleryImageView: View {
    
    @State var galleryImage: URL
    @State var currentScale: CGFloat = 1.0
    @GestureState var scale: CGFloat = 1.0
    
    var body: some View {
        Rectangle()
            .overlay {
                MIAAsyncImage(url: galleryImage)
//                    .resizable()
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

//struct MIADetailSwipeGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingSwipeGalleryView()
//    }
//}

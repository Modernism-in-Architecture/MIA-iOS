//
//  BuildingSwipeGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 13.11.21.
//

import SwiftUI

struct BuildingSwipeGalleryView: View {
    
    @State var images: [URL]
    @State var selection: URL
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Color.black
                .ignoresSafeArea()
            TabView(selection: $selection) {
                ForEach(images) { galleryImage in
                    BuildingSwipeGalleryImageView(galleryImage: galleryImage)
                        .id(galleryImage.id)
                }
            }
            .tabViewStyle(.page)
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            VStack(alignment: .trailing) {
                closeButton
                Spacer()
            }
            .padding()
        }
    }
    
    var closeButton: some View {
        Button(action: close) {
            Text("\(Image(systemName: "xmark")) close")
                .foregroundColor(.closeButtonForeground)
                .font(.footnote)
                .padding(8)

        }
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: .infinity))
        .buttonStyle(.plain)
        .padding([.top, .trailing])
    }
    
    func close() {
        self.presentation.wrappedValue.dismiss()
    }
    
}

//// TODO: extra File
//struct MIADetailSwipeGalleryImageView: View {
//
//    @State var galleryImage: URL
//    @State var currentScale: CGFloat = 1.0
//    @GestureState var scale: CGFloat = 1.0
//
//    var body: some View {
//        Color.background
//            .overlay {
//                MIAAsyncImage(url: galleryImage)
//                    .scaledToFill()
//                    .scaleEffect(currentScale * scale)
//                    .gesture(
//                        MagnificationGesture()
//                            .updating($scale, body: { (value, scale, transaction) in
//                                scale = value.magnitude
//                            })
//                            .onEnded{ self.currentScale = max(self.currentScale * $0, 0.25) }
//                    )
//                    .onTapGesture(count: 2) {
//                        self.currentScale = 1.0
//                    }
//            }
//            .clipped()
//    }
//}

//struct MIADetailSwipeGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingSwipeGalleryView()
//    }
//}

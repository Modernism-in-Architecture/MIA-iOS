//
//  BuildingDetailGridGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import SwiftUI

struct BuildingDetailGridGalleryView: View {
    
//    @ObservedObject var detailController: BuildingDetailController
//    @State var tabbedGalleryImage: BuildingDetail.GalleryImage?
    @State var images: [URL]
    @State var tabbedImage: URL?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], spacing: 10) {
//            ForEach(detailController.detail.galleryImages) { galleryImage in
            ForEach(images) { image in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fill)
                    .overlay {
                        MIAAsyncImage(url: image)
                    }
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .shadow, radius: 3, x: 2, y: 2)
                    .onTapGesture {
                        tabbedImage = image
                    }
                    .fullScreenCover(item: $tabbedImage, onDismiss: {}, content: { galleryImage in
//                        BuildingGalleryImageView(galleryImage: galleryImage)
//                        MIADetailSwipeGalleryView(detailController: self.detailController, tabbedImage: galleryImage, selection: galleryImage)
                        BuildingSwipeGalleryView(images: images, selection: galleryImage)
                    })
            }
        }
    }
}



//struct MIADetailGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIADetailGalleryView()
//    }
//}

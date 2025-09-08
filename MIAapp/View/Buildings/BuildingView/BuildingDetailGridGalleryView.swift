//
//  BuildingDetailGridGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import SwiftUI
import MIACore
import MIACoreUI

struct BuildingDetailGridGalleryView: View {
    
    @State
    var identifiableImageUrls: [IdentifiableURL]
    
    @State
    var tabbedImage: IdentifiableURL?
    
    var body: some View {
        
        LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], spacing: 10) {
            
            // TODO: separate Cell View
            ForEach(identifiableImageUrls) { imageUrl in
                
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fill)
                    .overlay {
                        MIAAsyncImageView(imageUrl, background: .background)
                    }
                    .mask(RoundedRectangle(cornerRadius: 10))
                    .shadow(color: .shadow, radius: 3, x: 2, y: 2)
                    .onTapGesture {
                        tabbedImage = imageUrl
                    }
            }
        }
        .fullScreenCover(item: $tabbedImage, onDismiss: {}, content: { imageUrl in
            BuildingSwipeGalleryView(imageUrls: identifiableImageUrls, selection: imageUrl.url)
        })
    }
}

//struct MIADetailGalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        MIADetailGalleryView()
//    }
//}

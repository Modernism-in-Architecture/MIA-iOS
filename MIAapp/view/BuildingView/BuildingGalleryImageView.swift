//
//  BuildingGalleryImageView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 26.10.21.
//

import SwiftUI

struct BuildingGalleryImageView: View {
    
//    @State var galleryImage: BuildingDetail.GalleryImage
    @State var galleryImage: URL
    @State var showInfo = false
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .overlay(
//                    MIAAsyncImage(url: galleryImage.value.image.large.src)
                    MIAAsyncImage(url: galleryImage)
                )
                .clipped()
                .ignoresSafeArea()
            
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
                
//                if !showInfo {
//                    HStack(alignment: .bottom, spacing: 10) {
//                        Spacer()
//                        Button(action: {
//                            withAnimation {
//                                showInfo.toggle()
//                            }
//                        }) {
//                            Image(systemName: "info.circle.fill")
//                                .font(.title)
//                                .foregroundColor(.primary)
//                        }
//                    }
//                    .padding()
//                } else {
//                    HStack(alignment: .top, spacing: 10) {
//                        Text(galleryImage.value.description)
//                            .layoutPriority(1)
//                        Spacer()
//                        Button(action: {
//                            withAnimation{
//                                showInfo.toggle()
//                            }
//                        }) {
//                            Image(systemName: "xmark.circle.fill")
//                                .font(.title)
//                                .foregroundColor(.secondary)
//                        }
//                    }
//                    .padding()
//                    .tint(.secondary)
//                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
//                }
            }
            .padding()
        }
    }
}

//struct MIAGalleryImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingGalleryImageView()
//    }
//}

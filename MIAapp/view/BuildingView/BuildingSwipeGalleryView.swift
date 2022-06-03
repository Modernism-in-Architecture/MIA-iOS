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
            Text("\(Image(systemName: "xmark")) Close")
                .foregroundColor(.closeButtonForeground)
                .font(.subheadline)
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

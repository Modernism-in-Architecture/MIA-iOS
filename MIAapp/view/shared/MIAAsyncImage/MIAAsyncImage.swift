//
//  MIAAsyncImage.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 12.04.23.
//

import SwiftUI

struct MIAAsyncImage: View {
    
    @StateObject private var imageViewModel = MIAAsyncImageViewModel()
    let url: URL
    let background: Color
    
    init(_ url: URL, background: Color = Color.background) {
        self.url = url
        self.background = background
    }
    
    var body: some View {
        VStack {
            switch imageViewModel.loadingState {
            case .loading:
                background
                MIAActivityIndicator()
                    .scaleEffect(0.5)
            case .error(_):
                ImageErrorView(height: 80)
            case .success(let image):
                background
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
            }
        }
        .task {
            await imageViewModel.fetchImage(from: url)
        }
    }
}

struct ImageErrorView: View {
    
    let height: CGFloat
    
    var width: CGFloat { height * 1.4 }
    var fontSize: CGFloat { height / 8 }
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: height/2)
            Text("No image found")
                .font(.system(size: fontSize))
                .textCase(.uppercase)
            Spacer()
        }
        .opacity(0.4)
        .aspectRatio(contentMode: .fit)
        .frame(width: width, height: height)
    }
}

//struct MIAAsyncImage_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAAsyncImage()
//    }
//}

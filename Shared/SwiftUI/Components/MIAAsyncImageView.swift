//
//  MIAAsyncImageView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 04.07.23.
//

import SwiftUI

struct MIAAsyncImageView: View {
    
    @StateObject private var imageViewModel = MIAAsyncImageViewModel()
    let url: URL
    let background: Color

    init(_ url: URL, background: Color = Color.background) {
        self.url = url
        self.background = background
    }

    var body: some View {
        
        background
            .overlay {
            
                switch imageViewModel.loadingState {
                case .loading:
                    
                    MIAActivityIndicator()
                        .scaleEffect(0.5)
                    
                    
                case .error(_):
                    ImageErrorView(height: 80)
                    
                case .success(let image):
                    
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


#Preview {
    
    VStack {
        
//        MIAAsyncImageView(.image1MockUrl)
        MIAAsyncImageView(URL(string: "https://loremflickr.com/640/360")!)
        
        MIAAsyncImageView(URL(string: "noimage")!)

        MIAAsyncImageView(URL(string: "https://loremflickr.com/640/360")!)
    }
}

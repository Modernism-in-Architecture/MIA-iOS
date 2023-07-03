//
//  MIAAsyncImage.swift
//  MIAapp
//
//  Created by Sören Kirchner on 25.10.21.
//

import SwiftUI

struct MIAImageView: View {
    
    let url: URL
    let background: Color
    
    internal init(_ url: URL, background: Color = Color.background) {
        self.url = url
        self.background = background
    }
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                background
                MIAActivityIndicator()
                    .scaleEffect(0.5)
            case .success(let image):
                background
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.opacity.animation(.easeInOut(duration: 0.3)))
            case .failure:
                Image("error")
                    .resizable()
                    .scaledToFill()
            @unknown default:
                EmptyView()
            }
        }
    }
}

//struct MIAAsyncImage_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAAsyncImage()
//    }
//}

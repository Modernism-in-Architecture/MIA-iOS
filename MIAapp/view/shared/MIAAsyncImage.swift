//
//  MIAAsyncImage.swift
//  MIAapp
//
//  Created by Sören Kirchner on 25.10.21.
//

import SwiftUI

struct MIAAsyncImage: View {
    
    @State var url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Color.background
//                ProgressView()
//                    .scaleEffect(1.5, anchor: .center)
//                    .tint(.secondary)
                MIAActivityIndicator()
                    .scaleEffect(0.5)
            case .success(let image):
                Color.background
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

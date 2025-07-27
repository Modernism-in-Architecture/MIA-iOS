//
//  MIAAsyncImageView.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 04.07.23.
//

import SwiftUI
import MIACore

// MARK: - MIAAsyncImageView

public struct MIAAsyncImageView: View {
    
    @StateObject
    private var imageViewModel = MIAAsyncImageViewModel()
    
    let url: URL?
    let background: Color

    public init(_ url: URL?, background: Color) {
        
        self.url = url
        self.background = background
    }

    public var body: some View {
        
        background
            .overlay {
                foreground
            }
            .task {
                await imageViewModel.fetchImage(from: url)
            }
    }
}

extension MIAAsyncImageView {
    
    public init(_ identifiableURL: IdentifiableURL?, background: Color) {
        
        self.url = identifiableURL?.url
        self.background = background
    }
}

private extension MIAAsyncImageView {
    
    @ViewBuilder
    var foreground: some View {
        
        switch imageViewModel.loadingState {
            
        case .loading:
            MIAActivityIndicator()
                .scaleEffect(0.5)
            
        case .error:
            MIAImageErrorView(height: 80)
            
        case .success(let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .transition(.opacity.animation(.easeInOut(duration: 0.3)))
        }
    }
}



#Preview {
    
    VStack {
        
//        MIAAsyncImageView(.image1MockUrl)
        MIAAsyncImageView(URL(string: "https://loremflickr.com/640/360"), background: .pink)
        MIAAsyncImageView(URL(string: "noimage"), background: .blue)
        MIAAsyncImageView(URL(string: "https://loremflickr.com/640/360"), background: .red)
    }
}

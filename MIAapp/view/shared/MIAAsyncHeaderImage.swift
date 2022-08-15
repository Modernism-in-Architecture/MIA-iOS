//
//  MIAAsyncHeaderImage.swift
//  MIAapp
//
//  Created by Sören Kirchner on 28.05.22.
//

import SwiftUI

struct MIAAsyncHeaderImage: View {
    
    let url: URL
    
    var body: some View {
        Rectangle()
            .aspectRatio(1.3, contentMode: .fill)
            .overlay{
                MIAAsyncImage(url)
            }
            .clipped()
    }
}

//struct MIAAsyncHeaderImage_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAAsyncHeaderImage()
//    }
//}

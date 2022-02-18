//
//  TestGalleryView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 24.10.21.
//

import SwiftUI

struct TestGalleryView: View {
    
    private var grid = [GridItem(.adaptive(minimum: 180, maximum: 250))]
    
    var body: some View {
        ScrollView {
//            LazyVGrid(columns: [GridItem(spacing: 10), GridItem()], spacing: 10) {
            LazyVGrid(columns: grid, spacing: 10) {
                ForEach(1..<13) { index in
                    ZStack(alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 10)
                            .aspectRatio(1, contentMode: .fill)
                            .overlay {
//                                Image("\(index)")
//                                    .resizable()
//                                    .scaledToFill()
                                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1635058157301-b69bb0b08c83?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=4472&q=80")!) { phase in
                                    switch phase {
                                    case .empty:
                                        ZStack(alignment: .center) {
                                            Image("3")
                                                .resizable()
                                                .scaledToFill()
                                            ProgressView()
//                                                .frame(width: 40, height: 40)
                                                .scaleEffect(1.5, anchor: .center)
                                                .tint(.white)
                                        }
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    case .failure:
                                        Image("1")
                                            .resizable()
                                            .scaledToFill()
                                    @unknown default:
                                        EmptyView()
                                    }
                                    
                                }
                            }
                        
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .shadow, radius: 3, x: 2, y: 2)
                    }
                }
            }.padding(10)
        }
        
    }
}

struct TestGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestGalleryView()
.previewInterfaceOrientation(.portraitUpsideDown)
            TestGalleryView()
                .previewDevice("iPad mini (6th generation)")
.previewInterfaceOrientation(.landscapeLeft)
        }
    }
}

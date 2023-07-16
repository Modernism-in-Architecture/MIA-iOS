//
//  SectionIndexView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import SwiftUI

struct MIASectionIndexView: View {
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    let scrollViewProxy: ScrollViewProxy
    
    @State var keys: [String]
    @State var currentIndex: Int = 0
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                ForEach (keys, id: \.self) { key in
                    VStack {
                        Text("\(key)")
                            .foregroundColor(.blue)
                            .font(.footnote)
                            .padding(.leading, 30)
                            .padding(.trailing, 5)
                    }
                }
            }
            .overlay(
                GeometryReader { geometry in
                    Color.white
                        .opacity(0.001)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    updateScrollView(value: value, geometry: geometry)
                                }
                                .onEnded { value in
                                    updateScrollView(value: value, geometry: geometry)
                                }
                        )
                }
            )
        }
    }
        
    private func updateScrollView(value: DragGesture.Value, geometry: GeometryProxy) {
        let region = (value.startLocation.y + value.translation.height) / ( geometry.size.height )
        let newIndex = max(0, min(Int(region * CGFloat(keys.count)), keys.count - 1))
        if newIndex != currentIndex {
            currentIndex = newIndex
            moveTo(key: keys[currentIndex])
        }
    }
    
    private func moveTo(key: String) {
        scrollViewProxy.scrollTo(key, anchor: .top)
        generator.impactOccurred()
    }
}

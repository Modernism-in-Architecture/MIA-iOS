//
//  MIAFoldableText.swift
//  MIAapp
//
//  Created by Sören Kirchner on 10.02.22.
//

import SwiftUI

public struct MIAFoldableText: View {
    
    @State
    private var showLongVersion: Bool
    
    let text: AttributedString
    
    var shortLimit = 5
    
    public init(
        showLongVersion: Bool = false,
        text: AttributedString,
        shortLimit: Int = 5
    ) {
        self.showLongVersion = showLongVersion
        self.text = text
        self.shortLimit = shortLimit
    }
    
    public var body: some View {
        
        Text(text)
            .lineLimit(showLongVersion ? .none : shortLimit)
            .onTapGesture {
                
                withAnimation {
                    showLongVersion.toggle()
                }
            }
    }
}

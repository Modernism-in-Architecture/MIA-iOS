//
//  MIASection.swift
//  MIAapp
//
//  Created by Sören Kirchner on 10.02.22.
//

import SwiftUI

struct MIASection <Content: View>: View {
    
    let title: String
    let showContent: Bool
    var content: Content
    
    init(_ title: String, ignoreIf: Bool = false, @ViewBuilder content: () -> Content) {
        
        self.content = content()
        self.title = title
        self.showContent = !ignoreIf
    }
    
    var body: some View {
        
        if showContent {
            
            bodyContent
                .padding(.bottom, 20)
        }
    }
    
    var bodyContent: some View {
        
        VStack(alignment: .leading) {
            
            Text(title.uppercased()).font(.caption).foregroundColor(.secondary)
            Divider()
            VStack(alignment: .leading) {
                content
            }
        }
    }
}

// MARK: - Preview

#Preview {
    
    MIASection("Section Title", ignoreIf: false) {
        Text("Section Content")
    }
    .padding()
}


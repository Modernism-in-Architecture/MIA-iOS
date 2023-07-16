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
            VStack(alignment: .leading) {
                Text(title.uppercased()).font(.caption).foregroundColor(.secondary)
                Divider()
                VStack(alignment: .leading) {
                    content
                }
            }
            .padding(.bottom, 20)
        }
    }
}

//struct MIASection_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MIASection("Hallo") {
//                Text("Das ist mein ")
//            }
//            .padding()
//        }
//    }
//}


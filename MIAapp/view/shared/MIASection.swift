//
//  MIASection.swift
//  MIAapp
//
//  Created by Sören Kirchner on 10.02.22.
//

import SwiftUI

struct MIASection <Content: View>: View {
    
    let title: String
    var content: Content
    
    init(_ title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
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


//
//  MIAFoldableText.swift
//  MIAapp
//
//  Created by Sören Kirchner on 10.02.22.
//

import SwiftUI

struct MIAFoldableText: View {
    
    let text: AttributedString
    var shortLimit = 5
    @State private var showLongVersion = false
    
    var body: some View {
        Text(text)
            .lineLimit(showLongVersion ? .none : shortLimit)
            .onTapGesture {
                withAnimation {
                    showLongVersion.toggle()
                }
            }
    }
}

//struct MIAFoldableText_Previews: PreviewProvider {
//    static var previews: some View {
//        MIAFoldableText()
//    }
//}

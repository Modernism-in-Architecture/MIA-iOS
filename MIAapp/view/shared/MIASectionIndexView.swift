//
//  SectionIndexView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import SwiftUI

struct MIASectionIndexView: View {
    
    @State var index: [String]
    let proxy: ScrollViewProxy
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing:1) {
                ForEach(index, id:\.self) { key in
                    Button(action: {
                        withAnimation {
                            proxy.scrollTo(key, anchor: .top)
                        }
                    }) {
                        Text("\(key)")
                            .font(.footnote)
                            .padding(.leading, 30)
                            .padding(.trailing, 5)
                    }
                }
            }
        }
    }
}

//
//  MIASearchButton.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

struct MIASearchButton: View {
    
    @Binding var isSearching: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isSearching.toggle()
            }
        }, label: {
            Image(systemName: "magnifyingglass")
        })
    }
}

//
//  MIASearchBar.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

struct MIASearchBar: View {
    
    @Binding var text: String
    @Binding var isSearching: Bool
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $text)
                    .focused($isFocused)
                    .disableAutocorrection(true)
                if !text.isEmpty {
                    Image(systemName: "xmark.circle.fill")
                        .onTapGesture {
                            text = ""
                        }
                }
                
            }
            .padding(7)
            .background(Color(.systemFill))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.systemFill), lineWidth: 1)
            )
            Button("Cancel", action: {
                text = ""
                withAnimation {
                    isFocused = false
                    isSearching.toggle()
                }
            })
        }
        .padding()
        .onAppear() {
            isFocused = true
        }
    }
}


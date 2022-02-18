//
//  LoadingActivityView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import SwiftUI

struct LoadingActivityView: View {
    var body: some View {
        VStack {
//            MIAActivityIndicator()
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("loading …")
                .foregroundColor(.secondary)
        }
    }
}

struct LoadingActivityView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingActivityView()
    }
}

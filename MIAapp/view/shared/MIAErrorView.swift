//
//  MIAErrorView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

struct MIAErrorView: View {
    
    @State var error: ManagerError
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            switch error {
            case .networkError:
                Image(systemName: "wifi.exclamationmark")
                    .font(.largeTitle)
                Text("Network Error")
                    .font(.headline)
                Text("The server is not reachable.\nPlease try again later!")
                    .multilineTextAlignment(.center)
            case .unknownError:
                Image(systemName: "exclamationmark.octagon")
                    .font(.largeTitle)
                Text("Unknown Error occured")
                    .font(.headline)
                Text("We are sorry!")
            case .notImplementedError:
                #warning(".notImplementedError Needs to be removed")
                EmptyView()
            }
        }
    }
}

struct MIAErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MIAErrorView(error: .networkError)
                .preferredColorScheme(.dark)
            MIAErrorView(error: .networkError)
        }
        MIAErrorView(error: .unknownError)
            .preferredColorScheme(.dark)
    }
}

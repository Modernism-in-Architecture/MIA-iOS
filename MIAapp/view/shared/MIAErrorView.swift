//
//  MIAErrorView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI

struct MIAErrorView: View {
    
    @State var error: MiaClientError
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            switch error {
            case .NetworkError:
                Image(systemName: "wifi.exclamationmark")
                    .font(.largeTitle)
                Text("Network Error")
                    .font(.headline)
                Text("The server is not reachable.\nPlease try again later!")
                    .multilineTextAlignment(.center)
            case .UnknownError:
                Image(systemName: "exclamationmark.octagon")
                    .font(.largeTitle)
                Text("Unknown Error occured")
                    .font(.headline)
                Text("We are sorry!")
            }
        }
    }
}

struct MIAErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MIAErrorView(error: .NetworkError)
                .preferredColorScheme(.dark)
            MIAErrorView(error: .NetworkError)
        }
        MIAErrorView(error: .UnknownError)
            .preferredColorScheme(.dark)
    }
}

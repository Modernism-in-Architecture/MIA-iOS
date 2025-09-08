//
//  MIAErrorView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 14.02.22.
//

import SwiftUI
import MIACoreNetworking

public struct MIAErrorView: View {
    
    @State
    var error: ManagerError
    
    public init(error: ManagerError) {
        self.error = error
    }
    
    public var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            switch error {
                
            case .networkError:
                networkError
                
            case .unknownError:
                unknownError
            }
        }
    }
}

// MARK: - Views

extension MIAErrorView {
    
    var networkError: some View {
        
        VStack(spacing: .zero) {
            
            Image(systemName: "wifi.exclamationmark")
                .font(.largeTitle)
            Text("Network Error")
                .font(.headline)
            Text("The server is not reachable.\nPlease try again later!")
                .multilineTextAlignment(.center)
        }
    }
    
    var unknownError: some View {
        
        VStack(spacing: .zero) {
            
            Image(systemName: "exclamationmark.octagon")
                .font(.largeTitle)
            Text("Unknown Error occured")
                .font(.headline)
            Text("We are sorry!")
        }
    }
}

// MARK: - Preview

#Preview("Network Error") {
    
    MIAErrorView(error: .networkError)
    MIAErrorView(error: .networkError)
        .preferredColorScheme(.dark)
}

#Preview("Unknown Error") {
    
    MIAErrorView(error: .unknownError)
    MIAErrorView(error: .unknownError)
        .preferredColorScheme(.dark)
}

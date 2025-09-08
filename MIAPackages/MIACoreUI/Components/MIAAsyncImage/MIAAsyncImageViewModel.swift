//
//  MIAAsyncImageViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 04.07.23.
//

import MIACoreNetworking
import OSLog
import SwiftUI

// MARK: - MIAAsyncImageViewModel

@MainActor
public class MIAAsyncImageViewModel: ObservableObject {

    @Published
    var loadingState: LoadingState<UIImage> = .loading
}

extension MIAAsyncImageViewModel {
    
    func fetchImage(from url: URL?) async {
        
        let result = await MIAClient.downloadImage(from: url)
        await handle(result: result, url: url)
    }
    
    func handle(result: Result<UIImage, ClientError>, url: URL?) async {
        
        switch result {
        case .success(let image):
            loadingState = .success(image)

        case let .failure(error):
            Logger.client.error("\(error.localizedDescription) for url: \(url?.debugDescription ?? "")")
            loadingState = .error(.unknownError)
        }
    }
}

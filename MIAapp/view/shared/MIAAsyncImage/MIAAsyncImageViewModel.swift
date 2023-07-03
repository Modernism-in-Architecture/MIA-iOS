//
//  MIAAsyncImageViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 13.04.23.
//

import Foundation
import SwiftUI

class MIAAsyncImageViewModel: ObservableObject {
    
    @Published var loadingState: LoadingStateWithContent<UIImage> = .loading
//    let api: APIProtocol
//    
//    init(api: APIProtocol = API())  {
//        self.api = api
//    }
    
    func fetchImage(from url: URL?) async {
        guard let url = url else {
            await MainActor.run { [weak self] in
                self?.loadingState = .error(MiaClientError.UnknownError)
            }
            return
        }
        let result = await MIAClient.downloadImage(from: url)
        await MainActor.run { [weak self] in
            switch result {
            case .success(let image):
                withAnimation {
                    self?.loadingState = .success(image)
                }
            case .failure:
                self?.loadingState = .error(MiaClientError.UnknownError)
            }
        }
    }
}

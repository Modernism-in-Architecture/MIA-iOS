//
//  MIAAsyncImageViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 04.07.23.
//

import SwiftUI

class MIAAsyncImageViewModel: ObservableObject {

    @Published var loadingState: LoadingStateWithContent<UIImage> = .loading
    
    func fetchImage(from url: URL?) async {
        
        guard let url else {
            
            await MainActor.run { [weak self] in
                self?.loadingState = .error(.unknownError)
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
                self?.loadingState = .error(.unknownError)
            }
        }
    }
}

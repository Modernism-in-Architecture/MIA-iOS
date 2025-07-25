//
//  ArchitectsListViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import Foundation
import MIACore
import MIACoreNetworking

class ArchitectsListViewModel: ObservableObject {
    
    @Published
    var architects: [Architect] = []
    
    @Published
    var state: LoadingState = .loading
    
    private var architectsManager = ArchitectsManager()
}

extension ArchitectsListViewModel {
    
    func fetch() {
        
        self.state = .loading
        
        Task {
            await fetch()
        }
    }
}

@MainActor
extension ArchitectsListViewModel {
    
    func refresh() async {
        await fetch()
    }
}

@MainActor
private extension ArchitectsListViewModel {
    
    func fetch() async {
        
        do {
            
            let architects = try await architectsManager.getArchitects()
            handle(architects: architects)
        } catch {
            handleLoadError(error: error)
        }
    }
    
    private func handle(architects: [Architect]) {
        
        self.architects = architects
        self.state = .success
    }
    
    private func handleLoadError(error: Error) {
        
        // TODO: Handle correct Manager error
        self.state = .error(.networkError)
    }
}

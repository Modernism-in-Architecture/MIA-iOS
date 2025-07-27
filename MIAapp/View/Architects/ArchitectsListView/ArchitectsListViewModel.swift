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
    var state: LoadingState<[Architect]> = .loading
    
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
    
    @Sendable
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
        self.state = .success(architects)
    }
    
    private func handleLoadError(error: ManagerError) {
        self.state = .error(error)
    }
}

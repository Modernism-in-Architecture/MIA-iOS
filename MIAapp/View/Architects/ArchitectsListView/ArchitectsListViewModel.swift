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
    
    private var fetchTask: Task<Void, Error>?
}

extension ArchitectsListViewModel {
    
    func fetch() {
        
        self.state = .loading
        
        fetchTask?.cancel()
        fetchTask = Task {
            await fetch()
        }
    }
}

extension ArchitectsListViewModel {
    
    func refresh() async {
        
        fetchTask?.cancel()
        fetchTask = Task {
            await fetch()
        }
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
        
        if Task.isCancelled {
            return
        }
        
        self.state = .success(architects)
    }
    
    private func handleLoadError(error: ManagerError) {
        
        if Task.isCancelled {
            return
        }
        
        self.state = .error(error)
    }
}

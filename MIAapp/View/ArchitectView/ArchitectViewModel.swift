//
//  ArchitectViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import Foundation

class ArchitectViewModel: ObservableObject {
    
    @Published var architectDetail: LoadingStateWithContent<ArchitectDetail> = .loading
    
    private var architectsManager = ArchitectsManager()
}
    
@MainActor
extension ArchitectViewModel {
    
    func fetchData(for id: Int) async {
        do {
            let detail = try await architectsManager.getArchitectDetail(for: id)
            handle(detail: detail)
        } catch let error as ManagerError {
            handleLoadError(error: error)
        } catch {
            handleLoadError(error: .unknownError)
        }
    }
    
    private func handle(detail: ArchitectDetail) {
        self.architectDetail = .success(detail)
    }
    
    private func handleLoadError(error: ManagerError) {
        self.architectDetail = .error(error)
    }
}

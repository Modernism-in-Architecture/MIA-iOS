//
//  BuildingViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import Foundation

class BuildingViewModel: ObservableObject {
    
    @Published var detail: LoadingStateWithContent<BuildingDetail> = .loading
    
    private var buildingsMangager = BuildingsManager()
}

// MARK: - Load BuildingDetail

@MainActor
extension BuildingViewModel {
    
    func fetchData(for id: Int) async {
        do {
            let detail = try await buildingsMangager.getBuildingDetail(for: id)
            handle(detail: detail)
        } catch let error as ManagerError {
            handleLoadError(error: error)
        } catch {
            handleLoadError(error: .unknownError)
        }
    }
    
    private func handle(detail: BuildingDetail) {
        self.detail = .success(detail)
    }
    
    private func handleLoadError(error: ManagerError) {
        self.detail = .error(error)
    }
}

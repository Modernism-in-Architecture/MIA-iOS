//
//  BuildingViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 23.10.21.
//

import Foundation
import OSLog
import MIACoreNetworking
import MIACore

class BuildingViewModel: ObservableObject {
    
    @Published
    var detail: LoadingState<BuildingDetail> = .loading
    
    private var buildingsMangager = BuildingsManager()
}

// MARK: - Load BuildingDetail

extension BuildingViewModel {
    
    func fetchData(for id: Int) async {
        
        do {
            
            let startTime = CFAbsoluteTimeGetCurrent()
            let detail = try await buildingsMangager.getBuildingDetail(for: id)
            Logger.buildingDetail.debug("Fetch Building with id: \(id) - Time Elapsed: \(CFAbsoluteTimeGetCurrent() - startTime)")
            await handle(detail: detail)
            Logger.buildingDetail.debug("Handle Building with id: \(id) - Time Elapsed: \(CFAbsoluteTimeGetCurrent() - startTime)")
            
        } catch let error as ManagerError {
            await handleLoadError(error: error)
        } catch {
            await handleLoadError(error: .unknown)
        }
    }
}
    
@MainActor
extension BuildingViewModel {
    
    private func handle(detail: BuildingDetail) {
        self.detail = .success(detail)
    }
    
    private func handleLoadError(error: ManagerError) {
        self.detail = .error(error)
    }
}

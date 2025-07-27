//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import OSLog
import SwiftUI
import MIACoreUI

// MARK: - BuildingDetailView

struct BuildingDetailView: View {

    @StateObject
    var buildingDetailViewModel = BuildingViewModel()
    
    @State
    var id: Int
        
    var body: some View {
        
        content
            .task {
                await buildingDetailViewModel.fetchData(for: id)
            }
    }
}

extension BuildingDetailView {
    
    @ViewBuilder
    var content: some View {
        
        switch buildingDetailViewModel.detail {
            
        case .success(let detail):
            BuildingDetailSuccessView(buildingDetail: detail)
            
        case .loading:
            MIAActivityIndicator()
            
        case let .error(error):
            MIAErrorView(error: error)
        }
    }
}

// struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailSuccessView(item: .example())
//    }
// }

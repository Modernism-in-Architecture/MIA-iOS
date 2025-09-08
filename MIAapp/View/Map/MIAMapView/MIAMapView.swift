//
//  MIAMapView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 26.07.25.
//

import SwiftUI
import MIACoreUI

struct MIAMapView: View {
    
    @EnvironmentObject
    var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject
    var router: MIARouter

    var body: some View {
        content
    }
}

// MARK: - Views

extension MIAMapView {
    
    @ViewBuilder
    var content: some View {
        
        switch buildingsViewModel.state {
            
        case let .success(buildings):
            MIAMapSuccessView(buildings: buildings)
            
        case .loading:
            MIAActivityIndicator()
            
        case let .error(error):
            MIAErrorView(error: error)
        }
    }
}

//
//  BuildingsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI
import MIACoreUI

struct BuildingsListView: View {
    
    @EnvironmentObject 
    var buildingsViewModel: BuildingsListViewModel
    
    @EnvironmentObject
    var router: MIARouter

    var body: some View {
        
        content
            .refreshable {
                await buildingsViewModel.refresh()
            }
    }
}

// MARK: - Views

extension BuildingsListView {
    
    @ViewBuilder
    var content: some View {
        
        switch buildingsViewModel.state {
            
        case let .success(buildings):
            BuildingsListSuccessView(buildings: buildings)
            
        case .loading:
            MIAActivityIndicator()
            
        case .error(let error):
            MIAErrorView(error: error)
        }
    }
}

//struct MIAListView_Previews: PreviewProvider {
//
//    @ObservedObject var mia: BuildingsListViewModel
//
//    static var previews: some View {
//        MIAListView(mia: mia)
//    }
//}

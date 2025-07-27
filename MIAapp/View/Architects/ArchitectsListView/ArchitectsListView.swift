//
//  ArchitectsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import SwiftUI
import MIACoreNetworking
import MIACoreUI

struct ArchitectsListView: View {
    
    @EnvironmentObject
    var architectsController: ArchitectsListViewModel
    
    var body: some View {
        
        switch architectsController.state {
            
        case let .success(architects):
            ArchitectsListSuccessView(architects: architects)
            
        case .loading:
            MIAActivityIndicator()
            
        case let .error(error):
            MIAErrorView(error: error)
        }
    }
}

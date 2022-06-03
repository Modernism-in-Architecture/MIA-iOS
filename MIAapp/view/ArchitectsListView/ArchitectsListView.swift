//
//  ArchitectsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import SwiftUI

struct ArchitectsListView: View {
    
    @EnvironmentObject var architectsController: ArchitectsController
    
    var body: some View {
        switch architectsController.state {
        case .success:
            ArchitectsListSuccessView()
        case .loading:
            MIAActivityIndicator()
        case .error(let error):
            MIAErrorView(error: error)
        }
    }
}


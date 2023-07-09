//
//  BuildingsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 17.10.21.
//

import SwiftUI

struct BuildingsListView: View {
    
    @EnvironmentObject var buildingsController: BuildingsController

    var body: some View {
        switch buildingsController.state {
        case .success:
            BuildingsListSuccessView(buildings: buildingsController.buildings)
        case .loading:
            MIAActivityIndicator()
        case .error(let error):
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}

//struct MIAListView_Previews: PreviewProvider {
//
//    @ObservedObject var mia: BuildingsController
//
//    static var previews: some View {
//        MIAListView(mia: mia)
//    }
//}

//
//  BuildingDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 21.10.21.
//

import SwiftUI

struct BuildingView: View {

    @StateObject var detailController = BuildingDetailController()
    @State var item: Building
        
    var body: some View {
        switch detailController.detail {
        case .success(let detail):
            BuildingDetailView(item: item, detail: detail)
        case .loading:
            MIAActivityIndicator()
                .task {
                    await detailController.fetchData(for: item.id)
                }
        case .error(let error):
            // TODO: pass real error if changed to ManagerError
            MIAErrorView(error: .notImplementedError)
        }
    }
}

//struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView(item: .example())
//    }
//}

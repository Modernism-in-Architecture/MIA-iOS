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
            MIAErrorView(error: error)
        }
    }
}

//struct MIADetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingDetailView(item: .example())
//    }
//}

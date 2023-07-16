//
//  ArchitectView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 01.06.22.
//

import SwiftUI

struct ArchitectView: View {

    @StateObject var architectDetailController = ArchitectViewModel()
    @State var id: Int

    var body: some View {
        switch architectDetailController.architectDetail {
        case .loading:
            MIAActivityIndicator().task {
                await architectDetailController.fetchData(for: id)
            }
        case .success(let detail):
            ArchitectDetailView(detail: detail)
        case .error(_):
            // TODO: Better Error Message
            Text("Error")
        }
    }
}


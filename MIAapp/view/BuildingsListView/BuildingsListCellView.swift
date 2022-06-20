//
//  BuildingsListCellView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import SwiftUI

struct BuildingsListCellView: View {
    let building: Building
    let searchText: String
    var body: some View {
        NavigationLink(destination: BuildingView(item: building)) {
            if searchText.isEmpty {
                VStack(alignment: .leading, spacing: 0) {
                    MIAAsyncHeaderImage(url: building.feedImage)
                    caption
                    .padding()
                }
                .background(Color.cellBackground)
                .mask(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .shadow, radius: 3, x: 2, y: 2)
            } else {
                caption
            }
        }
        .buttonStyle(.plain)
    }
    
    var caption: some View {
        VStack(alignment: .leading) {
            Text(building.name)
                .lineLimit(1)
            Text("\(building.city), \(building.country)")
                .font(.caption)
                .lineLimit(1)
        }
    }
    
}

//struct MIAListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingsListCellView(item: .example())
//    }
//}

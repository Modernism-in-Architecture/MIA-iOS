//
//  BuildingsListCellView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 18.10.21.
//

import SwiftUI

struct BuildingsListCellView: View {
    let item: Building
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .aspectRatio(1.3, contentMode: .fill)
                .overlay{
                    MIAAsyncImage(url: item.feedImage)
                }
                .clipped()
            VStack(alignment: .leading) {
                Text("\(item.name)")
                    .lineLimit(1)
                Text("\(item.city), \(item.country)")
                    .font(.caption)
                    .lineLimit(1)
            }
            .padding()
        }
        .background(Color.cellBackground)
        .mask(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .shadow, radius: 3, x: 2, y: 2)
    }
}

//struct MIAListCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        BuildingsListCellView(item: .example())
//    }
//}

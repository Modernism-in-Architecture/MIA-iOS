//
//  ArchitectDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import SwiftUI

struct ArchitectDetailView: View {
    
    let detail: ArchitectDetail
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MIASection("Architect") {
                    architectDetails
                }
                MIASection("Description", ignoreIf: detail.description.isEmpty) {
                    MIAFoldableText(text: detail.attributedDescription)
                }
                MIASection("Buildings", ignoreIf: detail.relatedBuildings.isEmpty) {
                    buildings
                }
            }
            .padding()
        }
        .navigationBarTitle(detail.fullName)
        .toolbar {
            MIAShareView(url: detail.absoluteURL)
        }
    }
    
    var architectDetails: some View {
        VStack(alignment: .leading) {
            Text(detail.fullName)
                .font(.headline)
                .padding(.bottom, 5)
            if !detail.birth.isEmpty {
                Text("\(Image(systemName: "heart.circle")) \(detail.birth)")
                    .lineLimit(1)
            }
            if !detail.death.isEmpty {
                Text("\(Image(systemName: "heart.slash.circle")) \(detail.death)")
                    .lineLimit(1)
            }
        }
    }
    
    var buildings: some View {
        LazyVGrid(columns: columns, alignment:.leading, spacing: 20) {
            ForEach(detail.relatedBuildings) { building in
                NavigationLink(destination: BuildingView(building: building)) {
                    BuildingsListCellView(building: building, searchText: "")
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 10)
    }
}

//
//struct ArchitectDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchitectDetailView()
//    }
//}

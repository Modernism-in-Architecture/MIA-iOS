//
//  ArchitectDetailView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 08.02.22.
//

import SwiftUI

struct ArchitectDetailView: View {
    
    @StateObject var architectDetailController = ArchitectDetailController()
//    @State var architect: Architect
    @State var id: Int
    let columns = [GridItem(.adaptive(minimum: 300, maximum: 400))]
    
    var body: some View {
        switch architectDetailController.architectDetail {
        case .loading:
            MIAActivityIndicator().task {
                await architectDetailController.fetchData(for: id)
            }
        case .success(let detail):
            ScrollView {
                VStack(alignment: .leading) {
                    MIASection("Architect") {
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
                    if !detail.description.isEmpty {
                        MIASection("Description") {
                            MIAFoldableText(text: detail.attributedDescription)
                        }
                    }
                    if !detail.relatedBuildings.isEmpty {
                        MIASection("Buildings") {
                            LazyVGrid(columns: columns, alignment:.leading, spacing: 20) {
                                ForEach(detail.relatedBuildings) { building in
                                    NavigationLink(destination: BuildingView(item: building)) {
                                        BuildingsListCellView(building: building, searchText: "")
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitle(detail.fullName)
            .toolbar {
                // TODO: extract to seperate View. Same Code with BuildingDetailView
                Button(action: {
                    let sharedText = "Sent with ❤️ from your MIA App."
                    let sharedItems = [detail.absoluteURL, sharedText] as [Any]
                    let ac = UIActivityViewController(activityItems: sharedItems, applicationActivities: nil)
                    
                    let allScenes = UIApplication.shared.connectedScenes
                    let scene = allScenes.first { $0.activationState == .foregroundActive }
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.keyWindow?.rootViewController?.present(ac, animated: true, completion: nil)
                    }
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
        case .error(_):
            Text("Error")
        }
    }
}

//
//struct ArchitectDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchitectDetailView()
//    }
//}

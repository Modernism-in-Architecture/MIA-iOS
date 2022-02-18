//
//  ArchitectsListView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import SwiftUI

struct ArchitectsListView: View {
    
    @EnvironmentObject var architectsController: ArchitectsController
    @State private var searchText = ""
    
    var body: some View {
        switch architectsController.state {
        case .success:
            NavigationView {
                let groupedArchitects = groupedArchitects
                ScrollViewReader { proxy in
                    ZStack {
                        
                        // List
                        List{
                            ForEach(groupedArchitects.keys.sorted(), id:\.self) { key in
                                Section(header: Text("\(key)")) {
                                    if let architects = groupedArchitects[key] {
                                        ForEach(architects) { architect in
                                            NavigationLink(destination: ArchitectDetailView(id: architect.id)) {
                                                Text("\(architect.fullName)")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .refreshable{
                            Task {
                                architectsController.state = .loading
                                await architectsController.fetchData()
                            }
                        }
                        .searchable(text: $searchText)
                        .disableAutocorrection(true)
                        .listStyle(.insetGrouped)
                        .navigationBarTitleDisplayMode(.inline)
                        
                        // Index Bar on the Side
                        if searchText.isEmpty {
                            HStack {
                                Spacer()
                                VStack(spacing:0) {
                                    ForEach(groupedArchitects.keys.sorted(), id:\.self) { key in
                                        Button(action: {
                                            withAnimation{
                                                proxy.scrollTo(key, anchor: .top)
                                            }
                                        }) {
                                            Text("\(key)")
                                                .font(.caption)
                                                .padding(.leading, 30)
                                        }
                                    }
                                }
                            }
                            .padding(.trailing, 5)
                        }
                    }
                    .onAppear() {
                        if let firstIndex = groupedArchitects.keys.sorted().first {
                            proxy.scrollTo(firstIndex, anchor: .top)
                        }
                    }
                    .navigationTitle("Architects")
                }
            }
        case .loading:
            LoadingActivityView()
//            MIAActivityIndicator()
        case .error(let error):
            MIAErrorView(error: error)
        }
        
    }
    
    var searchResults: [Architect] {
        if searchText.isEmpty { return architectsController.architects }
        return architectsController.architects.filter { architect in
            architect.firstName.lowercased().contains(searchText.lowercased()) ||
            architect.lastName.lowercased().contains(searchText.lowercased())
        }
    }
    
    var groupedArchitects: Dictionary<String, [Architect]> {
        return Dictionary(grouping: self.searchResults, by: { architect in
            let normalizedName = architect.lastName.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            return String(normalizedName.first!).uppercased()
        })
    }
}


//struct ArchitectsListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchitectsListView()
//    }
//}

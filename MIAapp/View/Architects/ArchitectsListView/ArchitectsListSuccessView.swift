//
//  ArchitectListSuccessView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 31.05.22.
//

import MIACore
import MIACoreUI
import SwiftUI

// MARK: - ArchitectsListSuccessView

struct ArchitectsListSuccessView: View {
    
    @EnvironmentObject
    var router: MIARouter
    
    @EnvironmentObject
    var architectsListViewModel: ArchitectsListViewModel
    
    @State
    var architects: [Architect]
    
    @State
    var isKeyboardShowing = false
    
    @State
    private var searchText = ""
    
    @State
    private var isSearching = false

    var body: some View {
        
        content
            .refreshable {
                await architectsListViewModel.refresh()
            }
    }
}

// MARK: - Views

private extension ArchitectsListSuccessView {
    
    var content: some View {
            
        VStack {
            
            if isSearching {
                MIASearchBar(text: $searchText, isSearching: $isSearching)
            }
                
            ArchitectsGroupedListView(
                router: router,
                isSearching: $isSearching,
                groupedArchitects: groupedArchitects
            )
            .toolbar { toolbar }
            .navigationTitle("Architects")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ToolbarContentBuilder
    var toolbar: some ToolbarContent {
        
        ToolbarItem(placement: .navigationBarLeading) {
            MIAToolBarLogo()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            MIASearchButton(isSearching: $isSearching)
        }
    }
}

// MARK: - Views (structs)

private extension ArchitectsListSuccessView {
    
    struct ArchitectsGroupedListView: View {
        
        @ObservedObject
        var router: MIARouter
        
        @Binding
        var isSearching: Bool

        let groupedArchitects: [String: [Architect]]
        
        var body: some View {
            
            ScrollViewReader { proxy in
                
                ZStack {
                    
                    ArchitectsGroupedListContentView(router: router, groupedArchitects: groupedArchitects)

                    if !isSearching {
                        MIASectionIndexView(scrollViewProxy: proxy, keys: groupedArchitects.keys.sorted())
                    }
                }
            }
        }
    }
    
    struct ArchitectsGroupedListContentView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let groupedArchitects: [String: [Architect]]
        
        var body: some View {
            
            ScrollView {
                
                LazyVStack(
                    alignment: .leading,
                    spacing: .zero,
                    pinnedViews: [.sectionHeaders]
                ) {
                    
                    ForEach(groupedArchitects.keys.sorted(), id: \.self) { sectionKey in
                        
                        ArchitectsGroupedListSectionView(
                            router: router,
                            sectionKey: sectionKey,
                            architects: groupedArchitects[sectionKey] ?? []
                        )
                    }
                }
            }
        }
    }
    
    struct ArchitectsGroupedListSectionView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let sectionKey: String
        let architects: [Architect]
        
        var body: some View {
            
            Section(header: sectionHeader) {
                sectionContent
            }
        }
        
        var sectionContent: some View {
            
            VStack(spacing: .zero) {
                
                ForEach(architects) { architect in
                    
                    ArchitectsGroupedListRowView(
                        router: router,
                        architect: architect,
                        isLast: architect == architects.last
                    )
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
            .padding(.horizontal, 18)
            .padding(.bottom, 18)
        }
        
        var sectionHeader: some View {
            
            HStack {
                
                Text("\(sectionKey)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
            }
            .padding(.horizontal, 36)
            .padding(.vertical, 6)
            .background(.background)
        }
    }
    
    struct ArchitectsGroupedListRowView: View {
        
        @ObservedObject
        var router: MIARouter
        
        let architect: Architect
        
        let isLast: Bool
        
        var body: some View {
            
            VStack(spacing: .zero) {
                
                row
                if !isLast {
                    rowDivider
                }
            }
        }
        
        var row: some View {
            
            HStack(alignment: .center) {
                
                Text("\(architect.fullName)")
                    .padding(.leading, 18)
                    .padding(.vertical, 12)
                Spacer()
            }
            .contentShape(Rectangle())
            .onTapGesture {
                router.showArchitectDetail(id: architect.id)
            }
        }
        
        var rowDivider: some View {
            
            Rectangle()
                .fill(.tertiary.opacity(0.3))
                .frame(height: 1)
                .padding(.vertical, .zero)
                .padding(.leading, 18)
        }
    }
}

// MARK: - Computed Properties

private extension ArchitectsListSuccessView {
    
    var searchResults: [Architect] {
        
        if searchText.isEmpty {
            return self.architects
        }
        return self.architects.filter { architect in
            
            architect.firstName.lowercased().contains(searchText.lowercased()) ||
                architect.lastName.lowercased().contains(searchText.lowercased())
        }
    }
    
    var groupedArchitects: [String: [Architect]] {
        
        Dictionary(grouping: searchResults, by: { architect in
            
            let normalizedName = architect.lastName.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
            return String(normalizedName.first!).uppercased()
        })
    }
}

// MARK: - Previews

#Preview("Light") {

    let viewModel = ArchitectsListViewModel()
    
    viewModel.fetch()
    
    return ArchitectsListSuccessView(architects: [])
        .environmentObject(MIARouter())
        .environmentObject(viewModel)
}

#Preview("Dark") {

    let viewModel = ArchitectsListViewModel()
    
    viewModel.fetch()
    
    return ArchitectsListSuccessView(architects: [])
        .environmentObject(MIARouter())
        .environmentObject(viewModel)
        .preferredColorScheme(.dark)
}


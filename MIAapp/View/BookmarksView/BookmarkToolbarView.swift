//
//  BookmarkToolbarView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.06.22.
//

import SwiftUI

struct BookmarkToolbarView: View {
    
    @EnvironmentObject var cloudKitBookmarksController: BookmarksViewModel
    
    let id: Int
    
    var body: some View {
        Button(action: toggleBookmark) {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
        }
        .foregroundColor(isBookmarked ? Color.red : Color.secondary)
    }
    
    var isBookmarked: Bool {
        cloudKitBookmarksController.contains(id: id)
    }
    
    func toggleBookmark() {
        cloudKitBookmarksController.toggle(id: id)
    }
}

//struct BookmarkToolbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkToolbarView()
//    }
//}

//
//  BookmarkToolbarView.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.06.22.
//

import SwiftUI

struct BookmarkToolbarView: View {
    
    @EnvironmentObject var bookmarksController: BookmarksController

    let id: Int
    
    var body: some View {
        Button(action: toggleBookmark) {
            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
        }
        .foregroundColor(isBookmarked ? Color.red : Color.secondary)
    }
    
    var isBookmarked: Bool {
        bookmarksController.bookmarks.contains(id)
    }
    
    func toggleBookmark() {
        bookmarksController.toggle(id: id)
    }
}



//struct BookmarkToolbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkToolbarView()
//    }
//}

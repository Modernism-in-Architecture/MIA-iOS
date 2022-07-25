//
//  BookmarksController.swift
//  MIAapp
//
//  Created by Sören Kirchner on 27.06.22.
//

import Foundation

class BookmarksController: ObservableObject {
    
    @Published private(set) var bookmarks: Set<Int> = []
    
    init() {
        load()
    }
    
    func add(_ id: Int) {
        print("add ID : \(id)")
        bookmarks.insert(id)
        save()
        debugPrint("bookmarks: \(bookmarks)")
    }
    
    func remove(_ id: Int) {
        bookmarks.remove(id)
    }
 
    func toggle(id: Int) {
        if bookmarks.contains(id) {
            remove(id)
        } else {
            add(id)
        }
    }
    
    func contains(id: Int) -> Bool {
        return bookmarks.contains(id)
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    var documentUrl: URL {
        getDocumentsDirectory().appendingPathComponent("bookmarks.json")
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(bookmarks)
            try data.write(to: documentUrl, options: .atomic)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func load() {
        do {
            let data = try String(contentsOf: documentUrl).data(using: .utf8)
            bookmarks = try JSONDecoder().decode(Set<Int>.self, from: data!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

//
//  BookmarksViewModel.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.08.22.
//

import CloudKit

struct BookmarkEntry: Hashable {
    let record: CKRecord
    let bookmarkID: Int
}

class BookmarksViewModel: ObservableObject {
    
    @Published private(set) var bookmarks: Set<BookmarkEntry> = []
    
    @Published var isSignedIn: Bool = false
    @Published var error = ""
    
    let recordType = "bookmarks"
    
    init() {
        getStatus()
        fetch()
    }
}

// MARK: - Private Methods

private extension BookmarksViewModel {
    
    func add(_ id: Int) {
        let newEntry: BookmarkEntry = BookmarkEntry(record: createRecord(for: id), bookmarkID: id)
        save(newEntry)
    }
    
    func remove(_ id: Int) {
        guard let entry = bookmarks.first(where: { $0.bookmarkID == id }) else { return }
        delete(entry)
    }
    
    func save(_ entry: BookmarkEntry) {
        bookmarks.insert(entry)
        CKContainer.default().privateCloudDatabase.save(entry.record) { record, error in
            guard let record = record else {
                DispatchQueue.main.async {
                    self.bookmarks.remove(entry)
                }
                return
            }
        }
    }

    func delete(_ entry: BookmarkEntry) {
        self.bookmarks.remove(entry)
        CKContainer.default().privateCloudDatabase.delete(withRecordID: entry.record.recordID , completionHandler: { recordID, error in
            if recordID == nil {
                DispatchQueue.main.async {
                    self.bookmarks.insert(entry)
                }
                return
            }
        })
    }
    
    func createRecord(for id: Int) -> CKRecord {
        let record = CKRecord(recordType: recordType)
        record["bookmarkID"] = id
        return record
    }
    
    func getStatus() {
        CKContainer.default().accountStatus { status, error in
            DispatchQueue.main.async {
                switch status {
                case .available:
                    self.isSignedIn = true
                case .couldNotDetermine,
                     .restricted,
                     .noAccount,
                     .temporarilyUnavailable:
                    self.isSignedIn = false
                    self.error = "error"
                }
            }
        }
    }
}

// MARK: - Public Methods

extension BookmarksViewModel {
    
    func toggle(id: Int) {
        if contains(id: id) {
            remove(id)
        } else {
            add(id)
        }
    }
    
    func contains(id: Int) -> Bool {
        return bookmarks.contains(where: { $0.bookmarkID == id })
    }
    
    func fetch() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var bookmarks: Set<BookmarkEntry> = []
        
        queryOperation.recordMatchedBlock = { recordID, result in
            switch result {
            case .success(let record):
                guard let id = record["bookmarkID"] as? Int else { return }
                bookmarks.insert(BookmarkEntry(record: record, bookmarkID: id))
            case .failure(let error):
                print("recordMatchedBlock error: \(error)")
            }
        }
        
        queryOperation.queryResultBlock = { [weak self] result in
            print("result: \(result)")
            DispatchQueue.main.async {
                self?.bookmarks = bookmarks
            }
        }
        
        CKContainer.default().privateCloudDatabase.add(queryOperation)
    }
}

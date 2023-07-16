//
//  API.swift
//  MIAapp
//
//  Created by Sören Kirchner on 30.01.22.
//

import Foundation

struct API {
    static let buildings = URL(string: "https://modernism-in-architecture.org/api/v1/buildings/")!
    static let architects = URL(string: "https://modernism-in-architecture.org/api/v1/architects/")!
    
    static let timeoout = 10.0
    
    static func building(for id: Int) -> URL {
        return URL(string: "https://modernism-in-architecture.org/api/v1/buildings/\(id)/")!
    }
    
    static func architect(for id: Int) -> URL {
        return URL(string: "https://modernism-in-architecture.org/api/v1/architects/\(id)/")!
    }
    
    static func request(for url: URL) -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: API.timeoout)
        request.addValue("Token \(Secret.token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

//
//  Architect.swift
//  MIAapp
//
//  Created by Sören Kirchner on 06.02.22.
//

import Foundation

struct Architects: Decodable {
    var data: [Architect]
}

struct Architect: Decodable, Identifiable {
    let id: Int
    let lastName: String
    let firstName: String
    
    var fullName: String {
        return [lastName, firstName].filter{ !$0.isEmpty }.joined(separator: ", ")
    }
}

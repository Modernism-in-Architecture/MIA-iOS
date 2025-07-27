//
//  IdentifiableURL.swift
//  MIAPackages
//
//  Created by Sören Kirchner on 27.07.25.
//

import Foundation

public struct IdentifiableURL: Identifiable, Sendable {
    
    public let url: URL
    public var id: URL { url }
}

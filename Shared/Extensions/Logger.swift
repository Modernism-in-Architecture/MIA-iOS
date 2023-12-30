//
//  Logger.swift
//  MIAapp
//
//  Created by Sören Kirchner (privat) on 28.12.23.
//

import Foundation
import OSLog

extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let map = Logger(subsystem: subsystem, category: "map")
}

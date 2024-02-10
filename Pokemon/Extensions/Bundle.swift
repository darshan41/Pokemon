//
//  Bundle.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import Foundation

public extension Bundle {
    
    var appVersion: String {
        self.infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var identifier: String {
        self.infoDictionary?["CFBundleName"] as! String
    }
    
    var buildNumber: String {
        self.infoDictionary?["CFBundleVersion"] as! String
    }
    
    static var mainAppVersion: String { Self.main.appVersion }
    static var identifier: String { Self.main.identifier }
    static var buildNumber: String { Self.main.buildNumber }
}



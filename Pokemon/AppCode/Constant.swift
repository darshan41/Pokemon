//
//  Constant.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import Foundation

var isDeveloperMode: Bool = {
    #if DEBUG
    return true
    #else
    return false
    #endif
}()

import UIKit

struct Constants {
    
    fileprivate static let environment: Env = .prod
    
    fileprivate enum Env {
        case prod
        
        var endPoint: String {
            switch self {
            case .prod:
                return "https://pokeapi.co/api/v2"
            }
        }
    }
    
    struct API {
        static let serviceEndPoint = Constants.environment.endPoint
        static var appUpdateURL = ""
        static var programURLInWebsite = ""
        static var services: Services?
        static var pokemonzs: [Pokemonz] = []
    }
    
    struct appInfo {
        static let displayName = Bundle.main.infoDictionary!["CFBundleName"] as! String
        static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        static let bundleIdentifier = Bundle.main.bundleIdentifier
        static let buildNumber = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        static let appName = "Pokemon"
    }
    
    struct deviceInfo {
        static var id = Constants.Device.id!
        static var timeZone = TimeZone.current.identifier
        static let model = UIDevice.current.localizedModel
        static let iOSVersion = UIDevice.current.systemVersion
        static let resolution = "\(UIScreen.main.bounds.width) x \(UIScreen.main.bounds.height)"
        static var platform: String { "ios" }
    }
    
    struct Parameter {
        
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let email = "email"
        static let password = "password"
        static let cookie = "Cookie"
        
        // MARK: Keys
        
        static let platform = "platform"
        static let language = "language"
        static let deviceType = "deviceType"
        static let searchKey = "searchKey"
        static let skippedAt = "skippedAt"
        static let inTime = "inTime"
        static let videoURL = "videoURL"
        static let genre = "genre"
        static let searchValue = "searchValue"
        static let postalCode = "postalCode"
        static let gateway = "gateway"
        static let version = "version"
        static let receipt = "receipt"
        static let country = "country"
        static let isAddFavorites = "isAddFavorites"
        static let isRemoveFavorites = "isRemoveFavorites"
    }
    
    struct App {
        static let identifier = Bundle.identifier
        static let version = Bundle.mainAppVersion
        static let buildNumber = Bundle.buildNumber
        static let OSversion = UIDevice.current.systemVersion
        static let deviceModel = ""
        static let deviceName = UIDevice.current.name
        static let deviceTimeZone = TimeZone.current.identifier
        static let appName = "Pokemon"
        static var showableAppVersion: String {
            "V \(version)(\(buildNumber))"
        }
    }
    
    struct Device {
        static let deviceModel = UIDevice.current.localizedModel
        static let OSVersion = UIDevice.current.systemVersion
        static let deviceResolution = "\(width) x \(height)"
        static let gateway = "apple"
        static let width = UIScreen.main.bounds.width
        static let height = UIScreen.main.bounds.height
        static let id = UIDevice.current.identifierForVendor?.uuidString
        static let name = UIDevice.current.name
        static var platform: String = "ios"
        static var type: String = "mobile"
    }
}

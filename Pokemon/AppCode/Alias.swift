//
//  Alias.swift
//  Pokemon
//
//  Created by Darshan S on 10/02/24.
//

import UIKit

typealias ParamSet = Set<(Parameters)>
typealias BasicDict = [String: String?]
typealias ParameterDictionary = [Parameters: String?]
typealias ServicesCodingKeys = Services.ServiceCodingKey
typealias Codable = Encodable & Decodable & Describable

extension Data {
    
    var serialisedToBasicDict: BasicDict? {
        try? JSONDecoder().decode(BasicDict.self, from: self)
    }
}


extension BasicDict {
    
    var bulkEdit: NSString {
        let str = self.compactMap({ dict -> String? in
            guard let value = dict.value else { return nil }
            return dict.key + ":" + value
        }).joined(separator: "\n")
        return NSString(string: str)
    }
}


enum Parameters: String,Comparable,CaseIterable,Codable {
    
    public static func < (lhs: Parameters, rhs: Parameters) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    case email = "email"
    case socialMediaPlatform = "socialMediaPlatform"
    case uniqueID = "firebaseUserUID"
    case platform = "platform"
    case offset = "offset"
    case limit = "limit"
    case deviceID = "deviceID"
    case customerID = "customerID"
    case profileID = "profileID"
    case name = "name"
    case zipCode = "zipCode"
    case firstName = "firstName"
    case lastName = "lastName"
    case preferences = "preferences"
    case gender = "gender"
    case ratingIDs = "ratingIDs"
    case channelIDs = "channelIDs"
    case languageIDs = "languageIDs"
    case airingID = "airingID"
    case channelID = "channelID"
    case startDate = "startDate"
    case lastWatchedMenu = "lastWatchedMenu"
    case multiViewSelection = "multiViewSelection"
    case genreIDs = "genreIDs"
    case identifier = "identifier"
    case appName = "appName"
    case language = "language"
    case country = "country"
    case device = "device"
    case version = "version"
    case timeZone = "TimeZone"
    case password = "password"
    case OSVersion = "OSVersion"
    case resolution = "Resolution"
    case deviceType = "deviceType"
    case developerMode = "DeveloperMode"
    case appVersion = "appVersion"
    
    var serviceParam: String { "&"+self.rawValue+"=" }
    var identifierParam: String { "{"+self.rawValue+"}" }
    
    static func getValue(
        _ parameters: Self
    ) -> String? {
        parameters.serviceParam ?+? (parameters.defalutValue ?? "")
    }
    
    var defalutValue: String? {
        switch self {
        case .email:
            return ""
        case .platform:
            return Constants.Device.platform
        case .deviceID:
            return Constants.Device.id
        case .version,.appVersion:
            return Constants.App.version
        case .appName:
            return Constants.App.appName
        case .language:
            return "en"
        case .device:
            return Constants.Device.type
        case .timeZone:
            return Constants.App.deviceTimeZone
        case .OSVersion:
            return Constants.Device.OSVersion
        case .resolution:
            return Constants.Device.deviceResolution
        case .deviceType:
            return Constants.Device.deviceModel
        case .developerMode:
            return isDeveloperMode ? "1" : "0"
        default:
            return nil
        }
    }
}

extension Parameters {
    
    public enum CodingKeys: String,CodingKey {
        case email = "email"
        case platform = "platform"
        case deviceID = "deviceID"
        case password = "password"
        case zipCode = "zipCode"
        case appVersion = "appVersion"
        case customerID = "customerID"
        case profileID = "profileID"
        case channelID = "channelID"
        case airingID = "airingID"
        case identifier = "identifier"
        case startDate = "startDate"
        case timezone = "timezone"
        case channelIDs = "channelIDs"
        case accessIdentifier = "accessIdentifier"
        case appName = "appName"
        case language = "language"
        case country = "country"
        case device = "device"
        case version = "version"
        case programID = "programID"
    }
    
    init(from decoder: Decoder) throws {
        self = try Parameters(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .appName
    }
}

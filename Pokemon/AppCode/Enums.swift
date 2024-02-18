//
//  Enums.swift
//  Pokemon
//
//  Created by Darshan S on 08/02/24.
//

import UIKit

public enum AppStoryBoard: String {
    
    case Main,Home,Search,Info
    
    var instance : UIStoryboard { UIStoryboard(name: self.rawValue, bundle: Bundle.main) }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        return scene
    }
    
    func initializeViewController() -> UIViewController? {
        instance.instantiateInitialViewController()
    }
}

enum ErrorMessages: ErrorShowable {
    
    case somethingWentWrong
    case InvalidResponse
    case offline
    case requestTimedOut
    case userNotExists
    case onCall
    
    var text: String {
        switch self {
        case .somethingWentWrong:
            return "Something Went Wrong!"
        case .InvalidResponse:
            return "Invalid response"
        case .offline:
            return "Please check internet connectivity and try again"
        case .requestTimedOut:
            return "Can’t Connect to App"
        case .userNotExists:
            return "User not exists"
        case .onCall:
            return "Net connection while on call is not allowed."
        }
    }
    
    var showableDescription: String {
        text
    }
}

// MARK: HTTP Method

enum ServiceMethod: String,Codable {
    
    case Post = "POST"
    case Get = "GET"
    case Delete = "DELETE"
    case Put = "PUT"
    
    func insufficientDataError(with parameters: Set<String>) -> APIManagerError {
        switch self {
        case .Post:
            return .postParametersAreNotSatisfied(parametersRequired: parameters)
        case .Get:
            return .getParametersAreNotSatisfied(parametersRequired: parameters)
        case .Delete:
            return .deleteParametersAreNotSatisfied(parametersRequired: parameters)
        case .Put:
            return .putParametersAreNotSatisfied(parametersRequired: parameters)
        }
    }
}

//
//  Color.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import SwiftUI

extension ColorScheme {
    
    var isDark: Bool { self == .dark }
    
    var oppositeSchemeColor: Color {
        isDark ? .primaryLight : .primaryDark
    }
    
    var properSchemeColor: Color {
        isDark ? .primaryDark : .primaryLight
    }
}

extension UIColor {
    var toColor: Color { Color(self) }
}

extension Color {
    
    var toUIColor: UIColor {
        UIColor(self)
    }
    
    static func fillColor(_ scheme: ColorScheme) -> Color {
        scheme.properSchemeColor
    }
    
    static func fillOppositeColor(_ scheme: ColorScheme) -> Color {
        scheme.oppositeSchemeColor
    }
    
    static var currentScheme: ColorScheme {
        return appDelegate.window?.rootViewController?.view.traitCollection.userInterfaceStyle == .dark ? .dark : .light
    }
    
    
    static var oppositeSchemeColor: Color {
        Color.currentScheme == .dark ? .primaryLight : .primaryDark
    }
    
    static var properColor: Color {
        Color.currentScheme == .dark ? .primaryDark : .primaryLight
    }
}

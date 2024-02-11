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
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
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

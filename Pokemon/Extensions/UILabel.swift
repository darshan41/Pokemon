//
//  UILabel.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit

extension UILabel {
    
    func setText(_ text: String? = nil) {
        if let text,!text.isEmpty {
            self.text = text
            self.isHidden = false
        } else {
            self.isHidden = true
        }
    }
}

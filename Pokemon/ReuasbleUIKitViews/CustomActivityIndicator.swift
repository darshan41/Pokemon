//
//  CustomActivityIndicator.swift
//  Pokemon
//
//  Created by Darshan S on 11/02/24.
//

import UIKit

class CustomActivityIndicator: UIActivityIndicatorView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        self.color = UIColor.pikapikaYellow
        self.hidesWhenStopped = true
    }
}

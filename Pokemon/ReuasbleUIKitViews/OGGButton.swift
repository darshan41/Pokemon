//
//  OGGButton.swift
//  Pokemon
//
//  Created by Darshan S on 20/02/24.
//

import UIKit

class OGGButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    // MARK: - Setup

    private func setupButton() {
        layer.cornerRadius = 10.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.oppositeAccent.cgColor
        setTitleColor(UIColor.accent, for: .normal)
        backgroundColor = UIColor.clear
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10.0
    }
}

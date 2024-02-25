//
//  ImageController.swift
//  Pokemon
//
//  Created by Darshan S on 25/02/24.
//

import UIKit

class ImageController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.random
    }
    
    func loadImage(_ url: String?) {
        
    }
}

extension UIColor {
    
    static var random: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


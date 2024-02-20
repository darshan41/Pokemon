//
//  UIBezierPath.swift
//  Pokemon
//
//  Created by Darshan S on 20/02/24.
//

import UIKit

extension UIBezierPath {
    
    static func calculateBounds(paths: [UIBezierPath]) -> CGRect {
        let myPaths = UIBezierPath()
        for path in paths {
            myPaths.append(path)
        }
        return myPaths.bounds
    }
    
}

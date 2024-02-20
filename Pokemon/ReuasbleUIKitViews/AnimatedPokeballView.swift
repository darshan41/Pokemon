//
//  AnimatedPokeballView.swift
//  Pokemon
//
//  Created by Darshan S on 20/02/24.
//

import UIKit

class AnimatedPokeballView: UIView {
    
    private let pokeballLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    let fillColor = UIColor(red: 0.929, green: 0.333, blue: 0.392, alpha: 1.000)
    let fillColor2 = UIColor(red: 0.902, green: 0.914, blue: 0.929, alpha: 1.000)
    let fillColor3 = UIColor(red: 0.263, green: 0.290, blue: 0.329, alpha: 1.000)
    let fillColor4 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    let fillColor5 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        pokeballLayer.path = createPokeballPath().cgPath
        pokeballLayer.fillColor = UIColor.red.cgColor
        layer.addSublayer(pokeballLayer)
        animatePokeball()
    }
    
    private func createPokeballPath() -> UIBezierPath {
        let context = UIGraphicsGetCurrentContext()
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 768.55, y: 244.3))
        bezierPath.addCurve(to: CGPoint(x: 682.86, y: 117.15), controlPoint1: CGPoint(x: 748.41, y: 196.67), controlPoint2: CGPoint(x: 719.58, y: 153.88))
        bezierPath.addCurve(to: CGPoint(x: 555.71, y: 31.45), controlPoint1: CGPoint(x: 646.11, y: 80.43), controlPoint2: CGPoint(x: 603.32, y: 51.59))
        bezierPath.addCurve(to: CGPoint(x: 400, y: 0), controlPoint1: CGPoint(x: 506.4, y: 10.59), controlPoint2: CGPoint(x: 454, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 244.3, y: 31.45), controlPoint1: CGPoint(x: 346.01, y: 0), controlPoint2: CGPoint(x: 293.62, y: 10.58))
        bezierPath.addCurve(to: CGPoint(x: 117.15, y: 117.15), controlPoint1: CGPoint(x: 196.67, y: 51.59), controlPoint2: CGPoint(x: 153.88, y: 80.44))
        bezierPath.addCurve(to: CGPoint(x: 31.44, y: 244.3), controlPoint1: CGPoint(x: 80.43, y: 153.88), controlPoint2: CGPoint(x: 51.59, y: 196.67))
        bezierPath.addCurve(to: CGPoint(x: 0, y: 400), controlPoint1: CGPoint(x: 10.58, y: 293.62), controlPoint2: CGPoint(x: 0, y: 346.01))
        bezierPath.addCurve(to: CGPoint(x: 31.45, y: 555.71), controlPoint1: CGPoint(x: 0, y: 454), controlPoint2: CGPoint(x: 10.58, y: 506.4))
        bezierPath.addCurve(to: CGPoint(x: 117.15, y: 682.84), controlPoint1: CGPoint(x: 51.59, y: 603.32), controlPoint2: CGPoint(x: 80.43, y: 646.12))
        bezierPath.addCurve(to: CGPoint(x: 244.3, y: 768.55), controlPoint1: CGPoint(x: 153.88, y: 719.58), controlPoint2: CGPoint(x: 196.67, y: 748.41))
        bezierPath.addCurve(to: CGPoint(x: 400, y: 800), controlPoint1: CGPoint(x: 293.62, y: 789.4), controlPoint2: CGPoint(x: 346.01, y: 800))
        bezierPath.addCurve(to: CGPoint(x: 555.71, y: 768.55), controlPoint1: CGPoint(x: 454, y: 800), controlPoint2: CGPoint(x: 506.4, y: 789.4))
        bezierPath.addCurve(to: CGPoint(x: 682.86, y: 682.84), controlPoint1: CGPoint(x: 603.32, y: 748.41), controlPoint2: CGPoint(x: 646.12, y: 719.58))
        bezierPath.addCurve(to: CGPoint(x: 768.55, y: 555.71), controlPoint1: CGPoint(x: 719.58, y: 646.12), controlPoint2: CGPoint(x: 748.41, y: 603.32))
        bezierPath.addCurve(to: CGPoint(x: 800, y: 400), controlPoint1: CGPoint(x: 789.4, y: 506.4), controlPoint2: CGPoint(x: 800, y: 454))
        bezierPath.addCurve(to: CGPoint(x: 768.55, y: 244.3), controlPoint1: CGPoint(x: 800, y: 346.01), controlPoint2: CGPoint(x: 789.4, y: 293.62))
        bezierPath.close()
        fillColor.setFill()
        bezierPath.fill()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0.16, y: 411.23))
        bezier2Path.addCurve(to: CGPoint(x: 31.45, y: 555.71), controlPoint1: CGPoint(x: 1.53, y: 461.25), controlPoint2: CGPoint(x: 12.02, y: 509.81))
        bezier2Path.addCurve(to: CGPoint(x: 117.15, y: 682.84), controlPoint1: CGPoint(x: 51.59, y: 603.32), controlPoint2: CGPoint(x: 80.43, y: 646.12))
        bezier2Path.addCurve(to: CGPoint(x: 244.3, y: 768.55), controlPoint1: CGPoint(x: 153.88, y: 719.58), controlPoint2: CGPoint(x: 196.67, y: 748.41))
        bezier2Path.addCurve(to: CGPoint(x: 400, y: 800), controlPoint1: CGPoint(x: 293.62, y: 789.4), controlPoint2: CGPoint(x: 346.01, y: 800))
        bezier2Path.addCurve(to: CGPoint(x: 555.71, y: 768.55), controlPoint1: CGPoint(x: 454, y: 800), controlPoint2: CGPoint(x: 506.4, y: 789.4))
        bezier2Path.addCurve(to: CGPoint(x: 682.86, y: 682.84), controlPoint1: CGPoint(x: 603.32, y: 748.41), controlPoint2: CGPoint(x: 646.12, y: 719.58))
        bezier2Path.addCurve(to: CGPoint(x: 768.55, y: 555.71), controlPoint1: CGPoint(x: 719.58, y: 646.12), controlPoint2: CGPoint(x: 748.41, y: 603.32))
        bezier2Path.addCurve(to: CGPoint(x: 799.85, y: 411.23), controlPoint1: CGPoint(x: 787.99, y: 509.81), controlPoint2: CGPoint(x: 798.49, y: 461.25))
        bezier2Path.addLine(to: CGPoint(x: 0.16, y: 411.23))
        bezier2Path.close()
        fillColor2.setFill()
        bezier2Path.fill()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 798.09, y: 439.41))
        bezier3Path.addCurve(to: CGPoint(x: 800, y: 400), controlPoint1: CGPoint(x: 799.36, y: 426.37), controlPoint2: CGPoint(x: 800, y: 413.23))
        bezier3Path.addCurve(to: CGPoint(x: 797.61, y: 355.8), controlPoint1: CGPoint(x: 800, y: 385.13), controlPoint2: CGPoint(x: 799.19, y: 370.39))
        bezier3Path.addCurve(to: CGPoint(x: 713.23, y: 366.82), controlPoint1: CGPoint(x: 777.73, y: 358.86), controlPoint2: CGPoint(x: 749.19, y: 362.85))
        bezier3Path.addCurve(to: CGPoint(x: 400, y: 383.34), controlPoint1: CGPoint(x: 644.97, y: 374.35), controlPoint2: CGPoint(x: 535.25, y: 383.34))
        bezier3Path.addCurve(to: CGPoint(x: 86.78, y: 366.82), controlPoint1: CGPoint(x: 264.76, y: 383.34), controlPoint2: CGPoint(x: 155.03, y: 374.35))
        bezier3Path.addCurve(to: CGPoint(x: 2.4, y: 355.8), controlPoint1: CGPoint(x: 50.81, y: 362.85), controlPoint2: CGPoint(x: 22.28, y: 358.86))
        bezier3Path.addCurve(to: CGPoint(x: 0, y: 400), controlPoint1: CGPoint(x: 0.81, y: 370.39), controlPoint2: CGPoint(x: 0, y: 385.13))
        bezier3Path.addCurve(to: CGPoint(x: 1.9, y: 439.41), controlPoint1: CGPoint(x: 0, y: 413.23), controlPoint2: CGPoint(x: 0.63, y: 426.37))
        bezier3Path.addCurve(to: CGPoint(x: 400, y: 466.65), controlPoint1: CGPoint(x: 66.8, y: 449.17), controlPoint2: CGPoint(x: 209.77, y: 466.65))
        bezier3Path.addCurve(to: CGPoint(x: 798.09, y: 439.41), controlPoint1: CGPoint(x: 590.23, y: 466.65), controlPoint2: CGPoint(x: 733.2, y: 449.17))
        bezier3Path.close()
        fillColor3.setFill()
        bezier3Path.fill()
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 316.65, y: 333.34, width: 166.7, height: 166.7))
        fillColor2.setFill()
        ovalPath.fill()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 400, y: 266.66))
        bezier4Path.addCurve(to: CGPoint(x: 250, y: 416.66), controlPoint1: CGPoint(x: 317.28, y: 266.66), controlPoint2: CGPoint(x: 250, y: 333.96))
        bezier4Path.addCurve(to: CGPoint(x: 400, y: 566.65), controlPoint1: CGPoint(x: 250, y: 499.37), controlPoint2: CGPoint(x: 317.29, y: 566.65))
        bezier4Path.addCurve(to: CGPoint(x: 550, y: 416.66), controlPoint1: CGPoint(x: 482.71, y: 566.65), controlPoint2: CGPoint(x: 550, y: 499.36))
        bezier4Path.addCurve(to: CGPoint(x: 400, y: 266.66), controlPoint1: CGPoint(x: 550, y: 333.96), controlPoint2: CGPoint(x: 482.71, y: 266.66))
        bezier4Path.close()
        bezier4Path.move(to: CGPoint(x: 400, y: 483.35))
        bezier4Path.addCurve(to: CGPoint(x: 333.34, y: 416.66), controlPoint1: CGPoint(x: 363.25, y: 483.35), controlPoint2: CGPoint(x: 333.34, y: 453.42))
        bezier4Path.addCurve(to: CGPoint(x: 400, y: 350), controlPoint1: CGPoint(x: 333.34, y: 379.91), controlPoint2: CGPoint(x: 363.24, y: 350))
        bezier4Path.addCurve(to: CGPoint(x: 466.65, y: 416.66), controlPoint1: CGPoint(x: 436.77, y: 350), controlPoint2: CGPoint(x: 466.65, y: 379.91))
        bezier4Path.addCurve(to: CGPoint(x: 400, y: 483.35), controlPoint1: CGPoint(x: 466.65, y: 453.42), controlPoint2: CGPoint(x: 436.77, y: 483.35))
        bezier4Path.close()
        fillColor3.setFill()
        bezier4Path.fill()
        
        context?.saveGState()
        context?.setAlpha(0.2)
        
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 768.55, y: 244.3))
        bezier5Path.addCurve(to: CGPoint(x: 682.86, y: 117.15), controlPoint1: CGPoint(x: 748.41, y: 196.67), controlPoint2: CGPoint(x: 719.58, y: 153.88))
        bezier5Path.addCurve(to: CGPoint(x: 555.71, y: 31.45), controlPoint1: CGPoint(x: 646.11, y: 80.43), controlPoint2: CGPoint(x: 603.32, y: 51.59))
        bezier5Path.addCurve(to: CGPoint(x: 400, y: 0), controlPoint1: CGPoint(x: 506.4, y: 10.59), controlPoint2: CGPoint(x: 454, y: 0))
        bezier5Path.addCurve(to: CGPoint(x: 383.34, y: 0.34), controlPoint1: CGPoint(x: 394.42, y: 0), controlPoint2: CGPoint(x: 388.87, y: 0.12))
        bezier5Path.addCurve(to: CGPoint(x: 522.36, y: 31.45), controlPoint1: CGPoint(x: 431.45, y: 2.3), controlPoint2: CGPoint(x: 478.12, y: 12.73))
        bezier5Path.addCurve(to: CGPoint(x: 649.51, y: 117.15), controlPoint1: CGPoint(x: 570.02, y: 51.59), controlPoint2: CGPoint(x: 612.79, y: 80.44))
        bezier5Path.addCurve(to: CGPoint(x: 735.22, y: 244.3), controlPoint1: CGPoint(x: 686.23, y: 153.88), controlPoint2: CGPoint(x: 715.09, y: 196.67))
        bezier5Path.addCurve(to: CGPoint(x: 766.65, y: 400), controlPoint1: CGPoint(x: 756.1, y: 293.62), controlPoint2: CGPoint(x: 766.65, y: 346.01))
        bezier5Path.addCurve(to: CGPoint(x: 735.22, y: 555.71), controlPoint1: CGPoint(x: 766.65, y: 454), controlPoint2: CGPoint(x: 756.1, y: 506.4))
        bezier5Path.addCurve(to: CGPoint(x: 649.51, y: 682.84), controlPoint1: CGPoint(x: 715.09, y: 603.32), controlPoint2: CGPoint(x: 686.23, y: 646.12))
        bezier5Path.addCurve(to: CGPoint(x: 522.36, y: 768.55), controlPoint1: CGPoint(x: 612.79, y: 719.58), controlPoint2: CGPoint(x: 570.02, y: 748.41))
        bezier5Path.addCurve(to: CGPoint(x: 383.34, y: 799.66), controlPoint1: CGPoint(x: 478.12, y: 787.26), controlPoint2: CGPoint(x: 431.44, y: 797.7))
        bezier5Path.addCurve(to: CGPoint(x: 400, y: 800), controlPoint1: CGPoint(x: 388.87, y: 799.88), controlPoint2: CGPoint(x: 394.42, y: 800))
        bezier5Path.addCurve(to: CGPoint(x: 555.71, y: 768.55), controlPoint1: CGPoint(x: 454, y: 800), controlPoint2: CGPoint(x: 506.4, y: 789.4))
        bezier5Path.addCurve(to: CGPoint(x: 682.86, y: 682.84), controlPoint1: CGPoint(x: 603.32, y: 748.41), controlPoint2: CGPoint(x: 646.11, y: 719.58))
        bezier5Path.addCurve(to: CGPoint(x: 768.55, y: 555.71), controlPoint1: CGPoint(x: 719.58, y: 646.12), controlPoint2: CGPoint(x: 748.41, y: 603.32))
        bezier5Path.addCurve(to: CGPoint(x: 800, y: 400), controlPoint1: CGPoint(x: 789.4, y: 506.4), controlPoint2: CGPoint(x: 800, y: 454))
        bezier5Path.addCurve(to: CGPoint(x: 768.55, y: 244.3), controlPoint1: CGPoint(x: 800, y: 346.01), controlPoint2: CGPoint(x: 789.4, y: 293.62))
        bezier5Path.close()
        fillColor4.setFill()
        bezier5Path.fill()
        
        context?.restoreGState()
        
        
        //// Bezier 6 Drawing
        context?.saveGState()
        context?.setAlpha(0.1)
        
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 31.45, y: 555.71))
        bezier6Path.addCurve(to: CGPoint(x: 117.15, y: 682.84), controlPoint1: CGPoint(x: 51.59, y: 603.32), controlPoint2: CGPoint(x: 80.43, y: 646.12))
        bezier6Path.addCurve(to: CGPoint(x: 244.3, y: 768.55), controlPoint1: CGPoint(x: 153.88, y: 719.58), controlPoint2: CGPoint(x: 196.67, y: 748.41))
        bezier6Path.addCurve(to: CGPoint(x: 400, y: 800), controlPoint1: CGPoint(x: 293.62, y: 789.4), controlPoint2: CGPoint(x: 346.01, y: 800))
        bezier6Path.addCurve(to: CGPoint(x: 416.66, y: 799.66), controlPoint1: CGPoint(x: 405.58, y: 800), controlPoint2: CGPoint(x: 411.13, y: 799.88))
        bezier6Path.addCurve(to: CGPoint(x: 277.63, y: 768.55), controlPoint1: CGPoint(x: 368.55, y: 797.7), controlPoint2: CGPoint(x: 321.86, y: 787.25))
        bezier6Path.addCurve(to: CGPoint(x: 150.49, y: 682.84), controlPoint1: CGPoint(x: 229.99, y: 748.41), controlPoint2: CGPoint(x: 187.22, y: 719.58))
        bezier6Path.addCurve(to: CGPoint(x: 64.77, y: 555.71), controlPoint1: CGPoint(x: 113.76, y: 646.12), controlPoint2: CGPoint(x: 84.93, y: 603.32))
        bezier6Path.addCurve(to: CGPoint(x: 33.34, y: 400), controlPoint1: CGPoint(x: 43.91, y: 506.4), controlPoint2: CGPoint(x: 33.34, y: 454))
        bezier6Path.addCurve(to: CGPoint(x: 64.77, y: 244.3), controlPoint1: CGPoint(x: 33.34, y: 346.01), controlPoint2: CGPoint(x: 43.91, y: 293.62))
        bezier6Path.addCurve(to: CGPoint(x: 150.49, y: 117.16), controlPoint1: CGPoint(x: 84.92, y: 196.67), controlPoint2: CGPoint(x: 113.76, y: 153.88))
        bezier6Path.addCurve(to: CGPoint(x: 277.62, y: 31.45), controlPoint1: CGPoint(x: 187.22, y: 80.43), controlPoint2: CGPoint(x: 229.99, y: 51.59))
        bezier6Path.addCurve(to: CGPoint(x: 416.66, y: 0.34), controlPoint1: CGPoint(x: 321.86, y: 12.73), controlPoint2: CGPoint(x: 368.55, y: 2.3))
        bezier6Path.addCurve(to: CGPoint(x: 400, y: 0), controlPoint1: CGPoint(x: 411.13, y: 0.12), controlPoint2: CGPoint(x: 405.58, y: 0))
        bezier6Path.addCurve(to: CGPoint(x: 244.3, y: 31.45), controlPoint1: CGPoint(x: 346.01, y: 0), controlPoint2: CGPoint(x: 293.62, y: 10.58))
        bezier6Path.addCurve(to: CGPoint(x: 117.15, y: 117.17), controlPoint1: CGPoint(x: 196.67, y: 51.59), controlPoint2: CGPoint(x: 153.88, y: 80.44))
        bezier6Path.addCurve(to: CGPoint(x: 31.44, y: 244.3), controlPoint1: CGPoint(x: 80.43, y: 153.88), controlPoint2: CGPoint(x: 51.59, y: 196.67))
        bezier6Path.addCurve(to: CGPoint(x: 0, y: 400), controlPoint1: CGPoint(x: 10.58, y: 293.62), controlPoint2: CGPoint(x: 0, y: 346.01))
        bezier6Path.addCurve(to: CGPoint(x: 31.45, y: 555.71), controlPoint1: CGPoint(x: 0, y: 454), controlPoint2: CGPoint(x: 10.58, y: 506.4))
        bezier6Path.close()
        fillColor5.setFill()
        bezier6Path.fill()
        bezierPath.append(bezier2Path)
        bezierPath.append(bezier3Path)
        bezierPath.append(bezier4Path)
        bezierPath.append(bezier5Path)
        bezierPath.append(bezier6Path)
        context?.restoreGState()
        bezierPath.close()
        return bezierPath
    }
    
    private func animatePokeball() {
        // Create the animation
        let animation = CAKeyframeAnimation(keyPath: "fillColor")
        animation.values = [
            fillColor.cgColor,
            fillColor2.cgColor,
            fillColor3.cgColor,
            fillColor4.cgColor,
            fillColor5.cgColor
        ]
        animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
        animation.duration = 5  // You can adjust the duration as needed
        animation.repeatCount = .infinity
        
        // Apply the animation to the shape layer
        pokeballLayer.add(animation, forKey: "pokeballAnimation")
    }
}


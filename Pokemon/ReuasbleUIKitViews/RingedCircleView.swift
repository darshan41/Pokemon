//
//  RingedCircleView.swift
//  Pokemon
//
//  Created by Darshan S on 18/02/24.
//

import UIKit

class RingedCircleView: UIView {
    
    var fillingColor: UIColor = UIColor.black.withAlphaComponent(0.3) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let outerRadius: CGFloat = bounds.width / 2.0
        let outerCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let outerPath = UIBezierPath(arcCenter: outerCenter, radius: outerRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        fillingColor.setFill()
        outerPath.fill()
        let innerRadius: CGFloat = outerRadius * 0.7
        let innerPath = UIBezierPath(arcCenter: outerCenter, radius: innerRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
//        UIColor.clear.setFill()
//        innerPath.fill()
        context.addPath(innerPath.cgPath)
        context.clip()
        context.clear(rect)
    }
}


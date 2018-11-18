//
//  DateCollectionViewCell.swift
//  Project
//
//  Created by Pakaporn on 11/18/2561 BE.
//  Copyright © 2561 Pakaporn. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circle: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func drawCircle() {
        let circleCenter = circle.center
        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: (circle.bounds.width/2 - 5), startAngle: -CGFloat.pi/2, endAngle: (2 * CGFloat.pi), clockwise: true)
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 2
        circleLayer.strokeEnd = 0
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = kCALineCapRound
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        circleLayer.add(animation, forKey: nil)
        circle.layer.addSublayer(circleLayer)
        circle.layer.backgroundColor = UIColor.clear.cgColor
    }
}


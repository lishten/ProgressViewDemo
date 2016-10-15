//
//  CircleShapeLayer.swift
//  ProgressViewDemo
//
//  Created by Lishten on 15/12/4.
//  Copyright © 2015年 Lishten. All rights reserved.
//

import UIKit


class CircleShapeLayer: CAShapeLayer {
    
    var startValue:Double!
    var endingValue:Double!
    var status:String!
    var percent:Double!
    var progressLayer:CAShapeLayer!
    var initialProgress:Double!
    
    required override init() {
        super.init()
        self.setUpLayer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func  setUpLayer(){
        self.path = self.drawPathWithArcCenter()
        self.fillColor = UIColor.clearColor().CGColor
        self.lineWidth = 16
        
        self.progressLayer = CAShapeLayer()
        self.progressLayer.path = self.drawPathWithArcCenter()
        self.progressLayer.fillColor = UIColor.yellowColor().CGColor
        self.progressLayer.lineWidth = 16
        self.progressLayer.lineCap = kCALineCapRound
        self.progressLayer.lineJoin = kCALineJoinRound
        self.progressLayer.borderWidth = 0.5
        self.progressLayer.borderColor = UIColor.yellowColor().CGColor
        self.progressLayer.strokeColor = UIColor.redColor().CGColor
        self.addSublayer(self.progressLayer)
    }
    
    override func layoutSublayers() {
        self.path = self.drawPathWithArcCenter()
        self.progressLayer.path = self.drawPathWithArcCenter()
        super.layoutSublayers()
    }
    
    func drawPathWithArcCenter() -> CGPathRef{
        let position_y = self.frame.size.height / 2
        let position_x = self.frame.size.width / 2
        
        let startAge =   CGFloat(-M_PI / 2)
        let endAge = CGFloat((3 * M_PI) / 2)
        let path = UIBezierPath(arcCenter: CGPointMake(position_x, position_y), radius: position_y, startAngle:startAge, endAngle: endAge, clockwise: true).CGPath
        return path
    }
    
    func getEndingValue(endingValue:Double){
        self.initialProgress = self.calculatePercent(startValue, toValue: endingValue)
        self.endingValue = endingValue
        self.percent = self.getPercent()
        if self.percent != 0 {
           self.startAnimation(self.percent)
        } else {
          self.initialProgress = self.calculatePercent(0, toValue: 0)
          self.startAnimation(self.percent)
        }
    }
    
    func getPercent() -> Double{
      self.percent = self.calculatePercent(startValue, toValue: endingValue)
      return percent
    }
    
    func getStartValue(startValue:Double ){
      self.startValue = startValue
    }
    
    func calculatePercent(fromValue:Double, toValue:Double) -> Double{
        if toValue > 0 {
            var percent:Double!
           percent = Double(toValue) / 100.0
           return percent
        } else {
           return 0
        }
    }
    
    func startAnimation(strokeEnd:Double){
//        self.progressLayer.strokeStart = 0.5
//        self.progressLayer.strokeEnd = CGFloat(strokeEnd)
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        pathAnimation.duration = 3
        pathAnimation.fromValue = 0
        pathAnimation.toValue = self.percent
        print(self.percent)
        pathAnimation.removedOnCompletion = false
        self.progressLayer.addAnimation(pathAnimation, forKey: "strokeEnd")
    }
}

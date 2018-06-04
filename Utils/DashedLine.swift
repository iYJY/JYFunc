//
//  DashedLine.swift
//  Tea
//
//  Created by houqinghui on 16/7/25.
//  Copyright © 2016年 yisinian. All rights reserved.
//

import UIKit

class DashedLine: UIView {

    
    override func draw(_ rect: CGRect) {
        //        let context = UIGraphicsGetCurrentContext()
        //        CGContextBeginPath(context)
        //        CGContextSetLineWidth(context, 1)
        //        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        //        let lengths = [CGFloat(5),CGFloat(5)]
        //        CGContextSetLineDash(context, 0, lengths, 2)
        //        CGContextMoveToPoint(context, 0, 0)
        //        CGContextMoveToPoint(context, 100, 0)
        //        CGContextStrokePath(context)
        //CGContextClosePath(context)
        let shapeLayer = CAShapeLayer()
        //shapeLayer.bounds = self.bounds
        //shapeLayer.position = rect.center
        shapeLayer.fillColor = UIColor.clear.cgColor
        //shapeLayer.strokeColor = UIColor.redColor().CGColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.5
        //shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineDashPattern = [2,2]
        let path =  CGMutablePath()    // CGMutablePath()
//        CGPathMoveToPoint(path,nil, 0, 0)
        path.move(to: CGPoint(x: 0, y: 0))
        printLog("self.frame.width++++\(self.frame.width)")
        if self.frame.size.height > self.frame.size.width{
//        CGPathAddLineToPoint(path, nil, 0, self.frame.size.height)
            path.addLine(to: CGPoint(x: 0, y: self.frame.size.height))
        }else {
//        CGPathAddLineToPoint(path, nil, self.frame.width, 0)
            path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        }
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }

    
//     func draw(rect: CGRect) {
////        let context = UIGraphicsGetCurrentContext()
////        CGContextBeginPath(context)
////        CGContextSetLineWidth(context, 1)
////        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
////        let lengths = [CGFloat(5),CGFloat(5)]
////        CGContextSetLineDash(context, 0, lengths, 2)
////        CGContextMoveToPoint(context, 0, 0)
////        CGContextMoveToPoint(context, 100, 0)
////        CGContextStrokePath(context)
//        //CGContextClosePath(context)
//        let shapeLayer = CAShapeLayer()
//        //shapeLayer.bounds = self.bounds
//        //shapeLayer.position = rect.center
//        shapeLayer.fillColor = UIColor.clearColor().CGColor
//            //shapeLayer.strokeColor = UIColor.redColor().CGColor
//        shapeLayer.strokeColor = UIColor.grayColor().CGColor
//        shapeLayer.lineWidth = 0.5
//        //shapeLayer.lineCap = kCALineCapRound
//        shapeLayer.lineDashPattern = [6,2]
//        let path =  CGPathCreateMutable()    // CGMutablePath()
//        CGPathMoveToPoint(path,nil, 0, 0)
//        printLog("self.frame.width++++\(self.frame.width)")
//        CGPathAddLineToPoint(path, nil, self.frame.width, 0)
//        shapeLayer.path = path
//        self.layer.addSublayer(shapeLayer)
//    }
}

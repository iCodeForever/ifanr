//
//  ActivityIndicatorView.swift
//  fffff
//
//  Created by 梁亦明 on 16/7/12.
//  Copyright © 2016年 iCodeForever. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    var animating: Bool = false
    // 颜色
    var DEFAULT_COLOR = UIColor.redColor()
    
    /**
     开始动画
     */
    func startAnimation() {
        if (self.layer.sublayers == nil) {
            setUpAnimationInLayer()
        }
        self.layer.speed = 1
        self.animating = true
        hidden = false
    }
    
    /**
     停止动画
     */
    func stopAnimation() {
        self.layer.sublayers = nil
        self.animating = false
        hidden = true
    }
    
    func setUpAnimationInLayer() {
        let size = self.frame.size
        // 线宽  7条
        let lineSize: CGFloat = 1
        let margin = (size.width-lineSize*7)/6
        let duration: CFTimeInterval = 1
        let beginTime = CACurrentMediaTime()
        
        // 5条曲线的开始时间
        let beginTimes = [0.4, 0.2, 0.1, 0, 0.1, 0.2, 0.4]
        // 时间曲线 快慢快
        let timingFunction = CAMediaTimingFunction(controlPoints: 0.85, 0.25, 0.37, 0.85)
        
        // 创建动画
        let animation = CAKeyframeAnimation(keyPath: "transform.scale.y")
        
        animation.keyTimes = [0, 0.5, 1]
        animation.timingFunctions = [timingFunction, timingFunction]
        animation.values = [1, 0.3, 1]
        animation.duration = duration
        animation.repeatCount = HUGE
        animation.removedOnCompletion = false
        
        // 添加园条
        for i in 0 ..< 7 {
            let line = createLayer(CGSize(width: lineSize, height: size.height), color: DEFAULT_COLOR)
            let frame = CGRect(x: CGFloat(i)*(margin+lineSize),
                               y: 0,
                               width: lineSize,
                               height: size.height)
            
            animation.beginTime = beginTime + beginTimes[i]
            line.frame = frame
            line.addAnimation(animation, forKey: "animation")
            layer.addSublayer(line)
        }
    }
    
    /**
     创建圆条
     */
    func createLayer(size: CGSize, color: UIColor) -> CALayer{
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: size.width, height: size.height),
                                              cornerRadius: size.width / 2)
        layer.fillColor = color.CGColor
        
        layer.path = path.CGPath
        layer.frame = CGRectMake(0, 0, size.width, size.height)
        
        return layer
    }

}
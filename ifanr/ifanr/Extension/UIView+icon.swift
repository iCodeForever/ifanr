//
//  UIView+icon.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

let IPHONE6_HEIGHT: CGFloat  = 667
let HJVIconKey: String       = "HJVIconKey";
let kBaseSize: CGFloat       = 101.0

extension UIView {
    
    func showIcon() -> UIView? {
        
        self.dissmissV()
        let existingActivityView: UIView? = (objc_getAssociatedObject(self, HJVIconKey) as? UIView ?? nil)!;
        var vIcon: UIImageView? = existingActivityView as? UIImageView ?? nil;
        var image: UIImage?  = vIcon?.image
        if existingActivityView == nil {
            vIcon = UIImageView()
            vIcon?.backgroundColor = UIColor.clearColor()
            image = UIImage(imageLiteral: "")
            self.superview?.addSubview(vIcon!)
            objc_setAssociatedObject(self, HJVIconKey, vIcon, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        vIcon?.image = image
        
        let vWidth: CGFloat = (image?.size.width)!
        let vHeight: CGFloat = (image?.size.height)!
        vIcon?.frame = CGRect(x: 0, y: 0, width: vWidth, height: vHeight)
        
        var center: CGPoint = CGPoint(x: self.width * 0.83, y: self.height * 0.83)
        center = self.convertPoint(center, toView: self.superview)
        vIcon?.center = center
        if CGRectGetMaxY((vIcon?.frame)!) > CGRectGetMaxY((self.superview?.frame)!) {
            vIcon?.center = CGPointMake(CGRectGetWidth((self.superview?.frame)!) - vWidth / 2
                , CGRectGetWidth((self.superview?.frame)!) - vHeight / 2)
        }
        
        return vIcon
    }
    
    func dissmissV() {
        
        let existingActivityView: UIView? = (objc_getAssociatedObject(self, HJVIconKey) as? UIView ?? nil)! ;
        
        if existingActivityView != nil {
            existingActivityView?.removeFromSuperview()
            objc_setAssociatedObject(self, HJVIconKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    func uxy_roundedRectWith(radius: CGFloat, corners: UIRectCorner) -> UIView{
        let maskPath: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSizeMake(radius, radius));
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.CGPath
        self.layer.mask = maskLayer
        
        return self
    }
}
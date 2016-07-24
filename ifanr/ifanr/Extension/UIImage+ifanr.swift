//
//  UIImage+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/24.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation


extension UIImage {
    func imageByApplyingAlpha(alpha: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        
        let ctx = UIGraphicsGetCurrentContext()
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        CGContextScaleCTM(ctx, 1, -1)
        CGContextTranslateCTM(ctx, 0, -area.size.height)
        
        CGContextSetBlendMode(ctx, .Multiply)
        
        CGContextSetAlpha(ctx, alpha)
        
        CGContextDrawImage(ctx, area, self.CGImage)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
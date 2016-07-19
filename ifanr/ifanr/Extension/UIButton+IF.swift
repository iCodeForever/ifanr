//
//  UIButton+IF.swift
//  ifanr
//
//  Created by sys on 16/7/19.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension UIButton {
    
    
    /*!
     
     - author: dby
     重载UIButton，实现 上图下文字的形式
     
     - parameter spacing: 图片与文字之间的距离
     
     */
    func setVertical(spacing: CGFloat)
    {
        self.titleLabel!.backgroundColor = UIColor.greenColor();
        let imageSize: CGSize   = self.imageView!.frame.size;
        var titleSize: CGSize   = self.titleLabel!.frame.size;
        let textSize: CGSize    = ((self.titleLabel!.text! as NSString)).sizeWithAttributes([NSFontAttributeName: (self.titleLabel?.font)!])
        let frameSize: CGSize   = CGSizeMake(textSize.width, textSize.height);
        if (titleSize.width + 0.5) < frameSize.width {
            titleSize.width = frameSize.width;
        }
        let totalHeight: CGFloat = (imageSize.height + titleSize.height + spacing);
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0);
    }
}
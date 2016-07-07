//
//  UIImageView+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension UIImageView {
    func if_setImage(imageURL: NSURL!) {
        self.yy_setImageWithURL(imageURL, placeholder: UIImage(named: "place_holder_image"), options: [.SetImageWithFadeAnimation, .ProgressiveBlur], completion: nil)
    }
}
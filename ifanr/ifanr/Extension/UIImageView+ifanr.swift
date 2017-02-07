//
//  UIImageView+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension UIImageView {
    /**
     异步请求网络图片
     */
    func if_setImage(_ imageURL: URL!) {
        self.yy_setImage(with: imageURL, placeholder: UIImage(named: "place_holder_image"), options: [.setImageWithFadeAnimation, .progressiveBlur], completion: nil)
    }
    
    func if_setAvatarImage(_ url: URL!) {
        self.yy_setImage(with: url, placeholder: UIImage(named: "place_holder_avatar"), options: [.setImageWithFadeAnimation, .progressiveBlur], completion: nil)
    }
}

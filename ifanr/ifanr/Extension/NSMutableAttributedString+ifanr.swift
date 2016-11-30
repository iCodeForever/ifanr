//
//  NSMutableAttributedString+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension NSMutableAttributedString {
    /**
     全部设置行间距 5
     */
    class func attribute(_ text: String) -> NSMutableAttributedString {
        let attribute = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attribute.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: text.length))
        
        return attribute
    }
}

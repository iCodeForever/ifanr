//
//  String+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/7.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension String {
    /// 获取字符串长度
    var length : Int {
        return characters.count
    }
    
    /**
     获得符合正则表达式的字符串集合
     - parameter pattern: 正则表达式
     - returns: 字符串集合
     */
    func getSuitableString(pattern: String) -> [String]{
        
        do {
            let pattern = pattern
            let regex   = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let res     = regex.matchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count))
            var subStrArray = [String]()
            for checkingRes in res {
                let subStr = (self as NSString).substringWithRange(checkingRes.range)
                subStrArray.append(subStr)
            }
            return subStrArray
        }
        catch {
            print(error)
        }
        
        return [String]()
    }
}

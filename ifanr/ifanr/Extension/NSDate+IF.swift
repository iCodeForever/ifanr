//
//  NSDate.swift
//  ifanr
//
//  Created by sys on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension NSDate {
    // 获取今天日期
    class func today() -> String {
        let dataFormatter : NSDateFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        let now : NSDate = NSDate()
        return dataFormatter.stringFromDate(now)
    }
    
    // 判断是否是今天
    class func isToday (dateString : String) -> Bool {
        return dateString == self.today()
    }
    
    // 获得两个时间的时间间隔
    class func getTimeIntervalFromNow (dateString : String) -> NSTimeInterval {
        if dateString.characters.count <= 0 {
            return 0
        }
        
        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "Asia/Beijing")
        
        let dateBefore = formatter.dateFromString(dateString)
        
        return (dateBefore?.timeIntervalSinceNow)!
    }
    
    /**
     *  获取当前时间戳
     */
    class func getCurrentTimeStamp() -> String {
        let timeStamp : String = "\(Int64(floor(NSDate().timeIntervalSince1970 * 1000)))"
        return timeStamp
    }
}

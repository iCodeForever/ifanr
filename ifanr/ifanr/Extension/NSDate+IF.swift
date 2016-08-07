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
        formatter.dateStyle  = NSDateFormatterStyle.MediumStyle
        formatter.dateStyle  = NSDateFormatterStyle.ShortStyle
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone   = NSTimeZone(name: "Asia/Beijing")
        
        let dateBefore = formatter.dateFromString(dateString)
        
        return (dateBefore?.timeIntervalSinceNow)!
    }
    
    class func getCommonExpressionOfDate(dateString: String) -> String {
        
        var resStr = ""
        let timeInterval = (NSDate.getTimeIntervalFromNow(dateString) * -1)/60/60
        if timeInterval < 1 {
            resStr = "\(Int(timeInterval*60)) 分钟前"
        } else if timeInterval < 24 {
            resStr = "\(Int(timeInterval)) 小时前"
        } else if timeInterval < 48 {
            let range = NSRange(location: 10, length: 6)
            resStr = "昨天 " + (dateString as NSString).substringWithRange(range)
        } else if timeInterval < 72 {
            let range = NSRange(location: 10, length: 6)
            resStr = "前天 " + (dateString as NSString).substringWithRange(range)
        } else {
            var timeStr: String = ""
            if let tmpArray: Array = (dateString.componentsSeparatedByString(" ")) {
                if let monthDayArray: Array = tmpArray[0].componentsSeparatedByString("-") {
                    timeStr = monthDayArray[1] + "月" + monthDayArray[2] + "日"
                }
                let range   = NSRange(location: 0, length: 5)
                timeStr     = timeStr + " " + ((tmpArray[1] as NSString).substringWithRange(range))
            }
            resStr = timeStr
        }
        return resStr
    }
    
    /**
     将yyyy-MM-dd HH:mm:ss装换成MM月dd日 HH:mm
     
     - parameter timeStamp: 时间戳
     */
    class func getDate(date: String) -> String{
        let lastFormatter = NSDateFormatter()
        lastFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastDate = lastFormatter.dateFromString(date)
        
        let currFormatter = NSDateFormatter()
        currFormatter.dateFormat = "MM月dd日 HH:mm"
        return currFormatter.stringFromDate(lastDate!)
    }
    
    /**
     *  获取当前时间戳
     */
    class func getCurrentTimeStamp() -> String {
        let timeStamp : String = "\(Int64(floor(NSDate().timeIntervalSince1970 * 1000)))"
        return timeStamp
    }
    
    /*
     * 比较两个时间
     */
    class func isEarlier(dateStr1: String!, dateStr2: String!) -> Bool {
        
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.dateFromString(dateStr1)
        let date2 = dateFormatter.dateFromString(dateStr2)
        
        if date1?.compare(date2!) == NSComparisonResult.OrderedAscending {
            return true
        } else {
            return false
        }
    }
}

//
//  NSDate.swift
//  ifanr
//
//  Created by sys on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

extension Date {
    // 获取今天日期
    static func today() -> String {
        let dataFormatter : DateFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        let now : Date = Date()
        return dataFormatter.string(from: now)
    }
    
    // 判断是否是今天
    static func isToday (_ dateString : String) -> Bool {
        return dateString == self.today()
    }
    
    // 获得两个时间的时间间隔
    static func getTimeIntervalFromNow (_ dateString : String) -> TimeInterval {
        if dateString.characters.count <= 0 {
            return 0
        }
        
        let formatter : DateFormatter = DateFormatter()
        formatter.dateStyle  = DateFormatter.Style.medium
        formatter.dateStyle  = DateFormatter.Style.short
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone   = TimeZone(identifier: "Asia/Beijing")
        
        let dateBefore = formatter.date(from: dateString)
        
        return (dateBefore?.timeIntervalSinceNow)!
    }
    
    static func getCommonExpressionOfDate(_ dateString: String) -> String {
        
        var resStr = ""
        let timeInterval = (Date.getTimeIntervalFromNow(dateString) * -1)/60/60
        if timeInterval < 1 {
            resStr = "\(Int(timeInterval*60)) 分钟前"
        } else if timeInterval < 24 {
            resStr = "\(Int(timeInterval)) 小时前"
        } else if timeInterval < 48 {
            let range = NSRange(location: 10, length: 6)
            resStr = "昨天 " + (dateString as NSString).substring(with: range)
        } else if timeInterval < 72 {
            let range = NSRange(location: 10, length: 6)
            resStr = "前天 " + (dateString as NSString).substring(with: range)
        } else {
            var timeStr: String = ""
            if let tmpArray: Array = (dateString.components(separatedBy: " ")) {
                if let monthDayArray: Array = tmpArray[0].components(separatedBy: "-") {
                    timeStr = monthDayArray[1] + "月" + monthDayArray[2] + "日"
                }
                let range   = NSRange(location: 0, length: 5)
                timeStr     = timeStr + " " + ((tmpArray[1] as NSString).substring(with: range))
            }
            resStr = timeStr
        }
        return resStr
    }
    
    /**
     将yyyy-MM-dd HH:mm:ss装换成MM月dd日 HH:mm
     
     - parameter timeStamp: 时间戳
     */
    static func getDate(_ date: String) -> String{
        let lastFormatter = DateFormatter()
        lastFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let lastDate = lastFormatter.date(from: date)
        
        let currFormatter = DateFormatter()
        currFormatter.dateFormat = "MM月dd日 HH:mm"
        return currFormatter.string(from: lastDate!)
    }
    
    /**
     *  获取当前时间戳
     */
    static func getCurrentTimeStamp() -> String {
        let timeStamp : String = "\(Int64(floor(Date().timeIntervalSince1970 * 1000)))"
        return timeStamp
    }
    
    /*
     * 比较两个时间
     */
    static func isEarlier(_ dateStr1: String!, dateStr2: String!) -> Bool {
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date1 = dateFormatter.date(from: dateStr1)
        let date2 = dateFormatter.date(from: dateStr2)
        
        if date1?.compare(date2!) == ComparisonResult.orderedAscending {
            return true
        } else {
            return false
        }
    }
}

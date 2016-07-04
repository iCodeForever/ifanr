//
//  APIConstant.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Foundation
import Moya

/// https://www.ifanr.com/api/v3.0/?action=hot_features&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=0&posts_per_page=5&sign=be072a0fc0b7020836bae8777f2fbeca&timestamp=1467296033
public enum APIConstant {
    /**
     *  首页-热门（5条导航）参数 page, posts_per_page
     *
     *  @param String action参数：请求api的标识   例如hot_features 是首页的导航前5条热门数据
     *  @param Int    page请求的页数
     *  @param Int    posts_per_page请求页数的条数
     *
     */
    case Home_hot_features(Int, Int)
}

extension APIConstant: TargetType {
    
        /// appKey
    public var appKey: String {
        return "sg5673g77yk72455af4sd55ea"
    }
    
    public var excerpt_length: Int {
        return 80
    }
    
    public var sign: String {
        return "be072a0fc0b7020836bae8777f2fbeca"
    }
    
        /// 当前时间的时间戳
    public var timestamp: String {
        return NSDate.getCurrentTimeStamp()
    }

        /// url
    public var baseURL: NSURL {
        return NSURL(string: "https://www.ifanr.com/api/v3.0/")!
    }
    
    public var baseParams:Dictionary<String, AnyObject> {
        return ["appKey": appKey, "excerpt_length": excerpt_length, "sign": sign, "timestamp": timestamp]
    }
    
    //MARK: --------------------------- Path --------------------------
    
        /// 路径
    public var path: String {
        switch self {
//        case .Home_hot_features(_,_):
//            return ""
            
        default:
            return ""
        }
    }
    
    
        /// 请求方法
    public var method: Moya.Method {
        switch self {
        case .Home_hot_features(_,_):
            return .POST
        }
    }
    
        /// 请求参数
    public var parameters: [String: AnyObject]? {
        
        switch self {
    
        case let .Home_hot_features(page, posts_per_page):
            return ["action": "hot_features", "appKey": appKey, "excerpt_length": excerpt_length, "sign": sign, "timestamp": timestamp, "page":page, "posts_per_page": posts_per_page]
        }
    }
    
        /// 单元测试用
    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
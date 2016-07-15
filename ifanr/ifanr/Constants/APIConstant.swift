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

/// https://www.ifanr.com/api/v3.0/?action=ifr_m_latest&appkey=sg5673g77yk72455af4sd55ea&excerpt_length=80&page=1&post_type=post%2Cnews%2Cdasheng%2Cdata&posts_per_page=12&sign=be072a0fc0b7020836bae8777f2fbeca&timestamp=1467296033
                                                                           
public enum APIConstant {
    /**
     *  首页-热门（5条导航）参数 page, posts_per_page
     *
     *  @param Int    page请求的页数
     *  @param Int    posts_per_page请求页数的条数
     *
     */
    case Home_hot_features(Int, Int)
    
    /**
     *  首页-列表 每次请求12条
     *
     *  @param Int 参数page 分页数从1开始
     *
     */
    case Home_latest(Int)
}

extension APIConstant: TargetType {
    //MARK: ---------------------------基本默认要传入的参数 --------------------------
        /// appKey
    private var appKey: String {
        return "sg5673g77yk72455af4sd55ea"
    }
    
    private var excerpt_length: Int {
        return 80
    }
    
    private var sign: String {
        return "be072a0fc0b7020836bae8777f2fbeca"
    }
    
        /// 当前时间的时间戳
    private  var timestamp: String {
        return NSDate.getCurrentTimeStamp()
    }
   
        /// 这个不知什么鬼。首页那里用到
    private var post_type: String {
        return "post%2Cnews%2Cdasheng%2Cdata".stringByRemovingPercentEncoding!
    }
    
    //MARK: --------------------------- Path --------------------------
        /// url
    public var baseURL: NSURL {
        return NSURL(string: "https://www.ifanr.com/api/v3.0/")!
    }
        /// 路径
    public var path: String {
        return ""
    }
        /// 请求方法
    public var method: Moya.Method {
        return .GET
    }
    
        /// 请求参数
    public var parameters: [String: AnyObject]? {
        
        switch self {
    
        case let .Home_hot_features(page, posts_per_page):
            return ["action": "hot_features", "appKey": appKey, "excerpt_length": excerpt_length, "sign": sign, "timestamp": timestamp, "page": page, "posts_per_page": posts_per_page]
            
        case let .Home_latest(page):
            return ["action": "ifr_m_latest", "appKey": appKey, "excerpt_length": excerpt_length, "sign": sign,
                    "timestamp": timestamp, "page": page, "post_type": post_type, "posts_per_page": 12]
        }
    }
    
        /// 单元测试用
    public var sampleData: NSData {
        return "{}".dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
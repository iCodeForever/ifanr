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
   
public enum APIConstant {
    /**
     *  首页-热门（5条导航）参数 page, posts_per_page
     *
     *  @param Int    page请求的页数
     *
     */
    case home_hot_features(Int)
    
    /**
     *  首页-列表 每次请求12条
     *
     *  @param Int 参数page 分页数从1开始
     *
     */
    case home_latest(Int)
    
    /**
     *  快讯-列表
     *
     *  @param Int 分页数
     */
    case newsFlash_latest(Int)
    
    /**
     *  玩物志
     *
     *  @param Int 分页数
     */
    case playingZhi_latest(Int)
    
    /**
     *  AppSo
     *
     */
    case appSo_latest(Int)
    
    /**
     *  MainStore  从0开始
     */
    case mindStore_latest(Int)
    
    /**
     *  MindStore详情页的头像  id
     */
    case mindStore_Detail_Vote(String)
    
    /**
     *  MindStore详情页的评论  id offset
     */
    case mindStore_Detail_Comments(String, Int)
    
    /**
     *  分类
     */
    case category(CategoryName,Int)
    
    /**
     *  获得评论
     */
    case comments_latest(String)
}

/**
 分类类型
 
 - Video:      视频
 - ISeed:      ISeed
 - DaSheng:    大声
 - Shudu:      数读
 - Evaluation: 评测
 - Product:    参评
 - Car:        汽车
 - Business:   商业
 - Interview:  访谈
 - Picture:    图记
 - List:       清单
 */
public enum CategoryName {
    case video
    case iSeed
    case daSheng
    case shudu
    case evaluation
    case product
    case car
    case business
    case interview
    case picture
    case list
    
    /**
     获取分类名字
     */
    func getName() -> String {
        switch self {
        case .video:
            return "video-special"
        case .iSeed:
            return "iseed"
        case .daSheng:
            return "dasheng"
        case .shudu:
            return "data"
        case .evaluation:
            return "review"
        case .product:
            return "product"
        case .car:
            return "intelligentcar"
        case .business:
            return "business"
        case .interview:
            return "interview"
        case .picture:
            return "tuji"
        case .list:
            return "%E6%B8%85%E5%8D%95".removingPercentEncoding!
        }
    }
}

extension APIConstant: TargetType {
    

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    public var task: Task {
        switch self {
        default:
            return .request
        }
    }

    //MARK: ---------------------------基本默认要传入的参数 --------------------------
        /// appKey
    fileprivate var appKey: String {
        return "sg5673g77yk72455af4sd55ea"
    }
    
    fileprivate var excerpt_length: Int {
        return 80
    }
    
    fileprivate var sign: String {
        return "be072a0fc0b7020836bae8777f2fbeca"
    }
    
        /// 当前时间的时间戳
    fileprivate  var timestamp: String {
        return Date.getCurrentTimeStamp()
    }
  
        /// 这个不知什么鬼。首页那里用到
    fileprivate var post_type: String {
        switch self {
        case .home_latest(_), .home_hot_features(_):
            return "post%2Cnews%2Cdasheng%2Cdata".removingPercentEncoding!
        case .newsFlash_latest(_):
            return "buzz"
        case .playingZhi_latest(_):
            return "coolbuy"
        case .appSo_latest(_):
            return "app"
        case let .category(type, _):
            return type.getName()
            
        default: return ""
        }
    }
    
    fileprivate var action: String {
        switch self {
        case .home_hot_features(_):
            return "hot_features"
        case .comments_latest(_):
            return "ifr_m_get_mobile_comments"
        default:
            return "ifr_m_latest"
        }
    }
    
    fileprivate var posts_per_page: Int {
        switch self {
        case .home_hot_features(_):
            return 5
        default:
            return 12
        }
    }
    
    //MARK: --------------------------- Path --------------------------
        /// url
    
    public var baseURL: URL {
        switch self {
            /// https://sso.ifanr.com/api/v1.2/mind/?look_back_days=0&limit=60
        case .mindStore_latest(_), .mindStore_Detail_Vote(_), .mindStore_Detail_Comments(_,_):
            return URL(string: "https://sso.ifanr.com/api/v1.2/mind/")!
        default:
            return URL(string: "https://www.ifanr.com/api/v3.0/")!
        }
        
    }
        /// 路径
    public var path: String {
        
        switch self {
        case let .mindStore_Detail_Vote(id):
            return "vote/\(id)"
            
        case .mindStore_Detail_Comments(_,_):
            return "comment/"
        default:
            return ""
        }
    }
        /// 请求方法
    public var method: Moya.Method {
        return .get
    }
    
        /// 请求参数
    public var parameters: [String: Any]? {
        switch self {
                    /// 首页热门
        case let .home_hot_features(page):
            return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
                    /// 首页列表
        case let .home_latest(page):
            return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
                    /// 快讯列表
        case let .newsFlash_latest(page):
            return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
                    /// 玩物志列表
        case let .playingZhi_latest(page):
            return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
                    /// AppSo
        case let .appSo_latest(page):
            return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
                    /// MindStore
        case let .mindStore_latest(page):
            return ["look_back_days": page as AnyObject, "limit": 60 as AnyObject]
                    /// 详情页评论
        case let .comments_latest(id):
            return ["action":action as AnyObject, "appKey": appKey as AnyObject, "post_id":id as AnyObject ,"sign": sign as AnyObject, "timestamp": timestamp as AnyObject]
                    /// 分类
        case let .category(type,page):
            // 大声， 数读，图记不需要传category_name参数，不然请求不到，所以这里处理了一下
            if type == CategoryName.daSheng || type == CategoryName.shudu || type == CategoryName.picture {
                return ["action": action as AnyObject, "appKey": appKey as AnyObject, "excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page as AnyObject, "post_type": post_type]
            } else {
                return ["action": action as AnyObject, "appKey": appKey as AnyObject, "category_name": type.getName() as AnyObject,"excerpt_length": excerpt_length as AnyObject, "sign": sign as AnyObject, "timestamp": timestamp as AnyObject, "page": page as AnyObject, "posts_per_page": posts_per_page, "post_type": post_type]
            }
                    /// 分类评论
        case let .mindStore_Detail_Comments(id, offset):
            return ["mind": id as AnyObject, "limit": 12 as AnyObject, "offset": offset as AnyObject]
            
        default:
            return nil
        }
    }
    
        /// 单元测试用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    public var multipartBody: [MultipartFormData]? {
        return nil
    }

}

//
//  IFanrService.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Moya

class IFanrService {
        /// 单例对象
    static let shareInstance = IFanrService()
    lazy var ifanrProvider = MoyaProvider<APIConstant>()
    private init() {}
    
    //MARK: --------------------------- Public Methods --------------------------
    
    /**
     获取首页热门5条信息
     
     - parameter page:           页数
     - parameter posts_per_page: 每一页返回多少条
     - parameter successHandle:  请求成功回调
     - parameter errorHandle:    请求错误回调
     */
    func getHomeHotData(page: Int, posts_per_page: Int, successHandle: ((Array<HomePopularModel>) -> Void)? , errorHandle: ((Error) -> Void)?) {
        ifanrProvider.request(APIConstant.Home_hot_features(page, posts_per_page)) { (result) in
            switch result {
                // 请求成功
            case let .Success(response):
                do {
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        // 获取Data数组
                        if let content = json["data"] as? Array<AnyObject> {
                            // 字典转模型， 放到异步去处理好一点
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                                let modelArray = content.map({ (dict) -> HomePopularModel in
                                    return HomePopularModel(dict: dict as! NSDictionary)
                                })
                                // 成功回调
                                dispatch_async(dispatch_get_main_queue(), {
                                    if let success = successHandle {
                                        success(modelArray)
                                    }
                                })
                            })
                        } else {
                            print("没有数据")
                        }
                    } else {
                        print("没有数据")
                    }
                } catch {
                    print("出现异常")
                }
                
//                success!(response)
                
                // 如果出现错误
            case let .Failure(error):
                // 错误回调
                if let handle = errorHandle {
                    handle(error)
                }
            }
        }
    }
    
    /**
     获取首页列表数据
     
     - parameter page:          请求的页数
     - parameter successHandle: 请求成功回调
     - parameter errorHandle:   请求失败回调
     */
    
    func getHomeLatestData(page: Int, successHandle: (Array<HomePopularLayout> -> Void)?, errorHandle:((Error) -> Void)?) {
        ifanrProvider.request(APIConstant.Home_latest(page)) { (result) in
            switch result {
            case let .Success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        // 获取Data数组
                        if let content = json["data"] as? Array<AnyObject> {
                            // 放到异步去处理字典转模型，提前计算好cell的高度。
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { 
                                let layoutArray = content.map({ (dict) -> HomePopularLayout in
                                    return HomePopularLayout(model: HomePopularModel(dict: dict as! NSDictionary))
                                })
                                
                                dispatch_async(dispatch_get_main_queue(), { 
                                    if let success = successHandle {
                                        success(layoutArray)
                                    }
                                })
                            })
                        } else {
                            print("没有数据")
                        }
                    } else {
                        print("没有数据")
                    }
                } catch {
                    print("出现异常")
                }
                
            case let .Failure(error):
                // 错误回调
                if let handle = errorHandle {
                    handle(error)
                }
            }
        }
        
    }
}
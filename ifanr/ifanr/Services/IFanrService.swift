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
     获取首页列表数据
     
     - parameter page:          请求的页数
     - parameter successHandle: 请求成功回调
     - parameter errorHandle:   请求失败回调
     */
    
    func getLatestLayout(target: APIConstant, successHandle: (Array<HomePopularLayout> -> Void)?, errorHandle:((Error) -> Void)?) {
        ifanrProvider.request(target) { (result) in
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
                                    return HomePopularLayout(model: CommonModel(dict: dict as! NSDictionary))
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
    
    /*!
     - parameter t: 这个参数并无意义，只为 推算出 T的类型
     - note: 此函数仍然有 冗余代码、无效参数，需要再次调整
     */
    func getData<T : Initable>(target: APIConstant, t: T?, keys: Array<String>, successHandle: (Array<T> -> Void)?, errorHandle:((Error) -> Void)?) {
        
        ifanrProvider.request(target) { (result) in
            switch result {
            case let .Success(response):
                do {
                    // 获取json数据
                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
                    if let json = json {
                        // 获取Data数组
                        if keys.count == 1 {
                            if let content = json[keys[0]] as? Array<AnyObject> {
                                // 放到异步去处理字典转模型，提前计算好cell的高度。
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                    let modelArray = content.map({ (dict) -> T in
                                            return T(dict: dict as! NSDictionary)
                                    })
                                    
                                    dispatch_async(dispatch_get_main_queue(), {
                                        if let success = successHandle {
                                            success(modelArray)
                                        }
                                    })
                                })
                            } else {
                                print("没有数据")
                            }
                        } else if keys.count == 2 {
                            if let content = json[keys[0]] as? Dictionary<String, AnyObject> {
                                if let alls = (content[keys[1]] as? Array<AnyObject>) {
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                                        let allsArray = alls.map({ (dict) -> T in
                                            return T(dict: dict as! NSDictionary)
                                        })
                                        
                                        dispatch_async(dispatch_get_main_queue(), {
                                            if let success = successHandle {
                                                success(allsArray)
                                            }
                                        })
                                    })
                                }
                            } else {
                                print("没有数据")
                            }
                        }
                        
                    } else {
                        print("没有数据")
                    }
                } catch {
                    print("出现异常")
                }
                
            case let .Failure(error):
                if let handle = errorHandle {
                    handle(error)
                }
            }
        }
    }
    
    /**
     获取列表数据
     
     - parameter page:          分页数
     - parameter successHandle: 成功回调
     - parameter errorHandle:   失败回调
     */
//    func getLatesModel(target: APIConstant, successHandle: (Array<CommonModel> -> Void)?, errorHandle:((Error) -> Void)?) {
//        
//        ifanrProvider.request(target) { (result) in
//            switch result {
//            case let .Success(response):
//                do {
//                    // 获取json数据
//                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
//                    if let json = json {
//                        // 获取Data数组
//                        if let content = json["data"] as? Array<AnyObject> {
//                            // 放到异步去处理字典转模型，提前计算好cell的高度。
//                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                                let modelArray = content.map({ (dict) -> CommonModel in
//                                    return CommonModel(dict: dict as! NSDictionary)
//                                })
//                                
//                                dispatch_async(dispatch_get_main_queue(), {
//                                    if let success = successHandle {
//                                        success(modelArray)
//                                    }
//                                })
//                            })
//                        } else {
//                            print("没有数据")
//                        }
//                    } else {
//                        print("没有数据")
//                    }
//                    
//                } catch {
//                    print("出现异常")
//                }
//            case let .Failure(error):
//                if let handle = errorHandle {
//                    handle(error)
//                }
//            }
//        }
//    }
    
//    func getMindStoreData(page: Int, successHandle: (Array<MindStoreModel> -> Void)?, errorHandle:((Error) -> Void)?) {
//        
//        ifanrProvider.request(APIConstant.MindStore_latest(page)) { (result) in
//            switch result {
//            case let .Success(response):
//                do {
//                    // 获取json数据
//                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
//                    if let json = json {
//                        // 获取Data数组
//                        if let content = json["objects"] as? Array<AnyObject> {
//                            // 放到异步去处理字典转模型，提前计算好cell的高度。
//                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                                let modelArray = content.map({ (dict) -> MindStoreModel in
//                                    return MindStoreModel(dict: dict as! NSDictionary)
//                                })
//                                
//                                dispatch_async(dispatch_get_main_queue(), {
//                                    if let success = successHandle {
//                                        success(modelArray)
//                                    }
//                                })
//                            })
//                        } else {
//                            print("没有数据")
//                        }
//                    } else {
//                        print("没有数据")
//                    }
//                    
//                } catch {
//                    print("出现异常")
//                }
//            case let .Failure(error):
//                if let handle = errorHandle {
//                    handle(error)
//                }
//            }
//        }
//    }
    
//    func getCommentData(id: String, successHandel: (Array<CommentModel> -> Void)?, errorHandle:((Error) -> Void)?) {
//        ifanrProvider.request(APIConstant.Comments_latest(id)) { (result) in
//            switch result {
//            case let .Success(response):
//                do {
//                    // 获取JSON数据
//                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
//                    if  let json = json {
//                        //获取Data数组
//                        if let content = json["data"] as? Dictionary<String, AnyObject> {
//                            
//                            if let alls = (content["all"] as? Array<AnyObject>) {
//                                
//                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                                    let allsArray = alls.map({ (dict) -> CommentModel in
//                                        return CommentModel(dict: dict as! NSDictionary)
//                                    })
//                                    
//                                    dispatch_async(dispatch_get_main_queue(), {
//                                        if let success = successHandel {
//                                            success(allsArray)
//                                        }
//                                    })
//                                })
//                            }
//                        } else {
//                            print("没有数据")
//                        }
//                    } else {
//                        print("没有数据")
//                    }
//                } catch {
//                    print("出现异常")
//                }
//            case let .Failure(error):
//                if let handle = errorHandle {
//                    handle(error)
//                }
//            }
//        }
//    }
    
//    func getMindStoreVotedData(id: String, successHandle: (Array<MindStoreVoteModel> -> Void)?, errorHandle:((Error) -> Void)?) {
//        ifanrProvider.request(APIConstant.MindStore_Detail_Vote(id)) { (result) in
//            switch result {
//            case let .Success(response):
//                do {
//                    // 获取json数据
//                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
//                    if let json = json {
//                        // 获取Data数组
//                        if let content = json["voted_user"] as? Array<AnyObject> {
//                            // 放到异步去处理字典转模型，提前计算好cell的高度。
//                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                                let modelArray = content.map({ (dict) -> MindStoreVoteModel in
//                                    return MindStoreVoteModel(dict: dict as! NSDictionary)
//                                })
//                                
//                                dispatch_async(dispatch_get_main_queue(), {
//                                    if let success = successHandle {
//                                        success(modelArray)
//                                    }
//                                })
//                            })
//                        } else {
//                            print("没有数据")
//                        }
//                    } else {
//                        print("没有数据")
//                    }
//                    
//                } catch {
//                    print("出现异常")
//                }
//            case let .Failure(error):
//                if let handle = errorHandle {
//                    handle(error)
//                }
//            }
//        }
//    }
    
    
//    func getMindStoreCommentData(target: APIConstant, successHandle: (Array<MindStoreCommentModel> -> Void)?, errorHandle:((Error) -> Void)?) {
//        ifanrProvider.request(target) { (result) in
//            switch result {
//            case let .Success(response):
//                do {
//                    // 获取json数据
//                    let json = try response.mapJSON() as? Dictionary<String, AnyObject>
//                    if let json = json {
//                        // 获取Data数组
//                        if let content = json["objects"] as? Array<AnyObject> {
//                            // 放到异步去处理字典转模型，提前计算好cell的高度。
//                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                                let modelArray = content.map({ (dict) -> MindStoreCommentModel in
//                                    return MindStoreCommentModel(dict: dict as! NSDictionary)
//                                })
//                                
//                                dispatch_async(dispatch_get_main_queue(), {
//                                    if let success = successHandle {
//                                        success(modelArray)
//                                    }
//                                })
//                            })
//                        } else {
//                            print("没有数据")
//                        }
//                    } else {
//                        print("没有数据")
//                    }
//                    
//                } catch {
//                    print("出现异常")
//                }
//            case let .Failure(error):
//                if let handle = errorHandle {
//                    handle(error)
//                }
//            }
//        }
//    }
}
//
//  Request+ifanr.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Alamofire
import SwiftyJSON

extension Request {
    /**
     请求网络
     */
    public func responseSwiftyJSON(completionHandler: (NSURLRequest, NSHTTPURLResponse?, SwiftyJSON.JSON, ErrorType?) -> Void) -> Self {
        return responseSwiftyJSON(nil, options:NSJSONReadingOptions.AllowFragments, completionHandler:completionHandler)
    }
    
    public func responseSwiftyJSON(queue: dispatch_queue_t? = nil, options: NSJSONReadingOptions = .AllowFragments,     completionHandler: (NSURLRequest, NSHTTPURLResponse?, JSON, ErrorType?) -> Void) -> Self {
        
        return responseJSON(options: options, completionHandler: { (response) -> Void in
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                var responseJSON : JSON
                if response.result.error != nil {
                    responseJSON = JSON.null
                } else {
                    responseJSON = SwiftyJSON.JSON(response.result.value!)
                }
                dispatch_async(queue ?? dispatch_get_main_queue(), {
                    completionHandler(self.request!, self.response, responseJSON, response.result.error)
                })
                
            })
        })
    }
}

/**
 例子
 
 参数 method 请求方法
    api  请求api
    params 参数
 
Alamofire.request(method, api, params).responseSwiftyJSON ({ [unowned self](request, response, json, error) -> Void in
    
    if json != .null && error == nil{
        let jsonArray = json.arrayValue
        self.modelArray = jsonArray.map({ (dict) -> EYEDiscoverModel in
            return EYEDiscoverModel(dict: dict.rawValue as! NSDictionary)
        })
        self.collectionView.reloadData()
    }
    self.setLoaderViewHidden(true)
    })
 */
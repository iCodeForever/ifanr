//
//  MindStoreDataModel.swift
//  ifanr
//
//  Created by sys on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

struct CreateBy {
    var avatar_url: String!
    var company: String!
    var id: Int64!
    var lime_home_url: String!
    var nickname: String!
    var position: String!
    var wechat_screenname: String!
    
    init(dict: NSDictionary) {
        self.avatar_url = dict["avatar_url"] as? String ?? ""
        self.company    = dict["company"] as? String ?? ""
        self.id         = dict["id"] as? Int64 ?? 0
        self.lime_home_url = dict["lime_home_url"] as? String ?? ""
        self.nickname   = dict["nickname"] as? String ?? ""
        self.position   = dict["position"] as? String ?? ""
        self.wechat_screenname = dict["wechat_screenname"] as? String ?? ""
    }
}

struct ChildCommentModel {
    
    var content: String!
    var created_at: String!
    var created_by: CreateBy!
    var id: Int64!
    var is_producer: Bool!
    var level: Int64!
    var left: Int64!
    var wechat_screenname: String!
    var parentCreateBy: CreateBy!
    var priority: Int64!
    var resource_uri: String!
    var rght: Int64!
    var tree_id: Int64!
    var vote_count: Int64!
    var voted: Bool!
    
    init(dict:NSDictionary) {
        self.content = dict["content"] as? String ?? ""
        self.created_at = dict["content"] as? String ?? ""
        self.id = dict["content"] as? Int64 ?? 0
        self.is_producer = dict["is_producer"] as? Bool ?? false
        self.level = dict["level"] as? Int64 ?? 0
        self.wechat_screenname = dict["wechat_screenname"] as? String ?? ""
        self.priority = dict["priority"] as? Int64 ?? 0
        self.resource_uri = dict["content"] as? String ?? ""
        self.rght = dict["rght"] as? Int64 ?? 0
        self.tree_id = dict["tree_id"] as? Int64 ?? 0
        self.vote_count = dict["vote_count"] as? Int64 ?? 0
        self.voted = dict["voted"] as? Bool ?? false
        
        if let item: NSDictionary = (dict["created_by"] as? NSDictionary) {
            if item.count > 0 {
                self.created_by = CreateBy(dict: item)
            }
        }
        
        if let parent = dict["parent"] {
            if let item: NSDictionary = (parent["created_by"] as? NSDictionary) {
                self.parentCreateBy = CreateBy(dict: item)
            }
        }
    }
}

/*
objects": [
 {
 "children_display": [
    {
        "content": "<p><a href=\"/lime/user/home/29015302/\">@李静霞</a> 我也想zhi dam</p>\n",
        "created_at": 1470229344,
        "created_by": 
        {
            "avatar_url": "http://media.ifanrusercontent.com/media/tavatar/d9/38/d938505f0c02746b49dd6288a130d44730a0546f.jpg",
            "company": "",
            "email": "oajoqt5hc_pyosttkwqhywb71paq@weixin.ifanr.email",
            "id": 29015330,
            "lime_home_url": "/lime/user/home/29015330/",
            "nickname": "神经病二号黄静",
            "position": "",
            "userprofile": 
            {
                "weibo_uid": null
            },
            "wechat_screenname": null
        },
        "id": 26586,
        "is_producer": false,
        "level": 1,
        "lft": 2,
        "parent":
        {
            "created_by": 
            {
                "avatar_url": "http://media.ifanrusercontent.com/media/tavatar/39/02/39021655ae5b5289095292b1aa899d4f91a86d5a.jpg",
                "company": "",
                "email": "oajoqtzd9lzbnxqi02nlsecjfv8g@weixin.ifanr.email",
                "id": 29015302,
                "lime_home_url": "/lime/user/home/29015302/",
                "nickname": "李静霞",
                "position": "",
                "userprofile": 
                {
                    "weibo_uid": null
                },
                "wechat_screenname": null
            }
        },
        "priority": 1,
        "resource_uri": "/api/v1.2/mind/comment/26586/",
        "rght": 3,
        "tree_id": 16340,
        "vote_count": 0,
        "voted": false
    }, 
    {
        "content": "<p><a href=\"/lime/user/home/29015302/\">@李静霞</a> 我也想zhid</p>\n",
        "created_at": 1470229357,
        "created_by": 
        {
            "avatar_url": "http://media.ifanrusercontent.com/media/tavatar/d9/38/d938505f0c02746b49dd6288a130d44730a0546f.jpg",
            "company": "",
            "email": "oajoqt5hc_pyosttkwqhywb71paq@weixin.ifanr.email",
            "id": 29015330,
            "lime_home_url": "/lime/user/home/29015330/",
            "nickname": "神经病二号黄静",
            "position": "",
            "userprofile": 
            {
                "weibo_uid": null
            },
            "wechat_screenname": null
        },
        "id": 26587,
        "is_producer": false,
        "level": 1,
        "lft": 4,
        "parent": 
        {
            "created_by": 
            {
                "avatar_url": "http://media.ifanrusercontent.com/media/tavatar/39/02/39021655ae5b5289095292b1aa899d4f91a86d5a.jpg",
                "company": "",
                "email": "oajoqtzd9lzbnxqi02nlsecjfv8g@weixin.ifanr.email",
                "id": 29015302,
                "lime_home_url": "/lime/user/home/29015302/",
                "nickname": "李静霞",
                "position": "",
                "userprofile": 
                {
                    "weibo_uid": null
                },
                "wechat_screenname": null
            }
        },
        "priority": 1,
        "resource_uri": "/api/v1.2/mind/comment/26587/",
        "rght": 5,
        "tree_id": 16340,
        "vote_count": 0,
        "voted": false
    }
 }],
 "content": "<p>对于100万的初期粉丝吸引还是没有讲细具体的方法，主要来听这个的：）</p>\n",
 "created_at": 1470229258,
 "created_by": 
 {
    "avatar_url": "http://media.ifanrusercontent.com/media/tavatar/39/02/39021655ae5b5289095292b1aa899d4f91a86d5a.jpg",
    "company": "",
    "email": "oajoqtzd9lzbnxqi02nlsecjfv8g@weixin.ifanr.email",
    "id": 29015302,
    "lime_home_url": "/lime/user/home/29015302/",
    "nickname": "李静霞",
    "position": "",
    "userprofile": 
    {
        "weibo_uid": null
    },
    "wechat_screenname": null
 },
 "id": 26585,
 "is_producer": false,
 "level": 0,
 "lft": 1,
 "priority": 1,
 "resource_uri": "/api/v1.2/mind/comment/26585/",
 "rght": 10,
 "tree_id": 16340,
 "vote_count": 2,
 "voted": false
}
 */
//
//  MindStoreModel.swift
//  ifanr
//
//  Created by sys on 16/7/9.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

struct CreatedByModel {
    var avatar_url: String!
    var company: String!
    var email: String!
    var id: String!
    var lime_home_url: String!
    var nickname: String!
    var position: String!
    var wechat_screenname: String!
    
}

struct RelatedImageModel {
    var link: String!
    var resource_uri: String!
    var title: String!
}

struct MindStoreModel {
    var id: Int64!
    var comment_count: String!
    var comment_order: String!
    var created_at: String!
    var is_auto_refresh: String!
    var is_producer: String!
    var link: String!
    var priority: String!
    var producer_participated: String!
    var resource_uri: String!
    var share_count: String!
    var tagline: String!
    var title: String!
    var vote_count: String!
    var vote_user_count: String!
    var voted: String!
    
    var createdByModel: CreatedByModel! = CreatedByModel()
    var relatedImageModelArr: [RelatedImageModel] = Array()
    
    init(dict: NSDictionary) {
        self.id = dict["id"] as? Int64 ?? 0
        self.comment_count  = dict["comment_count"] as? String ?? ""
        self.comment_order  = dict["comment_order"] as? String ?? ""
        self.created_at     = dict["created_at"] as? String ?? ""
        self.is_auto_refresh = dict["is_auto_refresh"] as? String ?? ""
        self.is_producer    = dict["is_producer"] as? String ?? ""
        
        self.link       = dict["link"] as? String ?? ""
        self.priority   = dict["priority"] as? String ?? ""
        self.producer_participated = dict["producer_participated"] as? String ?? ""
        self.resource_uri   = dict["resource_uri"] as? String ?? ""
        self.share_count    = dict["share_count"] as? String ?? ""
        self.tagline    = dict["tagline"] as? String ?? ""
        self.title      = dict["title"] as? String ?? ""
        self.vote_count = dict["vote_count"] as? String ?? ""
        self.vote_user_count = dict["vote_user_count"] as? String ?? ""
        self.voted = dict["voted"] as? String ?? ""
        
        self.createdByModel.avatar_url  = dict["created_by"]!["avatar_url"] as? String ?? ""
        self.createdByModel.company     = dict["created_by"]!["company"] as? String ?? ""
        self.createdByModel.email       = dict["created_by"]!["email"] as? String ?? ""
        self.createdByModel.id          = dict["created_by"]!["id"] as? String ?? ""
        self.createdByModel.lime_home_url = dict["created_by"]!["lime_home_url"] as? String ?? ""
        self.createdByModel.nickname = dict["created_by"]!["nickname"] as? String ?? ""
        self.createdByModel.position = dict["created_by"]!["position"] as? String ?? ""
        self.createdByModel.wechat_screenname = dict["created_by"]!["wechat_screenname"] as? String ?? ""
        
        if let tmp = dict["related_image"] {
            for item in (tmp as? NSArray)! {
                if let itemDic: NSDictionary = item as? NSDictionary {
                    var model: RelatedImageModel = RelatedImageModel()
                    model.link  = itemDic["link"] as! String
                    model.title = itemDic["title"] as! String
                    model.resource_uri = itemDic["resource_uri"] as! String
                    self.relatedImageModelArr.append(model)
                }
            }
        }
        
//        var model: RelatedImageModel = RelatedImageModel()
//        model.link = "http://media.ifanrusercontent.com/media/user_files/lime/fc/0f/fc0f1fa3b6eb1b3f8e6c2e2666415e1acaea6387-137691a83047904eca6b05d23d91cda63702b847.jpg"
//        self.relatedImageModelArr.append(model)
//        var model1: RelatedImageModel = RelatedImageModel()
//        model1.link = "http://media.ifanrusercontent.com/media/user_files/lime/fc/0f/fc0f1fa3b6eb1b3f8e6c2e2666415e1acaea6387-137691a83047904eca6b05d23d91cda63702b847.jpg"
//        self.relatedImageModelArr.append(model1)
    }
}

/*
 {
    comment_count: 0,
    comment_order: 0,
    created_at: 1467943090,
    created_by: {
        avatar_url: "http://media.ifanrusercontent.com/media/user_files/lime/avatar/rBACFFWY2lTQ5UnvAAAUiTklo1Y344_200x200_3.jpg",
        company: "骞垮憡",
        email: "weibo_majia_40@lime.ifanr.com",
        id: 21144821,
        lime_home_url: "/lime/user/home/21144821/",
        nickname: "John",
        position: "AE",
        userprofile: {
            weibo_uid: "-40"
        },
        wechat_screenname: null
    },
    id: 12287,
    is_auto_refresh: 0,
    is_producer: false,
    link: "https://itunes.apple.com/cn/app/microsoft-sprightly-instantly/id1114875964?mt=8&amp;utm_source=mindstore.io",
    priority: 1,
    producer_participated: false,
    related_image: [
        {
            link: "http://media.ifanrusercontent.com/media/user_files/lime/fc/0f/fc0f1fa3b6eb1b3f8e6c2e2666415e1acaea6387-137691a83047904eca6b05d23d91cda63702b847.jpg",
            resource_uri: "",
            title: ""
        },
        {
            link: "http://media.ifanrusercontent.com/media/user_files/lime/1e/71/1e71f8cc20f68bdd1f3ec2a2b4b5042ec4d5e078-f8bb11291d7a63e4c4c2ec6d9e65737c0a1cbf92.jpg",
            resource_uri: "",
            title: ""
        }
    ],
    related_link: [ ],
    resource_uri: "/api/v1.2/mind/12287/",
    share_count: 0,
    tagline: "涓轰釜浜烘垨灏忓晢瀹跺畾鍒惰彍鍗曘€佷紭鎯犲埜浠ュ強鐢靛瓙鍗＄墖鐨勭簿缇庢帓鐗堣蒋浠躲€�",
    tags: [ ],
    title: "Microsoft Sprightly #iOS ",
    vote_count: 27,
    vote_user_count: 15,
    voted: false
 },
 
 */
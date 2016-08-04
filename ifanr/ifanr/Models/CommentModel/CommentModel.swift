//
//  CommentModel.swift
//  ifanr
//
//  Created by sys on 16/8/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

struct CommentModel {
    
    var comment_id: String!
    var comment_author: String!
    var sso_id: String!
    var avatar: String!
    var comment_author_url: String!
    var comment_content: String!
    var comment_date: String!
    var comment_parent: String!
    var comment_rating_up: String!
    var comment_rating_down: String!
    var rating_status: String!
    var rated: String!
    var comment_mail_notify: String!
    var depth: String!
    var from_app: String!
    var from_app_name: String!
    var seo_detail_link: String!
    
    init(dict: NSDictionary) {
        self.comment_id = dict["comment_id"] as? String ?? ""
        self.comment_author  = dict["comment_author"] as? String ?? ""
        self.sso_id  = dict["sso_id"] as? String ?? ""
        self.avatar     = dict["avatar"] as? String ?? ""
        self.comment_author_url = dict["comment_author_url"] as? String ?? ""
        self.comment_content    = dict["comment_content"] as? String ?? ""
        
        self.comment_date       = dict["comment_date"] as? String ?? ""
        self.comment_parent   = dict["comment_parent"] as? String ?? ""
        self.comment_rating_up = dict["comment_rating_up"] as? String ?? ""
        self.comment_rating_down   = dict["comment_rating_down"] as? String ?? ""
        self.rating_status    = dict["rating_status"] as? String ?? ""
        self.rated    = dict["rated"] as? String ?? ""
        self.comment_mail_notify      = dict["comment_mail_notify"] as? String ?? ""
        self.depth = dict["depth"] as? String ?? ""
        self.from_app = dict["from_app"] as? String ?? ""
        self.from_app_name = dict["from_app_name"] as? String ?? ""
    }
}

/*
 {
	"data": {
 "hots": [{
 "comment_id": "1033232",
 "comment_author": "\u5cf0",
 "sso_id": "16938290",
 "avatar": "http:\/\/gravatar.ifanrx.com\/avatar\/33801efebc68daf325ca32a4067bfb55?s=80&d=%2F%2Fifanr.b0.upaiyun.com%2Fsite-static%2Fifanr-2.0%2Fdist%2Fimages%2Fcommon%2Fgravatar.jpg",
 "comment_author_url": "",
 "comment_content": "\u770b\u9898\u56fe\u8fd8\u4ee5\u4e3a\u8fdb\u9519\u7f51\u7ad9\u4e86\u2026",
 "comment_date": "2016-08-04 21:15:52",
 "comment_parent": "0",
 "comment_rating_up": "1",
 "comment_rating_down": "0",
 "rating_status": null,
 "rated": 0,
 "comment_mail_notify": "1",
 "depth": null,
 "from_app": "\u6765\u81ea\u79fb\u52a8\u7248",
 "from_app_name": "\u6765\u81ea\u79fb\u52a8\u7248",
 "seo_detail_link": "http:\/\/www.ifanr.com\/696091\/comment\/1033232"
 }],
 "all": [{
 "comment_id": "1033232",
 "comment_author": "\u5cf0",
 "sso_id": "16938290",
 "avatar": "http:\/\/gravatar.ifanrx.com\/avatar\/33801efebc68daf325ca32a4067bfb55?s=80&d=%2F%2Fifanr.b0.upaiyun.com%2Fsite-static%2Fifanr-2.0%2Fdist%2Fimages%2Fcommon%2Fgravatar.jpg",
 "comment_author_url": "",
 "comment_content": "\u770b\u9898\u56fe\u8fd8\u4ee5\u4e3a\u8fdb\u9519\u7f51\u7ad9\u4e86\u2026",
 "comment_date": "2016-08-04 21:15:52",
 "comment_parent": "0",
 "comment_rating_up": "1",
 "comment_rating_down": "0",
 "rating_status": null,
 "rated": 0,
 "comment_mail_notify": "1",
 "depth": null,
 "from_app": "\u6765\u81ea\u79fb\u52a8\u7248",
 "from_app_name": "\u6765\u81ea\u79fb\u52a8\u7248",
 "seo_detail_link": "http:\/\/www.ifanr.com\/696091\/comment\/1033232"
 }, {
 "comment_id": "1033246",
 "comment_author": "\u6d77\u71d5\u5f1f\u5f1f",
 "sso_id": "0",
 "avatar": "http:\/\/gravatar.ifanrx.com\/avatar\/f749504564abe55d5226fcce7afede93?s=80&d=%2F%2Fifanr.b0.upaiyun.com%2Fsite-static%2Fifanr-2.0%2Fdist%2Fimages%2Fcommon%2Fgravatar.jpg",
 "comment_author_url": "",
 "comment_content": "92\u5e74\u7684\uff0c\u771f\u7684\u4e0d\u61c2\u770b\u76f4\u64ad\u7684\u4e50\u8da3\u3002",
 "comment_date": "2016-08-04 21:54:36",
 "comment_parent": "0",
 "comment_rating_up": "0",
 "comment_rating_down": "0",
 "rating_status": null,
 "rated": 0,
 "comment_mail_notify": "1",
 "depth": null,
 "from_app": "\u6765\u81ea Android \u5ba2\u6237\u7aef",
 "from_app_name": "\u6765\u81ea Android \u5ba2\u6237\u7aef",
 "seo_detail_link": "http:\/\/www.ifanr.com\/696091\/comment\/1033246"
 }, {
 "comment_id": "1033249",
 "comment_author": "\u5065\u5eb7\u56fd\u5bbe",
 "sso_id": "0",
 "avatar": "http:\/\/gravatar.ifanrx.com\/avatar\/b4d84b4df8e1e8a4a601a1555860fcbc?s=80&d=%2F%2Fifanr.b0.upaiyun.com%2Fsite-static%2Fifanr-2.0%2Fdist%2Fimages%2Fcommon%2Fgravatar.jpg",
 "comment_author_url": "",
 "comment_content": "@\u6d77\u71d5\u5f1f\u5f1f, .I.",
 "comment_date": "2016-08-04 22:17:30",
 "comment_parent": "1033232",
 "comment_rating_up": "0",
 "comment_rating_down": "0",
 "rating_status": null,
 "rated": 0,
 "comment_mail_notify": "1",
 "depth": null,
 "from_app": "\u6765\u81ea Android \u5ba2\u6237\u7aef",
 "from_app_name": "\u6765\u81ea Android \u5ba2\u6237\u7aef",
 "seo_detail_link": "http:\/\/www.ifanr.com\/696091\/comment\/1033249"
 }]
	},
	"status": 1
 }
 
 */

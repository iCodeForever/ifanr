//
//  CommonModel.swift
//  ifanr
//
//  Created by sys on 16/7/28.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

/**
 *  作者信息
 */
struct AuthorInfoModel {
    var job: String!
    var name: String!
    var avatar: String!
    var description: String!
    
    init(dict: NSDictionary) {
        self.job = dict["job"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.avatar = dict["avatar"] as? String ?? ""
        self.description = dict["description"] as? String ?? ""
    }
}

/*!
 *  @brief 通用的数据模型
 */
struct CommonModel {
    /// id
    var ID: Int64!
    /// 标题
    var title: String!
    /// 作者
    var author: String!
    /// 时间
    var pubDate: String!
    /// 发布时间
    var post_modified: String!
    /// 图片
    var image: String!
    /// cwb_image_url
    var cwb_image_url: String!
    /// 内容
    var content: String!
    /// 摘录
    var excerpt: String!
    /// 引文
    var introduce: String!
    /// 网页版
    var link: String!
    /// 评论数
    var comments: String!
    /// 分类
    var category: String!
    /// 发布类型
    var post_type: String!
    /// 分类网页
    var category_link: String!
    /// tag
    var tags: String!
    /// 喜欢数
    var like: Int!
    var is_ad: Int!
    var authorInfoModel: AuthorInfoModel!
    
    init(dict: NSDictionary) {
        self.ID = dict["ID"] as? Int64 ?? 0
        self.title = dict["title"] as? String ?? ""
        self.author = dict["author"] as? String ?? ""
        self.pubDate = dict["pubDate"] as? String ?? ""
        self.post_modified = dict["post_modified"] as? String ?? ""
        self.image = dict["image"] as? String ?? ""
        self.cwb_image_url = dict["cwb_image_url"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.excerpt = dict["excerpt"] as? String ?? ""
        self.introduce = dict["introduce"] as? String ?? ""
        self.link = dict["link"] as? String ?? ""
        self.comments = dict["comments"] as? String ?? ""
        self.category = dict["category"] as? String ?? ""
        self.post_type = dict["post_type"] as? String ?? ""
        self.category_link = dict["category_link"] as? String ?? ""
        self.tags = dict["tags"] as? String ?? ""
        self.like = dict["like"] as? Int ?? 0
        self.is_ad = dict["is_ad"] as? Int ?? 0
        
        if let item: NSDictionary = (dict["author_info"] as? NSDictionary) {
            self.authorInfoModel = AuthorInfoModel(dict: item)
        }
    }
}
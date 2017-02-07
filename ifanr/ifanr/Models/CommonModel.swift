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

/**
 发布类型： 在计算cell高度是需要分类进行计算（目前只发现这几种）
 */
enum PostType {
    case post
    case data
    case dasheng
}

/*!
 *  @brief 通用的数据模型
 */
struct CommonModel: Initable {
    /// id
    var ID: String!
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
    /// 分类网页
    var category_link: String!
    /// tag
    var tags: String!
    /// 喜欢数
    var like: Int!
    var is_ad: Int!
    /// 作者信息
    var authorInfoModel: AuthorInfoModel!
    /// 发布类型
    var post_type: PostType! = .post
    
    //MARK: --------------------------- Home --------------------------
    /// 大声作者
    var dasheng_author: String! = ""
    /// 数读
    var number: String! = ""
    var subfix: String! = ""
    
    //MARK: --------------------------- AppSo --------------------------
    var app_icon_url: String!
    
    init(dict: NSDictionary) {
        initCommonData(dict)
        
        initHomeData(dict)
        
        initAppSoData(dict)
    }
}

extension CommonModel {
    mutating func initCommonData(_ dict: NSDictionary) {
        let idStr: NSInteger = dict["ID"] as? NSInteger ?? 0
        self.ID = "\(idStr)"
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
        self.category_link = dict["category_link"] as? String ?? ""
        self.tags = dict["tags"] as? String ?? ""
        self.like = dict["like"] as? Int ?? 0
        self.is_ad = dict["is_ad"] as? Int ?? 0
        
        if let item: NSDictionary = (dict["author_info"] as? NSDictionary) {
            self.authorInfoModel = AuthorInfoModel(dict: item)
        }
    }
    
    mutating func initHomeData(_ dict: NSDictionary) {
        if let type = dict["post_type"] as? String {
            if type == "post" {
                self.post_type = .post
            } else if type == "dasheng" {
                self.post_type = .dasheng
                self.dasheng_author = dict["dasheng_author"] as? String ?? ""
                self.category = "大声"
            } else if type == "data" {
                self.post_type = .data
                self.category = "数读"
                self.number = dict["number"] as? String ?? ""
                self.subfix = dict["subfix"] as? String ?? ""
            }
        }
    }
    
    mutating func initAppSoData(_ dict: NSDictionary) {
        self.app_icon_url   = dict["app_icon_url"] as? String ?? ""
    }
}

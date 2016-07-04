//
//  NewsFlashModel.swift
//  ifanr
//
//  Created by sys on 16/7/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class NewsFlashModel: NSObject {
    var id : String?
    var title: String?
    var author: String?
    var pubDate: String?
    var post_modified: String?
    var image: String?
    var content: String?
    var excerpt: String?
    var introduce: String?
    var link: String?
    var comments: String?
    var category: String?
    var post_type: String?
    var tags: String?
    var like: String?
    var is_ad: String?
    
    convenience init(dict : NSDictionary) {
        self.init()
        
        self.id     = "\(dict["id"])"
        self.title  = dict["title"] as? String
        self.author = dict["author"] as? String
        self.pubDate = dict["pubDate"] as? String
        self.post_modified = dict["post_modified"] as? String
        self.image  = dict["image"] as? String
        
        self.content    = dict["content"] as? String
        self.excerpt    = dict["excerpt"] as? String
        self.introduce  = dict["introduce"] as? String
        self.link       = dict["link"] as? String
        self.comments   = dict["comments"] as? String
        self.category   = dict["category"] as? String
        self.post_type  = dict["post_type"] as? String
        
        self.tags   = dict["tags"] as? String
        self.like   = dict["like"] as? String
        self.is_ad  = dict["is_ad"] as? String
    }
}

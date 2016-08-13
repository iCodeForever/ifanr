//
//  MindStoreVoteModel.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/8.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

struct VotedUser {
    var avatar_url: String!
    var company: String!
    var email: String!
    var id: Int64!
    var lime_home_url: String!
    var position: String!
    
    init(dict: NSDictionary) {
        self.avatar_url = dict["avatar_url"] as? String ?? ""
        self.company = dict["company"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.id = dict["id"] as? Int64 ?? 0
        self.lime_home_url = dict["lime_home_url"] as? String ?? ""
        self.position = dict["position"] as? String ?? ""
    }
}

struct MindStoreVoteModel: Initable {
    var id: Int64!
    var resource_uri: String!
    var share_count: Int64!
    var voted: Bool!
    var votedUserArray = Array<VotedUser>()
    
    init(dict: NSDictionary) {
        self.id = dict["id"] as? Int64 ?? 0
        self.resource_uri = dict["resource_uri"] as? String ?? ""
        self.share_count = dict["share_count"] as? Int64 ?? 0
        self.voted = dict["voted"] as? Bool ?? false
        
        if let votedUserArray = dict["voted_user"] as? Array<NSDictionary> {
            self.votedUserArray = votedUserArray.map { (dict) -> VotedUser in
                return VotedUser(dict: dict)
            }
        }
    }
}
/*
"id": 11149,
"resource_uri": "/api/v1.2/mind/vote/11149/",
"share_count": 44,
"vote_count": 311,
"voted": false,
"voted_user": [

{
"avatar_url": "http://media.ifanrusercontent.com/media/tavatar/f0/e0/f0e0018ac7f46e9b92919cd32dbb49bc06d58051.jpg",
"company": "",
"email": "492275569@qq.com",
"id": 24336494,
"lime_home_url": "/lime/user/home/24336494/",
"nickname": "西瓜欣030E-CREW",
"position": "",
"userprofile": {
"weibo_uid": null
},
"wechat_screenname": null
 
 */
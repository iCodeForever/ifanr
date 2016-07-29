//
//  ShareSDKUtil.swift
//  ifanr
//
//  Created by sys on 16/7/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class ShareSDKUtil: NSObject {
    
    func shareToFriendWithText(content: String) -> Void {
        let req: SendMessageToWXReq = SendMessageToWXReq()
        req.text    = content
        req.bText   = true
        req.scene   = 0
        [WXApi .sendReq(req)]
    }

}
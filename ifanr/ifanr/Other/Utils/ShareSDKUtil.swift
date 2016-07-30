//
//  ShareSDKUtil.swift
//  ifanr
//
//  Created by sys on 16/7/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class ShareSDKUtil: NSObject {
    
    
    // 分享到微信好友
    class func shareToFriend()  {
        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("分享内容",
                                                images: UIImage(named: "ic_article_back"),
                                                url   : NSURL(string:"http://mob.com"),
                                                title : "分享标题",
                                                type  : SSDKContentType.Auto)
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.TypeWechat, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
        
            switch state{
        
            case SSDKResponseState.Success:
                print("分享成功")
                let alert = UIAlertView(title: "分享成功", message: "分享成功", delegate: self, cancelButtonTitle: "取消")
                alert.show()
            case SSDKResponseState.Fail:
                print("分享失败,错误描述:\(error)")
            case SSDKResponseState.Cancel:
                print("分享取消")
                        
            default:
                break
            }
        }
    }
    
    //分享到朋友圈
    class func shareToFriendsCircle() {
        let shareParams = NSMutableDictionary()
        ShareSDK.share(.TypeWechat, parameters: shareParams) { (state:SSDKResponseState, userData: [NSObject : AnyObject]!, contentEntity: SSDKContentEntity!, error: NSError!) in
            
        }
    }
}
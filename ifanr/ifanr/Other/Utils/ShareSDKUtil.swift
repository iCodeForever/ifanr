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
    class func shareToFriend(shareContent: String, shareImageUrl: String, shareURL: String, shareTitle: String)  {
        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText(shareContent,
                                                images: UIImage(data: NSData(contentsOfURL: NSURL(string: shareImageUrl)!)!),
                                                url   : NSURL(string:shareURL),
                                                title : shareTitle,
                                                type  : SSDKContentType.Auto)
        
        //2.进行分享
        ShareSDK.share(SSDKPlatformType.TypeWechat, parameters: shareParames) { (state : SSDKResponseState, userData : [NSObject : AnyObject]!, contentEntity :SSDKContentEntity!, error : NSError!) -> Void in
        
            switch state{
        
            case SSDKResponseState.Success:
                print("分享成功")
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
    class func shareToFriendsCircle(shareContent: String, shareTitle: String, shareUrl: String, shareImageUrl: String) {
        
        let shareParams = NSMutableDictionary()
        shareParams.SSDKSetupWeChatParamsByText(shareContent,
                                                title: shareTitle,
                                                url: NSURL(string:shareUrl),
                                                thumbImage: nil,
                                                image: UIImage(data: NSData(contentsOfURL: NSURL(string: shareImageUrl)!)!),
                                                musicFileURL: nil,
                                                extInfo: nil,
                                                fileData: nil,
                                                emoticonData: nil,
                                                type: .Auto,
                                                forPlatformSubType: .SubTypeWechatTimeline)
        
        ShareSDK.share(.SubTypeWechatTimeline, parameters: shareParams) { (state:SSDKResponseState, userData: [NSObject : AnyObject]!, contentEntity: SSDKContentEntity!, error: NSError!) in
            switch state {
            case .Success:
                print("分享成功")
            case .Fail:
                print("分享失败,错误描述:\(error)")
            case.Cancel:
                print("分享取消")
            default:
                break
            }
        }
    }
}
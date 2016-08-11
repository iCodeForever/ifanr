//
//  AppDelegate.swift
//  ifanr
//
//  Created by dubinyuan on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import YYWebImage
import MonkeyKing

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()
    
        window?.rootViewController = NewFeatureController()
//        window?.rootViewController = IFBaseNavController(rootViewController: MainViewController())
        
        
//        registerShareSDK()
        MonkeyKing.registerAccount(.WeChat(appID: "wx535617f8042959c0", appKey: "df8037d4b45d95f86b7969a463a7c662"))
        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        // 获取缓存大小
        let cache = YYWebImageManager.sharedManager().cache
//        let memoryCache = cache!.memoryCache.totalCost
//        let diskCache = cache!.diskCache.totalCost
        
        // 清空缓存
        cache?.memoryCache.removeAllObjects()
        cache?.diskCache.removeAllObjects()
    }
}


extension AppDelegate {
//    func registerShareSDK() {
    
//        ShareSDK.registerApp("150733cdd42da",
//                             activePlatforms: [SSDKPlatformType.TypeWechat.rawValue],
//                             onImport: {(platform : SSDKPlatformType) -> Void in
//                                
//                                switch platform{
//                                case SSDKPlatformType.TypeWechat:
//                                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
//                                    break
//                                default:
//                                    break
//                                }
//            },
//                             onConfiguration: {(platform : SSDKPlatformType,appInfo : NSMutableDictionary!) -> Void in
//                                switch platform {
//                                    
//                                case SSDKPlatformType.TypeWechat:
//                                    appInfo.SSDKSetupWeChatByAppId("wx535617f8042959c0", appSecret: "df8037d4b45d95f86b7969a463a7c662")
//                                    break
//                                    
//                                default:
//                                    break
//                                    
//                                }
//        })
//    }
}
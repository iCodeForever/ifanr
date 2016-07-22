//
//  AppDelegate.swift
//  ifanr
//
//  Created by dubinyuan on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import YYWebImage

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.makeKeyAndVisible()

        window?.rootViewController = IFBaseNavController(rootViewController: MainViewController())

        return true
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        // 获取缓存大小
        let cache = YYWebImageManager.sharedManager().cache
        let memoryCache = cache!.memoryCache.totalCost
        let diskCache = cache!.diskCache.totalCost
        
        print("memoryCache: \(memoryCache) -- diskCache: \(diskCache)")
    }
}


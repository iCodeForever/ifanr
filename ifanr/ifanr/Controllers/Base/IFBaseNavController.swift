//
//  IFBaseNavController.swift
//  ifanr
//
//  Created by sys on 16/7/17.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class IFBaseNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBarHidden = true
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            UIApplication.sharedApplication().statusBarStyle = .Default
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        if self.viewControllers.count == 2 {
            UIApplication.sharedApplication().statusBarStyle = .LightContent
        }
        return super.popViewControllerAnimated(animated)
    }
}

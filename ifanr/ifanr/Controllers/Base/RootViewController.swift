//
//  RootViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init(menuViewController: MenuViewController, mainViewController: MainViewController) {
        self.init()
        self.menuViewController = menuViewController
        self.mainViewController = mainViewController
        
        initViewController()
    }
    /**
     隐藏状态栏
     */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: --------------------------- Private Methods --------------------------
    
    /**
     初始化控制器
     */
    private func initViewController() {
        addChildViewController(menuViewController)
        addChildViewController(mainViewController)
        
        menuViewController.view.frame = self.view.bounds
        mainViewController.view.frame = self.view.bounds
        self.view.addSubview(menuViewController.view)
        self.view.addSubview(mainViewController.view)
    }
    //MARK: --------------------------- Getter and Setter --------------------------
     /// 菜单控制器
    private var menuViewController: MenuViewController!
     /// 主控制器
    private var mainViewController: MainViewController!
}

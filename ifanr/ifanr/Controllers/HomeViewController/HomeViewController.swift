//
//  HomeViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        let headerView = HomeHeaderView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 200), imageArray: imageArray)
        self.view.addSubview(headerView)
        
    }
    let imageArray = [
        UIImage(named: "ic_about")!,
        UIImage(named: "ic_login")!,
        UIImage(named: "ic_report")!,
        UIImage(named: "ic_search")!,
        UIImage(named: "ic_setting")!
    ]
}

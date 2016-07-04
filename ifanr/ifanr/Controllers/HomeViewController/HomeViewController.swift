//
//  HomeViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/1.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import SnapKit
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headerView = HomeHeaderView()
        self.view.addSubview(headerView)
        
        headerView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make
        }
        
        
        IFanrService.shareInstance.getHomeHotDate(0, posts_per_page: 5, successHandle: { (modelArray) in
            headerView.modelArray = modelArray
            }, errorHandle: nil)

    }
}

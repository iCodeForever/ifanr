//
//  BasePageController.swift
//  ifanr
//
//  Created by sys on 16/7/4.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Alamofire

class BasePageController: UIViewController, ScrollViewControllerReusable {
        
    //MARK: --------------------------- life cycle --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        setupTableView()
        setupPullToRefreshView()
    }
  
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var tableView: UITableView!
    /// 下拉刷新
    var pullToRefresh: PullToRefreshView!
    /// 下拉刷新代理
    var scrollViewReusable: ScrollViewControllerReusableDataSource!
    
    /// 是否正在刷新
    var isRefreshing = false
    
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0
}


extension BasePageController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentSizeY = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        differY = contentSizeY-contentOffsetY
    }
}
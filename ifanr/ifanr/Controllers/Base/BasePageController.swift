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
    var scrollViewReusableDataSource: ScrollViewControllerReusableDataSource!
    var scrollViewReusableDelegate: ScrollViewControllerReusableDelegate!
    
    
    
    /// 是否正在刷新
    var isRefreshing = false
    /// 记录当前列表页码
    var page = 1
    /// 上拉加载更多触发零界点
    var happenY: CGFloat = UIConstant.SCREEN_HEIGHT+20
    var differY: CGFloat = 0

    /// scrollView方向
    var direction: ScrollViewDirection! = ScrollViewDirection.None
    var lastContentOffset: CGFloat = 0
}


extension BasePageController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 计算contentsize与offset的差值
        let contentSizeY = scrollView.contentSize.height
        let contentOffsetY = scrollView.contentOffset.y
        
        differY = contentSizeY-contentOffsetY
        
        // 判断滚动方向
        if contentOffsetY > 0 {
            ChangeScrollViewDirection(contentOffsetY)
        } 
    }
    
    /**
     判断滚动方向
     */
    private func ChangeScrollViewDirection(contentOffsetY: CGFloat) {
//        print("contentoffsety:\(contentOffsetY)     last: \(lastContentOffset)   dir: \(direction)")
        
        if contentOffsetY > lastContentOffset {
            lastContentOffset = contentOffsetY
            guard direction != .Down else {
                return
            }
            scrollViewReusableDelegate.ScrollViewControllerDirectionDidChange(.Down)
            
            direction = .Down
            
        } else if lastContentOffset > contentOffsetY {
            lastContentOffset = contentOffsetY
            guard direction != .Up else {
                return
            }
            scrollViewReusableDelegate.ScrollViewControllerDirectionDidChange(.Up)
            
            direction = .Up
        }
        
        
    }
    
}
//
//  ControllerReusable.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/15.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation


protocol ControllerReusable: class {
    
}

/**
 *  这里是用与下拉刷新回调
 */
protocol ScrollViewControllerReusableDataSource: ControllerReusable {
    func titleHeaderView() -> MainHeaderView
    func redLineView() -> UIView
}


protocol ScrollViewControllerReusable: ControllerReusable, PullToRefreshDataSource, PullToRefreshDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView! { get set }
        /// 下拉刷新
    var pullToRefresh: PullToRefreshView! { get set }
        /// 下拉刷新代理
    var scrollViewReusable: ScrollViewControllerReusableDataSource! { get set }
    
    /**
     tableView HeaderView
     */
    var tableHeaderView: UIView! { get set }
//    var headerViewTitle: String { get set }
//    var headerViewImage: UIImage { get set }
}

// MARK: - 返回一些下拉刷新的回调
extension ScrollViewControllerReusable where Self: UIViewController {
    /**
     首页，快讯，玩物志顶部标题
     */
    func titleHeaderView() -> MainHeaderView {
        return scrollViewReusable.titleHeaderView()
    }
    
    /**
     红线
     */
    func redLine() -> UIView {
        return scrollViewReusable.redLineView()
    }
    
    func scrollView() -> UIScrollView {
        return self.tableView
    }
}

// MARK: - 扩展一些初始化方法
extension ScrollViewControllerReusable where Self: UIViewController {
    
    /**
     初始化tableView
     */
    func setupTableView() {
        if tableView == nil {
            tableView = UITableView()
            tableView.backgroundColor = UIColor.whiteColor()
            tableView.origin = CGPoint.zero
            tableView.size = CGSize(width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20)
            tableView.separatorStyle = .None
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = tableHeaderView
            tableView.sectionHeaderHeight = tableHeaderView.height
            tableView.tableFooterView = UIView()
            self.view.addSubview(tableView)
        }
    }
    
    /**
     初始化下拉刷新控件
     */
    func setupPullToRefreshView() {
        if  pullToRefresh == nil {
            pullToRefresh = PullToRefreshView(frame: CGRect(x: 0, y: -sceneHeight, width: self.view.width, height: sceneHeight))
            pullToRefresh.delegate = self
            pullToRefresh.dataSource = self
            self.tableView.insertSubview(pullToRefresh, atIndex: 0)
        }
    }
}
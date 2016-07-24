//
//  ControllerReusable.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/15.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

enum ScrollViewDirection {
    case None
    case Down
    case Up
}

protocol ControllerReusable: class {
    
}

/**
 *  这里是用与下拉刷新回调
 */
protocol ScrollViewControllerReusableDataSource: ControllerReusable {
    /**
     导航栏
     */
    func titleHeaderView() -> MainHeaderView
    /**
     下拉刷新红线
     */
    func redLineView() -> UIView
    /**
     *  菜单按钮
     */
    func menuButton() -> UIButton
    
    /**
     首页分类按钮
     */
    func classifyButton() -> UIButton
}

protocol ScrollViewControllerReusableDelegate: ControllerReusable {
    /**
     scrollview滚动时方向改变是调用
     */
    func ScrollViewControllerDirectionDidChange(direction: ScrollViewDirection)
}


protocol ScrollViewControllerReusable: ControllerReusable, PullToRefreshDataSource {
    
    var tableView: UITableView! { get set }
        /// 下拉刷新
    var pullToRefresh: PullToRefreshView! { get set }
        /// 下拉刷新代理
    var scrollViewReusableDataSource: ScrollViewControllerReusableDataSource! { get set }
    var scrollViewReusableDelegate: ScrollViewControllerReusableDelegate! { get set }
}

// MARK: - 返回一些下拉刷新的回调
extension ScrollViewControllerReusable where Self: UIViewController {
    /**
     首页，快讯，玩物志顶部标题
     */
    func titleHeaderView() -> MainHeaderView {
        return scrollViewReusableDataSource.titleHeaderView()
    }
    
    /**
     红线
     */
    func redLine() -> UIView {
        return scrollViewReusableDataSource.redLineView()
    }
    
    /**
     菜单按钮
     */
    func menuButton() -> UIButton {
        return scrollViewReusableDataSource.menuButton()
    }
    
    func classifyButton() -> UIButton {
        return scrollViewReusableDataSource.classifyButton()
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
            tableView.sectionFooterHeight = 50
            tableView.tableFooterView = pullToRefreshFootView()
            self.view.addSubview(tableView)
        }
    }
    
    /**
     初始化下拉刷新控件
     */
    func setupPullToRefreshView() {
        if  pullToRefresh == nil {
            pullToRefresh = PullToRefreshView(frame: CGRect(x: 0, y: -sceneHeight, width: self.view.width, height: sceneHeight))
            pullToRefresh.dataSource = self
            self.tableView.insertSubview(pullToRefresh, atIndex: 0)
        }
    }
    
    private func pullToRefreshFootView() -> UIView {
        
        let activityView = ActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25) )
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.center = CGPoint(x: self.view.center.x, y: 25)
        activityView.startAnimation()
        
        let footView = UIView()
        footView.origin = CGPointZero
        footView.size = CGSize(width: 50, height: 50)
        footView.addSubview(activityView)
        return footView
    }
}
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
protocol ScrollViewControllerReusable: ControllerReusable {
//    /**
//     拖拽的时候调用
//     */
//    func scrollViewPullToRefreshNormal(scrollView: UIScrollView, contentoffsetY: CGFloat)
//    /**
//     刷新前调用
//     */
//    func scrollViewPullToRefreshPulling(scrollView: UIScrollView)
//    /**
//     刷新完成调用
//     */
//    func scrollViewPullToRefreshFinish(scrollView: UIScrollView)
    
    func titleHeaderView() -> MainHeaderView
    func redLineView() -> UIView
}

extension ScrollViewControllerReusable where Self: UIViewController {
    
}
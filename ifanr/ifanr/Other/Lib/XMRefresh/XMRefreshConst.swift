//
//  XMRefreshConst.swift
//  XMPullToRefreshDemo
//
//  Created by 梁亦明 on 15/10/3.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import UIKit

/**
*   主要存储一些常量值
*/

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width

let XMRefreshViewHeight:CGFloat = 80
let XMRefreshSlowAnimationDuration:NSTimeInterval = 0.3

let XMRefreshFooterPullToRefresh:String = "上拉加载更多"
let XMRefreshFooterReleaseToRefresh:String =  "释放加载更多"
let XMRefreshFooterRefreshing:String =  "正在加载..."

let XMRefreshHeaderPullToRefresh:String =  "下拉刷新"
let XMRefreshHeaderReleaseToRefresh:String =  "释放刷新"
let XMRefreshHeaderRefreshing:String =  "正在刷新..."
let XMRefreshHeaderTimeKey:String =  "RefreshHeaderView"

let XMRefreshContentOffset:String =  "contentOffset"
let XMRefreshContentSize:String =  "contentSize"

let XMRefreshLabelTextColor:UIColor = UIColor.lightGrayColor()
let XMRefreshLabelTextSize:UIFont = UIFont.systemFontOfSize(12)


let XMTimer : NSTimeInterval = 2.0
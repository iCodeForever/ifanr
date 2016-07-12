//
//  XMRefreshBase.swift
//  XMPullToRefreshDemo
//
//  Created by 梁亦明 on 15/10/3.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import UIKit

class XMRefreshBase: UIView {
    
    // MARK: =========================定义属性=============================
    
    
    /// 刷新回调的Block
    typealias beginRefreshingBlock = () -> Void
    typealias refreshingBlock = (contentOffSet: CGFloat) -> Void
    
    //控件的刷新状态
    enum XMRefreshState {
        case  RefreshStateNormal                // 普通状态
        case  RefreshStatePulling               // 松开就可以进行刷新的状态
        case  RefreshStateRefreshing            // 正在刷新中的状态
        case  WillRefreshing
    }
    
    //控件的类型
    enum XMRefreshViewType {
        case  RefreshViewTypeHeader             // 头部控件
        case  RefreshViewTypeFooter             // 尾部控件
    }
    
    // 父控件
    var scrollView:UIScrollView!
    var scrollViewOriginalInset:UIEdgeInsets!
    
    // 状态标签
    var statusLabel:UILabel!
    // 箭头图片
    var arrowImage:UIImageView!
    // 菊花
    var activityView:UIActivityIndicatorView!
    
    // 刷新后回调
    var beginRefreshingCallback:beginRefreshingBlock?
    // 刷新中回调
    var RefreshingCallBack:refreshingBlock?
    
    // 交给子类去实现和调用
    var oldState:XMRefreshState?
    
    // 当状态改变时设置状态(State)就会调用这个方法
    var State : XMRefreshState = XMRefreshState.RefreshStateNormal {
        willSet {
            self.State = newValue
        }
        
        didSet {

            guard self.State != self.oldState else {
                return
            }
            
            switch self.State {
                // 普通状态时 隐藏那个菊花
                case .RefreshStateNormal:
                    self.arrowImage.hidden = false
                    self.activityView.stopAnimating()
                // 释放刷新状态
                case .RefreshStatePulling:
                    break;
                // 正在刷新状态 1隐藏箭头 2显示菊花 3回调
                case .RefreshStateRefreshing:
                    self.arrowImage.hidden = true
                    activityView.startAnimating()
                    
                    if let _ = self.beginRefreshingCallback {
                        
                        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(XMTimer * Double(NSEC_PER_SEC)))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            self.State = XMRefreshState.RefreshStateNormal
                            self.beginRefreshingCallback!()
                        }
                        
                    }
                
            default :
                break;
            }
        }
    }
    
    // MARK: =========================定义方法===========================
    
    /**
    初始化控件
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        // 初始化箭头
        self.arrowImage = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        self.arrowImage.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin]
        self.arrowImage.image = UIImage(named: "pull_to_refresh_icon")
        self.addSubview(arrowImage)

        // 初始化状态标签
        statusLabel = UILabel(frame: CGRectMake(0, 55, SCREEN_WIDTH, 20))
        statusLabel.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        statusLabel.font = XMRefreshLabelTextSize
        statusLabel.textColor = XMRefreshLabelTextColor
        statusLabel.backgroundColor =  UIColor.clearColor()
        statusLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(statusLabel)

        // 初始化菊花
        self.activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        self.activityView.bounds = self.arrowImage.bounds
        self.activityView.autoresizingMask = self.arrowImage.autoresizingMask
        self.activityView.hidesWhenStopped = true
        self.activityView.color = XMRefreshLabelTextColor
        self.addSubview(activityView)
        
        self.autoresizingMask = .FlexibleWidth
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置箭头和菊花居中
        self.arrowImage.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        self.activityView.center = self.arrowImage.center
    }
    
    //显示到屏幕上
    override func drawRect(rect: CGRect) {
        superview?.drawRect(rect);
        if self.State == XMRefreshState.WillRefreshing {
            self.State = XMRefreshState.RefreshStateRefreshing
        }
    }
    
    // MARK: ==============================让子类去重写=======================
    override func willMoveToSuperview(newSuperview: UIView!) {
        super.willMoveToSuperview(newSuperview)
        // 移走旧的父控件
        if (self.superview != nil) {
            self.superview?.removeObserver(self, forKeyPath: XMRefreshContentSize as String, context: nil)
            
        }
        // 新的父控件 添加监听器
        if (newSuperview != nil) {
            newSuperview.addObserver(self, forKeyPath: XMRefreshContentOffset as String, options: NSKeyValueObservingOptions.New, context: nil)
            var rect:CGRect = self.frame
            // 设置宽度 位置
            rect.size.width = newSuperview.frame.size.width
            rect.origin.x = 0
            self.frame = frame;
            //UIScrollView
            scrollView = newSuperview as! UIScrollView
            scrollViewOriginalInset = scrollView.contentInset;
        }
    }
    
    // 判断是否正在刷新
    func isRefreshing()->Bool{
        return XMRefreshState.RefreshStateRefreshing == self.State;
    }
    
    // 开始刷新
    func beginRefreshing(){
        // self.State = RefreshState.Refreshing;
        if (self.window != nil) {
            self.State = XMRefreshState.RefreshStateRefreshing;
        } else {
            //不能调用set方法
            State = XMRefreshState.WillRefreshing;
            super.setNeedsDisplay()
        }
    }
    
    //结束刷新
    func endRefreshing(){
        let delayInSeconds:Double = 0.3
        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
        
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.State = XMRefreshState.RefreshStateNormal;
        })
    }
}

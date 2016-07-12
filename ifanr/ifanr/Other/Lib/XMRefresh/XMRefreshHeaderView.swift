//
//  XMRefreshHeaderView.swift
//  XMPullToRefreshDemo
//
//  Created by 梁亦明 on 15/10/3.
//  Copyright © 2015年 xiaoming. All rights reserved.
//

import UIKit

class XMRefreshHeaderView: XMRefreshBase {
    
    override var State : XMRefreshState {
        willSet {
            oldState = State
        }
        
        didSet {
            switch self.State{
                // 普通状态
            case .RefreshStateNormal:
                self.statusLabel.text = XMRefreshHeaderPullToRefresh
                if XMRefreshState.RefreshStateRefreshing == oldState {
                    self.arrowImage.transform = CGAffineTransformIdentity
                    UIView.animateWithDuration(XMRefreshSlowAnimationDuration, animations: {
                        var contentInset:UIEdgeInsets = self.scrollView.contentInset
                        contentInset.top = self.scrollViewOriginalInset.top
                        self.scrollView.contentInset = contentInset
                    })
                    
                } else {
                    UIView.animateWithDuration(XMRefreshSlowAnimationDuration, animations: {
                        self.arrowImage.transform = CGAffineTransformIdentity
                    })
                }
                
                // 释放刷新状态
            case .RefreshStatePulling:
                self.statusLabel.text = XMRefreshHeaderReleaseToRefresh
                UIView.animateWithDuration(XMRefreshSlowAnimationDuration, animations: {
                    self.arrowImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI ))
                })
                
                // 正在刷新状态
            case .RefreshStateRefreshing:
                self.statusLabel.text =  XMRefreshHeaderRefreshing;
                
                UIView.animateWithDuration(XMRefreshSlowAnimationDuration, animations: {
                    let top:CGFloat = self.scrollViewOriginalInset.top + self.frame.size.height
                    var inset:UIEdgeInsets = self.scrollView.contentInset
                    inset.top = top
                    self.scrollView.contentInset = inset
                    var offset:CGPoint = self.scrollView.contentOffset
                    offset.y = -top
                    self.scrollView.contentOffset = offset
                })

            default:
                break
                
            }
        }
        
    }
    // 创建view的静态方法
    class func headerView() -> XMRefreshHeaderView {
        return XMRefreshHeaderView(frame: CGRectMake(0, 0, SCREEN_WIDTH, XMRefreshViewHeight))
    }
    
    /**
    设置headerView的frame
    */
    override func willMoveToSuperview(newSuperview: UIView!) {
        super.willMoveToSuperview(newSuperview)
        
        var rect:CGRect = self.frame
        rect.origin.y = -XMRefreshViewHeight
        self.frame = rect
    }

    
    /**
    这个方法是这个Demo的核心。。监听scrollview的contentoffset属性。 属性变化就会调用。
    */
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        
        // 如果当前状态不是刷新状态
        guard self.State != XMRefreshState.RefreshStateRefreshing else {
            return
        }
        
        // 监听到的是contentoffset
        guard XMRefreshContentOffset == keyPath else {
            return
        }
        
        // 拿到当前contentoffset的y值
        let currentOffsetY : CGFloat = self.scrollView.contentOffset.y
        let happenOffsetY : CGFloat = -self.scrollViewOriginalInset.top
        
        if (currentOffsetY >= happenOffsetY) {
            return
        }
        // 根据scrollview 滑动的位置设置当前状态
        if self.scrollView.dragging {
            let normal2pullingOffsetY : CGFloat = happenOffsetY - XMRefreshViewHeight
            if self.State == XMRefreshState.RefreshStateNormal && currentOffsetY < normal2pullingOffsetY {
                self.State = XMRefreshState.RefreshStatePulling
            } else if self.State == XMRefreshState.RefreshStatePulling && currentOffsetY >= normal2pullingOffsetY{
                self.State = XMRefreshState.RefreshStateNormal
            }
            
        } else if self.State == XMRefreshState.RefreshStatePulling {
            self.State = XMRefreshState.RefreshStateRefreshing
        }
    }
    
    
}

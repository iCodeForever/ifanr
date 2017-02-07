//
//  LoadMoreView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/19.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

// 异步执行任务
public typealias LoadMoreViewTask = () -> Void

/// 下拉刷新回调
protocol LoadMoreViewDelegate: class {
    func scrollView() -> UIScrollView
    func LoadMoreViewWillRefresh(_ pullToRefreshView: LoadMoreView)
    func LoadMoreViewDidRefresh(_ pulllToRefreshView: LoadMoreView) -> LoadMoreViewTask
}

class LoadMoreView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        /**
         添加音符动画
         */
        self.addSubview(activityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: --------------------------- Getter and Setter --------------------------
    /// 滚动器
    fileprivate var scrollView: UIScrollView!
    /// 执行的代码块
    fileprivate var task: LoadMoreViewTask?
    /// 代理回调
    weak var delegate: LoadMoreViewDelegate? {
        willSet {
            if let newValue = newValue {
                scrollView = newValue.scrollView()
                scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.new, context: nil)
                scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
                scrollViewOriginalInset = scrollView.contentInset
            }
        }
        
        didSet {
            if let oldValue = oldValue {
                oldValue.scrollView().removeObserver(self, forKeyPath: "contentOffset", context: nil)
                oldValue.scrollView().removeObserver(self, forKeyPath: "contentSize", context: nil)
            }
        }
    }
    fileprivate var scrollViewOriginalInset: UIEdgeInsets!
    /// 保存cell的总个数
    fileprivate var lastRefreshCount: Int = 0
    // 上一个状态
    var oldState: RefreshState?
    // 当前状态
    var state: RefreshState = RefreshState.normal {
        willSet {
            oldState = state
        }
        
        didSet {
            switch state {
            // 普通状态
            case .normal:
                if .refreshing == oldState {
                    
                    UIView.animate(withDuration: 0.2, animations: {
                        self.scrollView.contentInset.bottom = self.scrollViewOriginalInset.bottom
                    })
                    
                    let deltaH : CGFloat = self.heightForContentBreakView()
                    let currentCount : Int = self.totalDataCountInScrollView()
                    
                    if (deltaH > 0  && currentCount != self.lastRefreshCount) {
                        var offset:CGPoint = self.scrollView.contentOffset;
                        offset.y = self.scrollView.contentOffset.y
                        self.scrollView.contentOffset = offset;
                    }
                }
            // 释放加载更多
            case .pulling:
                break;
                
            // 正在加载更多
            case .refreshing:
                self.activityView.startAnimation()
                self.lastRefreshCount = self.totalDataCountInScrollView();
                UIView.animate(withDuration: 0.2, animations: {
                    var bottom : CGFloat = self.frame.size.height + self.scrollViewOriginalInset.bottom
                    let deltaH : CGFloat = self.heightForContentBreakView()
                    if deltaH < 0 {
                        bottom = bottom - deltaH
                    }
                    var inset:UIEdgeInsets = self.scrollView.contentInset;
                    inset.bottom = bottom;
                    self.scrollView.contentInset = inset;
                })
            }
        }
    }
    /// 菊花
    fileprivate lazy var activityView: ActivityIndicatorView = {
        let activityView = ActivityIndicatorView()
        activityView.backgroundColor = UIColor.blue
        activityView.color = UIConstant.UI_COLOR_GrayTheme
        activityView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 25, height: 25))
        activityView.center = self.center
//        activityView.hidden = true
        return activityView
    }()
}

extension LoadMoreView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let keyPath = keyPath, keyPath == "contentSize" {
            resetFrameWithContentSize()
        }
            
        else if let keyPath = keyPath, keyPath == "contentOffset" {
            // 如果不是刷新状态
            guard state != .refreshing else {
                return
            }
            
            let currentOffsetY : CGFloat  = self.scrollView.contentOffset.y
            let happenOffsetY : CGFloat = self.happenOffsetY()
            
            if currentOffsetY <= happenOffsetY {
                return
            }
            
            if self.scrollView.isDragging {
                let normal2pullingOffsetY =  happenOffsetY + self.frame.size.height
                if state == .normal && currentOffsetY > normal2pullingOffsetY {
                    state = .pulling
                } else if (state == .pulling && currentOffsetY <= normal2pullingOffsetY) {
                    state = .normal;
                }
            } else if (state == .pulling) {
                state = .refreshing
            }
        }
    }
    
    fileprivate func resetFrameWithContentSize() {
        let contentHeight: CGFloat = self.scrollView.contentSize.height
        let scrollHeight: CGFloat = self.scrollView.frame.size.height
        
        var rect:CGRect = self.frame;
        rect.origin.y =  contentHeight > scrollHeight ? contentHeight : scrollHeight
        self.frame = rect;

    }
    
    fileprivate func heightForContentBreakView() -> CGFloat {
        let h:CGFloat  = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
        return self.scrollView.contentSize.height - h;
    }
    
    
    fileprivate func happenOffsetY() -> CGFloat {
        let deltaH:CGFloat = self.heightForContentBreakView()
        
        if deltaH > 0 {
            return   deltaH - self.scrollViewOriginalInset.top;
        } else {
            return  -self.scrollViewOriginalInset.top;
        }
    }
    
    /**
     获取cell的总个数
     */
    fileprivate  func  totalDataCountInScrollView() -> Int {
        var totalCount:Int = 0
        if self.scrollView is UITableView {
            let tableView:UITableView = self.scrollView as! UITableView
            
            for i in 0..<tableView.numberOfSections {
                totalCount = totalCount + tableView.numberOfRows(inSection: i)
            }
        } else if self.scrollView is UICollectionView {
            let collectionView:UICollectionView = self.scrollView as! UICollectionView
            for i in 0..<collectionView.numberOfSections {
                totalCount = totalCount + collectionView.numberOfItems(inSection: i)
            }
        }
        return totalCount
    }
}

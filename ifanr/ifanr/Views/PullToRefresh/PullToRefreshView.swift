//
//  PullToRefreshView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/15.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation
import SnapKit

let sceneHeight: CGFloat = 300
let happenOffsetY: CGFloat = 80
/// 下拉刷新回调
protocol PullToRefreshDataSource: class {
    func titleHeaderView() -> MainHeaderView
    func redLine() -> UIView
    func scrollView() -> UIScrollView
}
protocol PullToRefreshDelegate: class {
    func pullToRefreshViewWillRefresh(pullToRefreshView: PullToRefreshView)
    func pullToRefreshViewDidRefresh(pulllToRefreshView: PullToRefreshView)
}

// 控件的刷新状态
enum RefreshState {
    case  Normal                // 普通状态
    case  Pulling               // 松开就可以进行刷新的状态
    case  Refreshing            // 正在刷新中的状态
}

class PullToRefreshView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blackColor()
        
        self.addSubview(statusLabel)
        self.addSubview(activityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        frame = CGRect(x: 0, y: -sceneHeight, width: UIConstant.SCREEN_WIDTH, height: sceneHeight)
        self.statusLabel.frame = CGRect(x: 0, y: frame.height-25, width: UIConstant.SCREEN_WIDTH, height: 20)
        self.activityView.center = CGPoint(x: self.frame.size.width / 2, y: self.statusLabel.y - activityView.height )
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    /// 滚动器
    private var scrollView: UIScrollView!
    private var headerView: MainHeaderView!
    private var redLine: UIView!
    /// 下拉百分比
    private var progressPercentage: CGFloat = 0
    
    var dataSource: PullToRefreshDataSource? {
        willSet {
            if let newValue = newValue {
                headerView = newValue.titleHeaderView()
                redLine = newValue.redLine()
                scrollView = newValue.scrollView()
                scrollView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
                scrollView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.New, context: nil)
            }
        }
        
        didSet {
            if let oldValue = oldValue {
                oldValue.scrollView().removeObserver(self, forKeyPath: "contentOffset", context: nil)
                oldValue.scrollView().removeObserver(self, forKeyPath: "contentSize", context: nil)
            }
        }
    }
    /// 代理回调
    weak var delegate: PullToRefreshDelegate?
    // 上一个状态
    var oldState: RefreshState?
    // 当前状态
    var state: RefreshState = RefreshState.Normal {
        willSet {
            oldState = state
        }
        didSet {
            
            switch state {
            case RefreshState.Normal:
                self.statusLabel.text = "下拉即可刷新"
                
                if RefreshState.Refreshing == oldState {
                    self.activityView.hidden = true
                    self.redLine.hidden = false
                    
                    UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: {
                        self.scrollView.contentInset = UIEdgeInsetsZero
                        }, completion: { (_) in
                            self.setupNormalData()
                    })
                }
            case RefreshState.Pulling:
                self.statusLabel.text = "释放即可刷新"
            case RefreshState.Refreshing:
                self.redLine.hidden = true
                self.activityView.hidden = false
                self.activityView.startAnimation()
                self.statusLabel.text = "正在刷新..."
                
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue()) {
                    self.state = RefreshState.Normal
                    self.setupNormalData()
                    if let _ = self.delegate {
                        self.delegate?.pullToRefreshViewDidRefresh(self)
                    }
                }
                
                UIView.animateWithDuration(0.2, animations: {
                    let top: CGFloat = happenOffsetY
                    var inset: UIEdgeInsets = self.scrollView.contentInset
                    inset.top = top
                    self.scrollView.contentInset = inset
                    var offset:CGPoint = self.scrollView.contentOffset
                    offset.y = -top
                    self.scrollView.contentOffset = offset
                    }, completion: { (_) in
                        self.redLine.frame = CGRect(x: self.center.x, y: 0, width: 0, height: 1)
                })
            }
        }
    }
    
    // 状态标签
    private lazy var statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        statusLabel.textColor = UIColor.whiteColor()
        statusLabel.text = "下拉即可刷新"
        statusLabel.backgroundColor =  UIColor.clearColor()
        statusLabel.textAlignment = NSTextAlignment.Center
        return statusLabel
    }()
    
    /// 菊花
    private lazy var activityView: ActivityIndicatorView = {
        let activityView = ActivityIndicatorView()
        activityView.bounds = CGRect(origin: CGPointZero, size: CGSize(width: 30, height: 30))
        activityView.hidden = true
        return activityView
    }()
}

extension PullToRefreshView {
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let keyPath = keyPath where keyPath == "contentOffset"
        {
            // 如果处于刷新状态，直接退出
            guard state != RefreshState.Refreshing else {
                return
            }
            // 拿到当前contentoffset的y值
            let currentOffsetY : CGFloat = scrollView.contentOffset.y
            
            if (currentOffsetY > 0) {
                setupNormalData()
                return
            }
            if fabs(currentOffsetY) > 10 {
                setupRedLineAnimation()
            }
            setupHeaderViewAnimation()
                
            if scrollView.dragging {
                if fabs(currentOffsetY) > happenOffsetY && self.state == RefreshState.Normal {
                    state = RefreshState.Pulling
                } else if fabs(currentOffsetY) <= happenOffsetY && self.state == RefreshState.Pulling {
                    state = RefreshState.Normal
                }
            } else if self.state == RefreshState.Pulling {
                state = RefreshState.Refreshing
            }
        }
    }
    
    func setupRedLineAnimation() {
        let width = max(1,(1-progressPercentage)*40)
        let height = max(1,fabs(scrollView.contentOffset.y)-10)
        
        UIView.animateWithDuration(0.01, animations: {
            self.redLine.frame = CGRect(x: self.center.x-width*0.5, y: 0, width: width, height: height)
        })
    }
    
    func setupHeaderViewAnimation() {
        let refreshViewVisibleHeight = max(0, -(self.scrollView.contentOffset.y + scrollView.contentInset.top))
        progressPercentage = min(1, refreshViewVisibleHeight / happenOffsetY)
        headerView.alpha = min(1, max(1-progressPercentage/0.2, 0))
    }
    
    func setupNormalData() {
        UIView.animateWithDuration(0.1) {
            self.redLine.frame = CGRect(x: self.center.x-20, y: 0, width: 40, height: 1)
            self.headerView.alpha = 1
        }
    }
}

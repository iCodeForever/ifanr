//
//  HomeHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 添加3个UIImageVIew到scrollview
        contentScrollView.addSubview(currentItem)
        contentScrollView.addSubview(lastItem)
        contentScrollView.addSubview(nextItem)
        
        addSubview(contentScrollView)
        addSubview(pageControl)
        addSubview(tagImageView)
        
        // 添加点击事件
        let tap = UITapGestureRecognizer(target: self, action: #selector(HomeHeaderView.currentItemTap))
        currentItem.addGestureRecognizer(tap)
    }
    
    convenience init(frame: CGRect, modelArray: [CommonModel]!) {
        self.init(frame: frame)
        self.modelArray = modelArray
        
        pageControl.numberOfPage = self.modelArray.count
        // 默认显示第一张图片
        self.indexOfCurrentImage = 0
        // 设置uiimageview位置
        self.setScrollViewOfImage()
        contentScrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Event or Action --------------------------
    @objc fileprivate func currentItemTap() {
        if let callBack = callBack {
            callBack(indexOfCurrentImage)
        }
    }
    func currentItemDidClick(_ callBack: CurrentItemTapCallBack?) {
        self.callBack = callBack
    }
    //MARK: --------------------------- Private Methods --------------------------
    typealias CurrentItemTapCallBack = (_ index: Int) -> Void
    
    
    fileprivate var callBack: CurrentItemTapCallBack?
    /// 定时器，定时轮播图片
    fileprivate var timer : Timer?
    /**
     得到上一张图片的下标
     
     - parameter index: 当前图片下标位置
     
     - returns: 上一个图片标位置
     */
    fileprivate func getLastImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index - 1
        if tempIndex == -1 {
            return self.modelArray.count - 1
        } else {
            return tempIndex
        }
    }
    
    /**
     得到下一张图片的下标
     
     - parameter index: 当前图片下标位置
     
     - returns: 下一个图片下标位置
     */
    fileprivate func getNextImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index + 1
        return tempIndex < self.modelArray.count ? tempIndex : 0
    }
    
    
    /// 移除定时器
    fileprivate func removeTimer () {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// 启动定时器
    fileprivate func addTimer() {
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(HomeHeaderView.timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add((self.timer!), forMode: RunLoopMode.commonModes)
        }
    }
    //事件触发方法
    @objc fileprivate func timerAction() {
        contentScrollView.setContentOffset(CGPoint(x: self.width*2, y: 0), animated: true)
    }
    /**
     重新设置scrollview的图片
     */
    fileprivate func setScrollViewOfImage() {
        // 获取当前模型数据
        let currentModel = self.modelArray[self.indexOfCurrentImage]
        self.currentItem.imageURL = currentModel.image
        self.currentItem.title = currentModel.title
        self.currentItem.date = "\(currentModel.category) | \(Date.getCommonExpressionOfDate(currentModel.pubDate))"
        // 获取下一张图片的模型
        let nextImageModel = self.modelArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.nextItem.imageURL = nextImageModel.image
        self.nextItem.title = nextImageModel.title
        self.nextItem.date = "\(nextImageModel.category) | \(Date.getCommonExpressionOfDate(nextImageModel.pubDate))"
        // 获取上衣张图片的模型
        let lastImageModel = self.modelArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.lastItem.imageURL = lastImageModel.image
        self.lastItem.title = lastImageModel.title
        self.lastItem.date = "\(lastImageModel.category) | \(Date.getCommonExpressionOfDate(lastImageModel.pubDate)))"
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    fileprivate lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height-45))
        contentScrollView.isUserInteractionEnabled = false
        contentScrollView.bounces = false
        contentScrollView.isPagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.contentSize = CGSize(width: self.width * 3, height: 0)
        contentScrollView.delegate = self
        return contentScrollView
    }()
    
        /// 监听图片数组的变化，如果有变化立即刷新轮转图中显示的图片
    var modelArray: [CommonModel]! {
        
        willSet {
            self.modelArray = newValue
        }
        /**
         *  如果数据源改变，则需要改变scrollView、分页指示器的数量
         */
        didSet {
            if modelArray.count<=0 {
                return
            }
            contentScrollView.isUserInteractionEnabled = true
            contentScrollView.isScrollEnabled = !(modelArray.count == 1)
            pageControl.numberOfPage = self.modelArray.count
            setScrollViewOfImage()
            contentScrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
            tagImageView.isHidden = false
            // 启动定时器
            self.addTimer()
        }
    }
        /// 监听显示的第几张图片，来更新分页指示器
    var indexOfCurrentImage: Int! = 0{
        didSet {
            self.pageControl.currentPage = indexOfCurrentImage
        }
    }
    
        /// 当前显示的View
    fileprivate lazy var currentItem: HomeHeaderItem = {
        var currentItem: HomeHeaderItem = HomeHeaderItem()
        currentItem.frame = CGRect(x: self.width, y: 0, width: self.width, height: self.contentScrollView.height)
        return currentItem
    }()
        /// 上一个显示的View
    fileprivate lazy var lastItem: HomeHeaderItem = {
        var lastItem: HomeHeaderItem = HomeHeaderItem()
        lastItem.frame = CGRect(x: 0, y: 0, width: self.width, height: self.contentScrollView.height)
        return lastItem
    }()
        /// 下一个显示的View
    fileprivate lazy var nextItem: HomeHeaderItem = {
        var nextItem: HomeHeaderItem = HomeHeaderItem()
        nextItem.frame = CGRect(x: self.width * 2, y: 0, width: self.width, height: self.contentScrollView.height)
        return nextItem
    }()
    
    fileprivate lazy var pageControl: HomePageControl = {
        var pageControl = HomePageControl(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.contentScrollView.height-35, width: self.width, height: 20))
        return pageControl
    }()
    
        /// 最下面那张图片
    fileprivate lazy var tagImageView: UIImageView = {
        var tagImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 25))
        tagImageView.isHidden = true
        tagImageView.center = CGPoint(x: self.center.x, y: self.height-13)
        tagImageView.image = UIImage(imageLiteralResourceName: "tag_latest_press")
        tagImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tagImageView
    }()
}

extension HomeHeaderView: UIScrollViewDelegate {
    /**
     *  开始拖拽的时候调用
     */
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // 停止定时器(一旦定时器停止了,就不能再使用)
        self.removeTimer()
    }
    
    /**
     *  停止拖拽的时候调用
     */
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
        self.addTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        if offset == 0 {
            self.indexOfCurrentImage = self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        } else if offset == self.frame.size.width * 2 {
            self.indexOfCurrentImage = self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)
        }
        // 重新布局图片
        self.setScrollViewOfImage()
        //布局后把contentOffset设为中间
        scrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
}

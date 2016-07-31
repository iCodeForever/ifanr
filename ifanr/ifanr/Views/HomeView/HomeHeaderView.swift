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
    }
    
    convenience init(frame: CGRect, modelArray: [HomePopularModel]!) {
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
    
    //MARK: --------------------------- Private Methods --------------------------
    
    /// 定时器，定时轮播图片
    private var timer : NSTimer?
    /**
     得到上一张图片的下标
     
     - parameter index: 当前图片下标位置
     
     - returns: 上一个图片标位置
     */
    private func getLastImageIndex(indexOfCurrentImage index: Int) -> Int {
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
    private func getNextImageIndex(indexOfCurrentImage index: Int) -> Int {
        let tempIndex = index + 1
        return tempIndex < self.modelArray.count ? tempIndex : 0
    }
    
    
    /// 移除定时器
    private func removeTimer () {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    /// 启动定时器
    private func addTimer() {
        if self.timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(HomeHeaderView.timerAction), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer((self.timer!), forMode: NSRunLoopCommonModes)
        }
    }
    //事件触发方法
    @objc private func timerAction() {
        contentScrollView.setContentOffset(CGPointMake(self.width*2, 0), animated: true)
    }
    /**
     重新设置scrollview的图片
     */
    private func setScrollViewOfImage() {
        // 获取当前模型数据
        let currentModel = self.modelArray[self.indexOfCurrentImage]
        self.currentItem.imageURL = currentModel.commonModel.image
        self.currentItem.title = currentModel.commonModel.title
        self.currentItem.date = "\(currentModel.commonModel.category) | \(NSDate.getDate(currentModel.commonModel.pubDate))"
        // 获取下一张图片的模型
        let nextImageModel = self.modelArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.nextItem.imageURL = nextImageModel.commonModel.image
        self.nextItem.title = nextImageModel.commonModel.title
        self.nextItem.date = "\(nextImageModel.commonModel.category) | \(NSDate.getDate(nextImageModel.commonModel.pubDate))"
        // 获取上衣张图片的模型
        let lastImageModle = self.modelArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.lastItem.imageURL = lastImageModle.commonModel.image
        self.lastItem.title = lastImageModle.commonModel.title
        self.lastItem.date = "\(lastImageModle.commonModel.category) | \(NSDate.getDate(lastImageModle.commonModel.pubDate))"
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    private lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height-45))
        contentScrollView.userInteractionEnabled = false
        contentScrollView.bounces = false
        contentScrollView.pagingEnabled = true
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.contentSize = CGSize(width: self.width * 3, height: 0)
        contentScrollView.delegate = self
        return contentScrollView
    }()
    
        /// 监听图片数组的变化，如果有变化立即刷新轮转图中显示的图片
    var modelArray: [HomePopularModel]! {
        
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
            contentScrollView.userInteractionEnabled = true
            contentScrollView.scrollEnabled = !(modelArray.count == 1)
            pageControl.numberOfPage = self.modelArray.count
            setScrollViewOfImage()
            contentScrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
            tagImageView.hidden = false
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
    private lazy var currentItem: HomeHeaderItem = {
        var currentItem: HomeHeaderItem = HomeHeaderItem()
        currentItem.frame = CGRect(x: self.width, y: 0, width: self.width, height: self.contentScrollView.height)
        return currentItem
    }()
        /// 上一个显示的View
    private lazy var lastItem: HomeHeaderItem = {
        var lastItem: HomeHeaderItem = HomeHeaderItem()
        lastItem.frame = CGRect(x: 0, y: 0, width: self.width, height: self.contentScrollView.height)
        return lastItem
    }()
        /// 下一个显示的View
    private lazy var nextItem: HomeHeaderItem = {
        var nextItem: HomeHeaderItem = HomeHeaderItem()
        nextItem.frame = CGRect(x: self.width * 2, y: 0, width: self.width, height: self.contentScrollView.height)
        return nextItem
    }()
    
    private lazy var pageControl: HomePageControl = {
        var pageControl = HomePageControl(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.contentScrollView.height-35, width: self.width, height: 20))
        return pageControl
    }()
    
        /// 最下面那张图片
    private lazy var tagImageView: UIImageView = {
        var tagImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height: 25))
        tagImageView.hidden = true
        tagImageView.center = CGPoint(x: self.center.x, y: self.height-13)
        tagImageView.image = UIImage(imageLiteral: "tag_latest_press")
        tagImageView.contentMode = UIViewContentMode.ScaleAspectFit
        return tagImageView
    }()
}

extension HomeHeaderView: UIScrollViewDelegate {
    /**
     *  开始拖拽的时候调用
     */
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        // 停止定时器(一旦定时器停止了,就不能再使用)
        self.removeTimer()
    }
    
    /**
     *  停止拖拽的时候调用
     */
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
        self.addTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
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
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
}

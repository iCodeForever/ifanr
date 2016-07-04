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
        contentScrollView.addSubview(currentImageView)
        contentScrollView.addSubview(lastImageView)
        contentScrollView.addSubview(nextImageView)
        
        addSubview(contentScrollView)
        addSubview(pageControl)
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
    
    /**
     重新设置scrollview的图片
     */
    private func setScrollViewOfImage() {
        // 获取当前模型数据
        let currentModel = self.modelArray[self.indexOfCurrentImage]
        self.currentImageView.if_setImage(NSURL(string: currentModel.image))
        // 获取下一张图片的模型
        let nextImageModel = self.modelArray[self.getNextImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.nextImageView.if_setImage(NSURL(string: nextImageModel.image))
        // 获取上衣张图片的模型
        let lastImageModle = self.modelArray[self.getLastImageIndex(indexOfCurrentImage: self.indexOfCurrentImage)]
        self.lastImageView.if_setImage(NSURL(string: lastImageModle.image))
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    private lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView(frame: self.bounds)
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
            contentScrollView.scrollEnabled = !(modelArray.count == 1)
            pageControl.numberOfPage = self.modelArray.count
            setScrollViewOfImage()
            contentScrollView.setContentOffset(CGPoint(x: self.width, y: 0), animated: false)
        }
    }
        /// 监听显示的第几张图片，来更新分页指示器
    var indexOfCurrentImage: Int! = 0{
        didSet {
            self.pageControl.currentPage = indexOfCurrentImage
        }
    }
    
        /// 当前显示的View
    private lazy var currentImageView: UIImageView = {
        var currentImageView: UIImageView = UIImageView()
        currentImageView.frame = CGRect(x: self.width, y: 0, width: self.width, height: self.height)
        currentImageView.contentMode = UIViewContentMode.ScaleAspectFill
        return currentImageView
    }()
        /// 上一个显示的View
    private lazy var lastImageView: UIImageView = {
        var lastImageView: UIImageView = UIImageView()
        lastImageView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        lastImageView.contentMode = UIViewContentMode.ScaleAspectFill
        return lastImageView
    }()
        /// 下一个显示的View
    private lazy var nextImageView: UIImageView = {
        var nextImageView: UIImageView = UIImageView()
        nextImageView.frame = CGRect(x: self.width * 2, y: 0, width: self.width, height: self.height)
        nextImageView.contentMode = UIViewContentMode.ScaleAspectFill
        return nextImageView
    }()
    
    private lazy var pageControl: HomePageControl = {
        var pageControl = HomePageControl(frame: CGRect(x: UIConstant.UI_MARGIN_10, y: self.height-40, width: self.width, height: 25))
        return pageControl
    }()
}

extension HomeHeaderView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        //如果用户手动拖动到了一个整数页的位置就不会发生滑动了 所以需要判断手动调用滑动停止滑动方法
        if !decelerate {
            self.scrollViewDidEndDecelerating(scrollView)
        }
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

//
//  MainViewController.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/29.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

/**
 主界面 这个控制器用来控制 首页，玩物志，快讯,Appso,MindStore和菜单界面
 */

import UIKit

class MainViewController: UIViewController {
    
    //MARK: --------------------------- Life Cycle --------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor()
        self.view.addSubview(collectionView)
        self.view.addSubview(fpsLabel)
        
        // 添加根控制器
        self.addrootViewController()
        
        self.view.addSubview(headerView)
        self.view.addSubview(self.hamburgButton)
        self.view.addSubview(self.circleButton)
        
        self.setUpLayout()

        self.view.addSubview(redLine)
    }
    
    /**
     隐藏状态栏
     */
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: --------------------------- Private Methods --------------------------

    /**
     添加跟控制器
     */
    private func addrootViewController() {
        homeViewController.scrollViewReusable = self
        self.addChildViewController(newsFlashController)
        self.addChildViewController(homeViewController)
        self.addChildViewController(playzhiController)
        self.addChildViewController(appSoController)
        self.addChildViewController(mindStoreController)
    
        viewArray.append(newsFlashController.view)
        viewArray.append(homeViewController.view)
        viewArray.append(playzhiController.view)
        viewArray.append(appSoController.view)
        viewArray.append(mindStoreController.view)
    }
    
    // 布局
    private func setUpLayout() {
        self.hamburgButton.snp_makeConstraints { (make) in
            make.right.equalTo(-15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
        self.circleButton.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(35)
            make.width.height.equalTo(45)
        }
    }
    
    
    //MARK: --------------------------- Getter and Setter --------------------------
    // 首页
    let homeViewController = HomeViewController()
    // 快讯
    let newsFlashController = NewsFlashController()
    // Appso
    let appSoController = AppSoViewController()
    // 玩物志
    let playzhiController = PlayingZhiController()
    // MindStore
    let mindStoreController = MindStoreViewController()
    
    var viewArray = [UIView]()
    
        /// fps标签
    private lazy var fpsLabel: YYFPSLabel = {
        var fpsLabel: YYFPSLabel = YYFPSLabel(frame: CGRect(x: UIConstant.UI_MARGIN_20, y: self.view.height-40, width: 0, height: 0))
        fpsLabel.sizeToFit()
        return fpsLabel
    }()
    
    private lazy var headerView: MainHeaderView = {
        var headerView: MainHeaderView = MainHeaderView(frame: CGRect(x: 0, y: 0, width: 5*UIConstant.SCREEN_WIDTH, height: 20))
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .Horizontal
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.itemSize = CGSize(width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.view.width, height: self.view.height-UIConstant.UI_MARGIN_20), collectionViewLayout: collectionLayout)
        collectionView.registerClass(MainCollectionViewCell.self)
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView;
    }()
    

    private lazy var hamburgButton : UIButton = {
        let hamburgButton = UIButton()
        hamburgButton.setImage(UIImage(imageLiteral:"ic_hamburg"), forState: .Normal)
        
        return hamburgButton
    }()
    
    private lazy var circleButton: UIButton = {
        let circleButton = UIButton()
        circleButton.setImage(UIImage(imageLiteral: "ic_circle"), forState: .Normal)
        
        return circleButton
    }()

        /// 顶部红线
    private lazy var redLine: UIView = {
        let redLine = UIView()
        redLine.frame = CGRect(x: self.view.center.x-20, y: 0, width: 40, height: 1)
        redLine.backgroundColor = UIConstant.UI_COLOR_RedTheme
        return redLine
    }()
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath) as MainCollectionViewCell
        cell.childVCView = viewArray[indexPath.row]
        return cell
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scale = self.view.width/(self.view.width*0.5-headerView.labelArray.last!.width*0.5)
        headerView.x = -scrollView.contentOffset.x/scale
    }
}

// MARK: - 这里传headerView给下拉刷新控件做处理
extension MainViewController: ScrollViewControllerReusableDataSource {
    func titleHeaderView() -> MainHeaderView {
        return self.headerView
    }
    
    func redLineView() -> UIView {
        return self.redLine
    }
}
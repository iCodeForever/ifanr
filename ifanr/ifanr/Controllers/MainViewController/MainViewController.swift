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
        self.view.addSubview(collectionView)
        self.view.addSubview(fpsLabel)
        
        // 添加根控制器
        self.addrootViewController()
    }
    
    //MARK: --------------------------- Private Methods --------------------------

    /**
     添加跟控制器
     */
    private func addrootViewController() {
        let homeViewController  = HomeViewController()
        let newsFlashController = NewsFlashController()
        let appSoViewController = AppSoViewController()
        let playingZhiController    = PlayingZhiController()
        let mindStoreViewController = MindStoreViewController()
        
        self.addChildViewController(newsFlashController)
        self.addChildViewController(homeViewController)
        self.addChildViewController(playingZhiController)
        self.addChildViewController(appSoViewController)
        self.addChildViewController(mindStoreViewController)
        
        viewArray.append(newsFlashController.view)
        viewArray.append(homeViewController.view)
        viewArray.append(playingZhiController.view)
        viewArray.append(appSoViewController.view)
        viewArray.append(mindStoreViewController.view)
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var viewArray = [UIView]()
    private lazy var fpsLabel: YYFPSLabel = {
        var fpsLabel: YYFPSLabel = YYFPSLabel(frame: CGRect(x: UIConstant.UI_MARGIN_20, y: self.view.height-40, width: 0, height: 0))
        fpsLabel.sizeToFit()
        return fpsLabel
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .Horizontal
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.itemSize = self.view.size
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionLayout)
        collectionView.registerClass(MainCollectionViewCell.self)
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView;
    }()
}


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mainviewcontrollerid", forIndexPath: indexPath)
        cell.contentView.addSubview(viewArray[indexPath.row])
//        cell.addSubview(viewArray[indexPath.row])
        return cell
    }
}
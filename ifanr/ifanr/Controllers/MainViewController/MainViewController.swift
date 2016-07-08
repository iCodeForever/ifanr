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
        
        // 添加根控制器
        self.addrootViewController()
    }
    
    //MARK: --------------------------- Private Methods --------------------------

    /**
     添加跟控制器
     */
    private func addrootViewController() {
        let homeViewController = HomeViewController()
        let newsFlashController = NewsFlashController()
        self.addChildViewController(homeViewController)
        self.addChildViewController(newsFlashController)
        viewArray.append(homeViewController.view)
        viewArray.append(newsFlashController.view)
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    var viewArray = [UIView]()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .Horizontal
        
        collectionLayout.itemSize = self.view.size
        var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: collectionLayout)
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "mainviewcontrollerid")
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
        cell.addSubview(viewArray[indexPath.row])
        return cell
    }
}
//
//  HomeClassfiyView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/25.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import Foundation

class CategoryView: UIView {
    
    typealias CoverBtnCallBack = () -> Void
    private var callBack: CoverBtnCallBack?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(coverButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func coverBtnDidClick() {
        if let callBack = callBack {
            callBack()
        }
    }
    
    func coverBtnClick(callBack: CoverBtnCallBack) {
        self.callBack = callBack
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.headerReferenceSize = CGSize(width: self.width, height: 70)
        collectionLayout.scrollDirection = .Vertical
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        // 100:81
        let itemWidth = (UIConstant.SCREEN_WIDTH-4*UIConstant.UI_MARGIN_10)/3
        let itemHeight = itemWidth*81/100
        collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.width, height: self.height*0.8), collectionViewLayout: collectionLayout)
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CategoryViewCell.self)
        collectionView.registerClass(CategoryMenuHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        titleLabel.origin = CGPointZero
        titleLabel.size = CGSize(width: self.width, height: 20)
        titleLabel.text = "更多栏目"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        return titleLabel
    }()
    
    private lazy var coverButton: UIButton = {
        let coverButton = UIButton()
        coverButton.origin = CGPoint(x: 0, y: self.collectionView.frame.maxY)
        coverButton.size = CGSize(width: self.width, height: self.height-self.collectionView.frame.maxY)
        coverButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        coverButton.addTarget(self, action: #selector(CategoryView.coverBtnDidClick), forControlEvents: .TouchDown)
        return coverButton
    }()
    
    
}

extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryModelArray.count
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let cell = cell as! CategoryViewCell
        cell.model = CategoryModelArray[indexPath.row]
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(indexPath) as CategoryViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, indexPath: indexPath) as CategoryMenuHeaderView 
        
        return headerView
    }
}


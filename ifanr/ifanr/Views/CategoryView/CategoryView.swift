//
//  HomeClassfiyView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/25.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

class CategoryView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        addSubview(headerView)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height), collectionViewLayout: collectionLayout)
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CategoryViewCell.self)
        collectionView.registerClass(CategoryMenuHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    class CategoryMenuTitleHeaderView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
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


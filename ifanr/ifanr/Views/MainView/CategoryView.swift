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
        self.backgroundColor = UIColor.whiteColor()
        
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .Horizontal
        collectionLayout.minimumLineSpacing = UIConstant.UI_MARGIN_10
        // 100:81
        let itemWidth = (self.width-4*UIConstant.UI_MARGIN_10)/3
        let itemHeight = itemWidth*81/100
        collectionLayout.itemSize = CGSize(width: itemHeight, height: self.height)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.width, height: self.height-UIConstant.UI_MARGIN_20), collectionViewLayout: collectionLayout)
        collectionView.registerClass(CategoryViewCell.self)
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
}
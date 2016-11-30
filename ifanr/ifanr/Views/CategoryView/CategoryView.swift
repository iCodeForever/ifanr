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
    typealias ItemDidClickCallBack = (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> Void
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(coverButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func coverBtnDidClick() {
        if let callBack = coverbtnClickCallBack {
            callBack()
        }
    }
    
    fileprivate var coverbtnClickCallBack: CoverBtnCallBack?
    fileprivate var itemDidClickCallBack: ItemDidClickCallBack?
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.headerReferenceSize = CGSize(width: self.width, height: 70)
        collectionLayout.scrollDirection = .vertical
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        // 100:81
        let itemWidth = (UIConstant.SCREEN_WIDTH-4*UIConstant.UI_MARGIN_10)/3
        let itemHeight = itemWidth*81/100
        collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: UIConstant.UI_MARGIN_20, width: self.width, height: self.height*0.8), collectionViewLayout: collectionLayout)
        collectionView.bounces = true
        collectionView.backgroundColor = UIColor.white
        collectionView.registerClass(CategoryViewCell.self)
        collectionView.registerClass(CategoryMenuHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 10)
        titleLabel.origin = CGPoint.zero
        titleLabel.size = CGSize(width: self.width, height: 20)
        titleLabel.text = "更多栏目"
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    fileprivate lazy var coverButton: UIButton = {
        let coverButton = UIButton()
        coverButton.origin = CGPoint(x: 0, y: self.collectionView.frame.maxY)
        coverButton.size = CGSize(width: self.width, height: self.height-self.collectionView.frame.maxY)
        coverButton.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        coverButton.addTarget(self, action: #selector(CategoryView.coverBtnDidClick), for: .touchDown)
        return coverButton
    }()
    
    
}

extension CategoryView {
    func coverBtnClick(_ callBack: @escaping CoverBtnCallBack) {
        self.coverbtnClickCallBack = callBack
    }
    
    func itemDidClick(_ callBack: @escaping ItemDidClickCallBack) {
        self.itemDidClickCallBack = callBack
    }
}


extension CategoryView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CategoryModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CategoryViewCell
        cell.model = CategoryModelArray[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(indexPath) as CategoryViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, indexPath: indexPath) as CategoryMenuHeaderView 
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let callBack = itemDidClickCallBack {
            callBack(collectionView, indexPath)
        }
    }
}


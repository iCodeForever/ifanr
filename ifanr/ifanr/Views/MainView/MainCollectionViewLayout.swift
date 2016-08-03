//
//  MainCollectionViewLayout.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/3.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class MainCollectionViewLayout: UICollectionViewFlowLayout {
    override init () {
        super.init()
        let itemHeight = UIConstant.SCREEN_HEIGHT-UIConstant.UI_MARGIN_20
        itemSize = CGSize(width: UIConstant.SCREEN_WIDTH, height: itemHeight)
//        sectionInset = UIEdgeInsets(top: UIConstant.SCREEN_HEIGHT*0.6-20, left: 10, bottom: 0, right: 10)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = .Horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
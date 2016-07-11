//
//  MainCollectionViewCell.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/11.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class MainCollectionViewCell: UICollectionViewCell, Reusable {
    
    var childVCView: UIView! {
        didSet {
            self.contentView.addSubview(childVCView)
            childVCView.snp_makeConstraints { (make) in
                make.left.equalTo(self.contentView).offset(2)
                make.right.equalTo(self.contentView).offset(-2)
                make.top.bottom.equalTo(self.contentView)
            }
        }
    }
}
//
//  HomeHeaderItem.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeaderItem: UICollectionViewCell, Reusable {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(bgImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var image: UIImage! {
        didSet {
            self.bgImageView.image = image
        }
    }
    
    private lazy var bgImageView: UIImageView = {
        var bgImageView: UIImageView = UIImageView(frame: self.contentView.bounds)
        bgImageView.contentMode = .ScaleAspectFit
        return bgImageView;
    }()
}

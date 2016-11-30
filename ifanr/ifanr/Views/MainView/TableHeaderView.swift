//
//  TableHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/19.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import Foundation

class TableHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(backgroundImageView)
        self.addSubview(titleLabel)
        self.addSubview(detailTitleLabel)
        self.addSubview(tagImageView)
    }
    
    convenience init(model: TableHeaderModel) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIConstant.SCREEN_WIDTH, height:  180 * UIConstant.SCREEN_HEIGHT / UIConstant.IPHONE5_HEIGHT))
        self.backgroundImageView.image = model.backImage
        self.titleLabel.text = model.title
        self.detailTitleLabel.text = model.detail
        tagImageView.image = model.tagImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        /// 背景图
    fileprivate lazy var backgroundImageView: UIImageView = {
        let backgroundImageView   = UIImageView(frame: CGRect(x: 0, y: -1, width: self.width, height: 120 * UIConstant.SCREEN_HEIGHT/UIConstant.IPHONE5_HEIGHT))
        backgroundImageView.backgroundColor = UIColor.black
        backgroundImageView.contentMode = .scaleAspectFit
        return backgroundImageView
    }()
    
        /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel  = UILabel(frame: CGRect(x: 20, y: 10, width: self.width, height: 40))
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 22)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
        /// 副标题
    fileprivate lazy var detailTitleLabel: UILabel = {
        let detailTitleLabel    = UILabel(frame: CGRect(x: 20, y: self.titleLabel.bottom, width: self.width, height: 30))
        detailTitleLabel.font   = UIFont.customFont_FZLTZCHJW(fontSize: 14)
        detailTitleLabel.textColor = UIColor.white
        return detailTitleLabel
    }()
    
        /// 底部图片
    fileprivate lazy var tagImageView: UIImageView = {
        let tagImageView = UIImageView(frame: CGRect(x: 0, y: self.backgroundImageView.bottom + UIConstant.UI_MARGIN_20, width: UIConstant.SCREEN_WIDTH, height: 25))
        
        tagImageView.contentMode = UIViewContentMode.scaleAspectFit
        return tagImageView
    }()
}

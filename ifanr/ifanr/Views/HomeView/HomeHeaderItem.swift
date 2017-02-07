//
//  HomeHeaderItem.swift
//  ifanr
//
//  Created by 梁亦明 on 16/7/2.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeaderItem: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(bgImageView)
        self.addSubview(dateLabel)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImageView.frame = self.bounds
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    
        /// 给外部传入url
    var imageURL: String? {
        didSet {
            if let url = imageURL {
                self.bgImageView.if_setImage(URL(string: url))
            }
        }
    }
    
    var title: String! {
        didSet {
            titleLabel.text = title
            // 计算高度
            let attributes = [NSFontAttributeName: UIFont.customFont_FZLTXIHJW(fontSize: 18)]
            let titleHeight = (title as NSString).boundingRect(with: CGSize(width: self.width-2*UIConstant.UI_MARGIN_10, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: attributes, context: nil).height
            titleLabel.frame = CGRect(x: UIConstant.UI_MARGIN_10, y: self.height-50-titleHeight, width: self.width-2*UIConstant.UI_MARGIN_10, height: titleHeight)
            dateLabel.frame = CGRect(x: UIConstant.UI_MARGIN_10, y: titleLabel.y-25, width:self.width-2*UIConstant.UI_MARGIN_10, height: 20)
        }
    }
    
    var date: String! {
        didSet {
            dateLabel.text = date
        }
    }
        /// 标题
    fileprivate lazy var titleLabel: UILabel = {
        var titleLabel: UILabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 18)
        titleLabel.textColor = UIColor.white
        return titleLabel
    }()
    
        /// 分类和日期
    fileprivate lazy var dateLabel : UILabel = {
        var dateLabel: UILabel = UILabel()
        dateLabel.font = UIFont.customFont_FZLTXIHJW(fontSize: 12)
        dateLabel.textColor = UIColor.white
        return dateLabel
    }()
    
        /// 图片
    fileprivate lazy var bgImageView: UIImageView = {
        var bgImageView: UIImageView = UIImageView()
        bgImageView.contentMode = .scaleToFill
        return bgImageView
    }()
}

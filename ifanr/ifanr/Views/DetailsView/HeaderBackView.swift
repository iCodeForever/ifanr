//
//  HeaderBackView.swift
//  ifanr
//
//  Created by sys on 16/7/22.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate {
    func backButtonDidClick()
}

class HeaderBackView: UIView {
    
    private var title: String?
    var delegate: HeaderViewDelegate?
    
    convenience init(title: String) {
        self.init()
        self.title = title
        
        self.addSubview(self.backButton)
        self.addSubview(self.titleLabel)
        
        self.backgroundColor = UIColor.whiteColor()
        self.setupLayout()
    }
    
    //MARK:-----Setter and Getter-----
    private lazy var backButton: UIButton = {
        let backButton: UIButton = UIButton()
        backButton.setImage(UIImage(imageLiteral: "ic_article_back"), forState: .Normal)
        backButton.imageView?.contentMode = .ScaleAspectFill
        backButton.addTarget(self, action: #selector(goback), forControlEvents: .TouchUpInside)
        return backButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel: UILabel = UILabel()
        titleLabel.text = self.title
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 14)
        return titleLabel
    }()
    
    //MARK:-----Action Event-----
    @objc private func goback() {
        self.delegate?.backButtonDidClick()
    }
    
    //MARK:-----Custom Function-----
    private func setupLayout() {
        backButton.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(15)
            make.centerY.equalTo(self)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.backButton.snp_right).offset(10)
            make.centerY.equalTo(self)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
}
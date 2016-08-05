//
//  SettingHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/8/5.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit


class SettingHeaderView: UIView {
    typealias BackBtnClickCallBack = () -> Void
    var callBack: BackBtnClickCallBack?
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backBtn)
        addSubview(titleLabel)
        
        backBtn.snp_makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.size.equalTo(CGSize(width: 50, height: 15))
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.centerY.equalTo(backBtn.snp_centerY)
            make.height.equalTo(20)
        }
    }
    func backBtnDidClick(callBack: BackBtnClickCallBack?) {
        self.callBack = callBack
    }
    @objc private func backBtnDidClick() {
        if let callBack = callBack {
            callBack()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backBtn: UIButton = {
        var backBtn = UIButton()
        backBtn.setImage(UIImage(named: "ic_back"), forState: .Normal)
        backBtn.addTarget(self, action: #selector(SettingHeaderView.backBtnDidClick as (SettingHeaderView) -> () -> ()), forControlEvents: .TouchUpInside)
        backBtn.imageView?.contentMode = .ScaleAspectFit
        return backBtn
    }()
    
    private lazy var titleLabel: UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "设置"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont.customFont_FZLTZCHJW(fontSize: 16)
        return titleLabel
    }()
}
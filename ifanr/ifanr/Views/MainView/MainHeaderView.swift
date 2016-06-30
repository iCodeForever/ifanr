//
//  MainHeaderView.swift
//  ifanr
//
//  Created by 梁亦明 on 16/6/30.
//  Copyright © 2016年 ifanrOrg. All rights reserved.
//

import UIKit
import SnapKit
 /// 主界面 顶部控件

class MainHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 添加控件
        addSubview(logoImageView)
        addSubview(searchBtn)
        addSubview(settingBtn)
        
        // 适配  宽高187/48  30
        logoImageView.snp_makeConstraints { [unowned self](make) in
            make.left.equalTo(self).offset(UIConstant.UI_MARGIN_20)
            make.height.equalTo(30)
            make.width.equalTo(187/48*30)
            make.centerY.equalTo(self.snp_centerY)
        }
        
        // 设置按钮
        settingBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self).inset(UIConstant.UI_MARGIN_20)
            make.centerY.equalTo(self.logoImageView)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        // 搜索按钮
        searchBtn.snp_makeConstraints { (make) in
            make.right.equalTo(self.settingBtn.snp_left).offset(-30)
            make.top.equalTo(self.settingBtn)
            make.size.equalTo(settingBtn)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: --------------------------- Getter and Setter --------------------------
    
    private lazy var logoImageView: UIImageView = {
        var logoImageView : UIImageView = UIImageView(image: UIImage(named: "ic_profile_logo"))
        logoImageView.contentMode = .ScaleAspectFit
        return logoImageView
    }()
    
        /// 搜索按钮
    private lazy var searchBtn: UIButton = {
        var searchBtn: UIButton = UIButton()
        searchBtn.setImage(UIImage(named: "ic_search"), forState: .Normal)
        return searchBtn
    }()
    
        /// 设置按钮
    private lazy var settingBtn: UIButton = {
        var settingBtn: UIButton = UIButton()
        settingBtn.setImage(UIImage(named: "ic_setting"), forState: .Normal)
        return settingBtn
    }()
}
